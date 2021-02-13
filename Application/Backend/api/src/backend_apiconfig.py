import os
DEBUG = True
SQLALCHEMY_DATABASE_URI = 'postgresql://' + str(os.getenv('DB_USER')) + ':' + str(os.getenv('DB_PASS')) + '@' + str(os.getenv('DB_HOST')) + ':' + str(os.getenv('DB_PORT')) + '/' + str(os.getenv('DB_NAME')) + '?sslmode=require'

SQLALCHEMY_TRACK_MODIFICATIONS = True
DATABASE_CONNECT_OPTIONS = {}
THREADS_PER_PAGE = 2
