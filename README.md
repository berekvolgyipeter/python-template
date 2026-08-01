# python-template

Python project template with linting strict enough to keep AI-generated code honest.

## Setup

```bash
make install
```

Requires [uv](https://docs.astral.sh/uv/). The Python version is pinned to a single minor release in [pyproject.toml](pyproject.toml) — `uv python install` picks it up.

Then rename `name` and `description` in [pyproject.toml](pyproject.toml), and `cp .env.example .env` if you want the claude-context MCP server.

## Commands

| Command | Does |
| --- | --- |
| `make install` | Update lockfile, sync all dependency groups |
| `make lint` | Format, autofix, type check, complexity check |
| `make test` | Run tests |
| `make coverage` | Run tests with a term-missing coverage report |
| `make tree` | Print the source tree |

## Layout

```
src/     package code
tests/   pytest suite (ENVIRONMENT is preset to test)
```

## Linting

All thresholds live in [pyproject.toml](pyproject.toml) — that file is the source of truth.

- **ruff** — broad rule selection covering security, bug patterns, error handling, and stray `print` calls.
- **mypy** — strict mode, plus extra error codes for unreachable branches, always-true conditions, and unawaited awaitables.
- **No blanket suppressions** — bare `# noqa` and `# type: ignore` are rejected; each must name the code it silences.
- **Size caps** — per-function limits on arguments, statements, branches, and returns.
- **Complexity caps** — cyclomatic (ruff mccabe) and cognitive (complexipy).

`tests/` relaxes only the `assert` and magic-value rules.

## Debugging and profiling

Preinstalled in the dev group: `ipdb` (breakpoints), `line-profiler` and `memory-profiler` (per-line time and memory), `rich` (readable tracebacks and object dumps).

## MCP servers

[.mcp.json](.mcp.json) wires up serena (semantic code tools), context7 (library docs), sequential-thinking, and claude-context.

claude-context needs `OPENAI_API_KEY` in `.env` and a local Milvus instance — [berekvolgyipeter/milvus](https://github.com/berekvolgyipeter/milvus) holds a local Milvus setup on the expected port.
