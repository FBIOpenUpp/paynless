#!/usr/bin/env bash

# exit on error
set -o errexit

pip install --upgrade poetry
poetry install --only main

poetry run ./manage.py collectstatic --no-input
poetry run ./manage.py makemigrations core
poetry run ./manage.py migrate
