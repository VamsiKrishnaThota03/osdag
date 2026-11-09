#########################################################
# Author : Atharva Pingale ( FOSSEE Summer Fellow '23 ) #
#########################################################
"""
PostgreSQL connection settings, read from the environment (or .env).

    DB_NAME, DB_USER, DB_PASSWORD (required), DB_HOST, DB_PORT

Used by osdag_web/settings.py, populate_database.py and update_sequences.py.
"""
from osdag_web.env import env


def get_username():
    return env("DB_USER", "postgres")


def get_password():
    return env("DB_PASSWORD", required=True)


def get_host():
    return env("DB_HOST", "localhost")


def get_port():
    return env("DB_PORT", "5432")


def get_database_name():
    return env("DB_NAME", "postgres_Intg_osdag")
