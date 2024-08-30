"""
Service Module
"""

from __future__ import print_function
import os
import requests
from urllib.parse import urlparse
from flask import Flask, jsonify, json, Response, request, abort
from flask_cors import CORS
from dotenv import load_dotenv
load_dotenv()
# [TODO] load x-ray recorder module
# [TODO] load middleware module for incoming requests

loglevel = os.environ['LOGLEVEL'].upper()
env = os.environ['ENV']

app = Flask(__name__)
CORS(app)
app.config['DEBUG'] = True
app.logger

# [TODO] x-ray recorder config to label segments as 'like service'
# [TODO] initialize the x-ray middleware

# The service basepath has a short response just to ensure that healthchecks
# sent to the service root will receive a healthy response.
@app.route("/")
def health_check_response():
    url = urlparse('http://{}/'.format(os.environ['MONOLITH_URL']))
    response = requests.get(url=url.geturl())

    flask_response = jsonify({"message" : "Health check, monolith service available."})
    flask_response.status_code = response.status_code
    return flask_response


@app.route("/update-viewers/<page>/", methods=['POST'])
def update_viewers(field: str) -> None:
    """
    Updates the number of users which have accessed each page of the quiz.

    Args:
        field (str): receives one of the following values: 'home', 'form', 'quiz', 'result', 'upload_cat'
    """
    pages = ['home', 'form', 'quiz', 'result', 'upload_cat']
    if env=='dev':
        return None
    log.info(f"updating viewers - field: {field}")
    try:
        counter = ViewsCounter.objects.filter(timestamp=date.today()).first()
        if not counter:
            counter = ViewsCounter.objects.create()
            log.info(f"created - counter: {counter}")

        current_value = getattr(counter, field, 0)
        setattr(counter, field, current_value + 1)
        counter.save()
        log.info(f"{20*'-'} \n {counter.__dict__} \n has been updated successfully.")
    except Exception as e:
        log.error(f"update_viewers - ERROR: {str(e)}")
        raise e
    return None
 
# Run the service on the local server it has been deployed to
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
