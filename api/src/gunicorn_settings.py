import os

bind = '0.0.0.0:8000'
workers = int(os.environ.get('GUNICORN_WORKER_COUNT', 1))
