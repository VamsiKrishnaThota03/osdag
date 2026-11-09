"""Django SECRET_KEY, read from the DJANGO_SECRET_KEY environment variable."""
import secrets
import warnings

from osdag_web.env import env, env_bool


def get_secret_key():
    key = env("DJANGO_SECRET_KEY")
    if key:
        return key
    if env_bool("DJANGO_DEBUG"):
        # Local development only: a random key per process (sessions and tokens
        # reset on restart). Never used when DEBUG is off.
        warnings.warn("DJANGO_SECRET_KEY is not set; using a temporary random key (DEBUG only).")
        return "dev-insecure-" + secrets.token_urlsafe(48)
    return env("DJANGO_SECRET_KEY", required=True)
