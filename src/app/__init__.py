from flask_api import FlaskAPI
from flask_sqlalchemy import SQLAlchemy

# local import
from app.config import app_config

# initialize sql-alchemy
db = SQLAlchemy()

def create_app(config_name):
    app = FlaskAPI(__name__, instance_relative_config=True)
    app.config.from_object(app_config[config_name])
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)

    return app

app = create_app('development')

from app.player_controller import *
from app.team_controller import *
