-include .env
export

HUGO := hugo
PUBLIC := public
RESOURCES_GEN := resources/_gen

.DEFAULT_GOAL := help

.PHONY: help build serve clean deploy deploy-dry

help:
	@echo "Targets disponibles :"
	@echo "  make serve       Serveur de développement local (http://localhost:1313)"
	@echo "  make build       Construit le site dans public/"
	@echo "  make clean       Supprime public/ et resources/_gen/"
	@echo "  make deploy      Build + déploiement FTP via lftp (requiert .env)"
	@echo "  make deploy-dry  Simule le déploiement sans transférer"

build:
	$(HUGO) --minify

serve:
	$(HUGO) server -D

clean:
	rm -rf $(PUBLIC) $(RESOURCES_GEN)

deploy: build
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	lftp -c "open -u $(FTP_USER),$(FTP_PASS) $(FTP_HOST); mirror --reverse --delete --verbose $(PUBLIC)/ $(FTP_PATH)"

deploy-dry: build
	@test -n "$(FTP_HOST)" || (echo "Erreur : FTP_HOST manquant dans .env" && exit 1)
	lftp -c "open -u $(FTP_USER),$(FTP_PASS) $(FTP_HOST); mirror --reverse --delete --verbose --dry-run $(PUBLIC)/ $(FTP_PATH)"
