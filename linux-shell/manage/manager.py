#!/usr/bin/python

from flask import Flask
from flask import render_template
import os

app = Flask(__name__)

html = """<!DOCTYPE HTML>
<html>
<head><title>docker manager</title></head>
<body>
welcome use docker manager!</br>
%s
</body>
</html>
"""

@app.route("/")
def index():
	#return render_template('index.html')
	body = '<a href="/build">git clone source, build war</a></br>'
	body += '<a href="/restart">restart docker beta && quartz</a></br>'
	return html % body

@app.route('/build')
def build():
	#os.system('~/m a1')
	body = 'build finish.</br><a href="/">return</a>'
	return html % body

@app.route('/restart')
def restart():
	os.system('docker restart beta && docker restart quartz')
	body = 'build finish.</br><a href="/">return</a>'
	return html % body

if __name__ == '__main__':
	app.run(host='0.0.0.0', debug=True)

