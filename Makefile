.PHONY: *

generate:
	@echo "Generating docsify..."
	@rm ./_sidebar.md
	npx docsify-cli generate .

serve:
	@echo "Starting server..."
	docsify serve .
