#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from flask import Flask
from flask.ext.basicauth import BasicAuth
from rq_dashboard import RQDashboard

app = Flask(__name__)

app.config['BASIC_AUTH_FORCE'] = True

for name in ['BASIC_AUTH_USERNAME',
             'BASIC_AUTH_PASSWORD',
             'REDIS_URL',
             'REDIS_HOST',
             'REDIS_PORT',
             'REDIS_PASSWORD',
             'REDIS_DB']:
    val = os.environ.get(name)
    if val:
        app.config[name] = val

BasicAuth(app)
RQDashboard(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9181)
