-include .env
export

SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -c

HUGO := hugo
PUBLIC := public
RESOURCES_GEN := resources/_gen

# Environnement : make <cible> ENV=prod|preprod (prod par défaut)
ENV ?= prod

# Mode de make serve : DEBUG=true affiche aussi les brouillons (draft: true) et les articles à date future
DEBUG ?= false
ifeq ($(DEBUG),true)
  SERVE_FLAGS := -D -F
else ifeq ($(DEBUG),false)
  SERVE_FLAGS :=
else
  $(error DEBUG doit valoir "true" ou "false" (reçu : "$(DEBUG)"))
endif

ifeq ($(ENV),prod)
  DEST := $(FTP_PATH)
  HUGO_ENV_FLAGS :=
  # preprod/ vit sous www/ : ne jamais le supprimer lors d'un déploiement de production
  MIRROR_EXCLUDES := --exclude __hidden/ --exclude preprod/
else ifeq ($(ENV),preprod)
  DEST := $(PREPROD_FTP_PATH)
  HUGO_ENV_FLAGS := --environment preprod --baseURL "$(PREPROD_URL)"
  MIRROR_EXCLUDES := --exclude __hidden/
else
  $(error ENV doit valoir "prod" ou "preprod" (reçu : "$(ENV)"))
endif

# Déploiement en SFTP (SSH, port 22), comme FileZilla. Le FTP d'OVH refuse
# par intermittence la connexion de données.
LFTP_SET := set sftp:auto-confirm yes

# Masque le mot de passe dans les URL sftp:// affichées par lftp
MASK := sed -E 's\#(sftp://[^:]+):[^@]+@\#\1:***@\#g'

.DEFAULT_GOAL := help

.PHONY: help build check serve clean deploy deploy-dry ftp _env

# Vérifie les variables de .env nécessaires à l'environnement choisi
_env:
ifeq ($(ENV),preprod)
	@test -n "$(PREPROD_FTP_PATH)" || (echo "Erreur : PREPROD_FTP_PATH manquant dans .env" && exit 1)
	@test -n "$(PREPROD_URL)" || (echo "Erreur : PREPROD_URL manquant dans .env" && exit 1)
else
	@test -n "$(FTP_PATH)" || (echo "Erreur : FTP_PATH manquant dans .env" && exit 1)
endif

help:
	@echo "Targets disponibles (ENV=prod|preprod, prod par défaut) :"
	@echo "  make serve       Serveur local http://localhost:1313 (DEBUG=true : brouillons et dates futures visibles)"
	@echo "  make build       Construit le site dans public/ (ex. make build ENV=preprod)"
	@echo "  make check       Build + vérifie que public/ ne contient que le site"
	@echo "  make clean       Supprime public/ et resources/_gen/"
	@echo "  make deploy      Check + déploiement SFTP via lftp (ex. make deploy ENV=preprod)"
	@echo "  make deploy-dry  Simule le déploiement sans transférer"
	@echo "  make ftp         Ouvre une session lftp interactive (requiert .env)"

build: _env
	$(HUGO) --minify --cleanDestinationDir $(HUGO_ENV_FLAGS)
ifeq ($(ENV),preprod)
	@rm -f $(PUBLIC)/robots.txt
	@printf '\n<IfModule mod_headers.c>\n  Header set X-Robots-Tag "noindex, nofollow"\n</IfModule>\n' >> $(PUBLIC)/.htaccess
endif

# Refuse un public/ contenant des sources ou des originaux (png, jpg, md, yaml)
check: build
	@bad=$$(find $(PUBLIC) -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.md' -o -name '*.yaml' \)); \
	if [ -n "$$bad" ]; then echo "Fichiers inattendus dans $(PUBLIC)/ :"; echo "$$bad"; exit 1; fi
ifeq ($(ENV),preprod)
	@missing=$$(grep -rL 'name=robots content="noindex, nofollow"\|name=robots content=noindex,nofollow\|http-equiv=' $(PUBLIC) --include='*.html'); \
	if [ -n "$$missing" ]; then echo "Meta noindex manquante (preprod) :"; echo "$$missing"; exit 1; fi; \
	grep -q 'X-Robots-Tag' $(PUBLIC)/.htaccess || (echo "X-Robots-Tag manquant dans $(PUBLIC)/.htaccess (preprod)" && exit 1); \
	test ! -f $(PUBLIC)/robots.txt || (echo "robots.txt présent en preprod (inutile dans un sous-répertoire)" && exit 1)
else
	@grep -q '^Sitemap: https://' $(PUBLIC)/robots.txt || (echo "robots.txt (avec Sitemap) manquant dans le build de production" && exit 1)
	@# Les pages d'alias générées par Hugo (redirections, http-equiv) portent déjà leur propre noindex
	@if grep -rL 'http-equiv=' $(PUBLIC) --include='*.html' | xargs -r grep -li 'noindex' | grep -q . || grep -q 'X-Robots-Tag' $(PUBLIC)/.htaccess; then echo "noindex présent dans le build de production"; exit 1; fi
endif
	@echo "Environnement : $(ENV) → destination SFTP : $(DEST)"
	@echo "Contenu de $(PUBLIC)/ :"; find $(PUBLIC) -type f | sort | sed 's/^/  /'

serve:
	$(HUGO) server $(SERVE_FLAGS)

clean:
	rm -rf $(PUBLIC) $(RESOURCES_GEN)

deploy: check
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	@lftp -c "$(LFTP_SET); open -u $(FTP_USER),$(FTP_PASS) sftp://$(FTP_HOST); mirror --reverse --delete $(MIRROR_EXCLUDES) --verbose=1 $(PUBLIC)/ $(DEST)" 2>&1 | $(MASK)

deploy-dry: check
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	@lftp -c "$(LFTP_SET); open -u $(FTP_USER),$(FTP_PASS) sftp://$(FTP_HOST); mirror --reverse --delete $(MIRROR_EXCLUDES) --verbose=1 --dry-run $(PUBLIC)/ $(DEST)" 2>&1 | $(MASK)

ftp: _env
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	@lftp -e "$(LFTP_SET); set cmd:prompt \"lftp> \"; cd $(DEST)" -u $(FTP_USER),$(FTP_PASS) sftp://$(FTP_HOST)
