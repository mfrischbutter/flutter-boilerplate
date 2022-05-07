help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@flutter clean
	@flutter pub get

watch: ## Watches the files for changes
	@echo "╠ Watching the project..."
	@flutter pub run build_runner watch --delete-conflicting-outputs

gen: ## Generates the assets
	@echo "╠ Generating the assets..."
	@flutter pub get
	@flutter packages pub run build_runner build

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .
	@flutter pub run import_sorter:main
	@flutter format lib

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@flutter pub upgrade

run: ## Runs the mobile application in production
	@echo "╠ Running the app"
	@flutter run --flavor development -t lib/main.dart

run_staging: ## Runs the mobile application in staging
	@echo "╠ Running the app"
	@flutter run --flavor development -t lib/main_staging.dart


run_dev: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run --flavor development -t lib/main_development.dart

build_apk_dev: ## Build the mobile application in dev
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor development -t lib/main_development.dart

build_apk_staging: ## Build the mobile application in staging
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor staging -t lib/main_staging.dart

build_apk_prod: ## Build the mobile application in prod
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor production -t lib/main.dart

purge: ## Purges the Flutter
	@pod deintegrate
	@flutter clean
	@flutter pub get
