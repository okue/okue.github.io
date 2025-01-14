.PHONY: deploy

readme:
	cat ./README.md
	@echo "\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"
	cat ./Makefile

help:
	make readme

serve:
	poetry run mkdocs serve

deploy:
	poetry run mkdocs gh-deploy
	@open 'https://github.com/okue/okue.github.io/deployments'
