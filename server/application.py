#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask
from flask import render_template
from flask import session
from flask import request
from flask import redirect
from flask import url_for
from flask import abort
from flask import g
from flask import jsonify
from flask import Response
import re
import urllib2
import datetime
import hashlib
import time
import json


DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)

@app.route('/')
def index():
	return 'quiz main page'

@app.route('/list')
def pack_list():
	json_data = json.dumps([
		dict(
			name = dict(ru = u'Кино', en = 'Cinema'),
			topic_id = 0,
			levels = [
				dict(
					level_id = 0,
					name = dict(ru = u'Уровень 1', en = 'Level 1'),
					questions = [
						dict(
							question_id = 0,
							question = dict(
								ru = u'По ком звонит колокол',
								en = 'For Whom the Bell Tolls'
							),
							answers = [
								dict(
									text = dict(ru = u'По тебе', en = 'For you'),
									is_right = True
								),
								dict(
									text = dict(ru = u'По птицам', en = 'For the birds'),
								)
							]
						)
					]
				)
			]
		),
	])

	return Response(json_data, mimetype='application/json')


if '__main__' == __name__:
	app.run(host = '0.0.0.0', port = 4242)