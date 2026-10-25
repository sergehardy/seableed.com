-include .env
export

HUGO := hugo
PUBLIC := public
RESOURCES_GEN := resources/_gen

# Déploiement en SFTP (SSH, port 22), comme FileZilla. Le FTP d'OVH refuse
# par intermittence la connexion de données.
LFTP_SET := set sftp:auto-confirm yes

.DEFAULT_GOAL := help

.PHONY: help build check serve clean deploy deploy-dry ftp

help:
	@echo "Targets disponibles :"
	@echo "  make serve       Serveur de développement local (http://localhost:1313)"
	@echo "  make build       Construit le site dans public/ (nettoie les anciens fichiers)"
	@echo "  make check       Build + vérifie que public/ ne contient que le site"
	@echo "  make clean       Supprime public/ et resources/_gen/"
	@echo "  make deploy      Build + déploiement FTP via lftp (requiert .env)"
	@echo "  make deploy-dry  Simule le déploiement sans transférer"
	@echo "  make ftp         Ouvre une session lftp interactive (requiert .env)"

build:
	$(HUGO) --minify --cleanDestinationDir

# Refuse un public/ contenant des sources ou des originaux (png, jpg, md, yaml)
check: build
	@bad=$$(find $(PUBLIC) -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.md' -o -name '*.yaml' \)); \
	if [ -n "$$bad" ]; then echo "Fichiers inattendus dans $(PUBLIC)/ :"; echo "$$bad"; exit 1; fi
	@echo "Contenu de $(PUBLIC)/ :"; find $(PUBLIC) -type f | sort | sed 's/^/  /'

serve:
	$(HUGO) server -D

clean:
	rm -rf $(PUBLIC) $(RESOURCES_GEN)

deploy: check
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	@lftp -c "$(LFTP_SET); open -u $(FTP_USER),$(FTP_PASS) sftp://$(FTP_HOST); mirror --reverse --delete --exclude __hidden/ --verbose $(PUBLIC)/ $(FTP_PATH)"

deploy-dry: check
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	@lftp -c "$(LFTP_SET); open -u $(FTP_USER),$(FTP_PASS) sftp://$(FTP_HOST); mirror --reverse --delete --exclude __hidden/ --verbose --dry-run $(PUBLIC)/ $(FTP_PATH)"

ftp:
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	@lftp -e "$(LFTP_SET); set cmd:prompt \"lftp> \"; cd $(FTP_PATH)" -u $(FTP_USER),$(FTP_PASS) sftp://$(FTP_HOST)
