"""
Minimal environment configuration helpers (no extra dependencies).

Values come from real environment variables first, then from a `.env` file
in the project root (see `.env.example`). Never commit `.env`.
"""
import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent


class ImproperlyConfiguredEnv(RuntimeError):
    """Raised when a required environment variable is missing."""


def _load_dotenv(path: Path) -> None:
    if not path.is_file():
        return
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.strip()
        if key.startswith("export "):
            key = key[len("export "):].strip()
        value = value.strip()
        if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
            value = value[1:-1]
        os.environ.setdefault(key, value)


_load_dotenv(BASE_DIR / ".env")


def env(name: str, default=None, required: bool = False):
    value = os.environ.get(name)
    if value is None or value == "":
        if required:
            raise ImproperlyConfiguredEnv(
                f"Environment variable {name} is required. Set it in your environment or in .env "
                f"(see .env.example)."
            )
        return default
    return value


def env_bool(name: str, default: bool = False) -> bool:
    value = os.environ.get(name)
    if value is None or value == "":
        return default
    return value.strip().lower() in ("1", "true", "yes", "on")


def env_list(name: str, default=None):
    value = os.environ.get(name)
    if value is None or value.strip() == "":
        return list(default or [])
    return [item.strip() for item in value.split(",") if item.strip()]
