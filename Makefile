.PHONY: install tree lint test coverage

# Update lockfile and sync all dependencies
install:
	uv lock && uv sync --all-groups

# Display project structure tree (source code only, metafiles excluded)
tree:
	tree -I "__pycache__" --gitignore

# Format code, fix linting issues, and run type and complexity checking
lint:
	uv run ruff format
	uv run ruff check --fix
	uv run mypy
	uv run complexipy

# Run all tests with verbose output
test:
	uv run pytest tests/ -v

# Run tests with coverage report
coverage:
	uv run pytest tests/ -v --cov --cov-report=term-missing
