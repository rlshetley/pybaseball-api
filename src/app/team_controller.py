from flask import Flask, jsonify, abort, request, make_response, url_for
from app.models import *
from app import app, db

from app.database import *

@app.route('/api/v1/franchises/<string:franchise_id>')
def get_franchise(franchise_id):
    franchise = session.query(TeamsFranchises).filter(TeamsFranchises.franchID == franchise_id).first()
    return jsonify(franchise)


@app.route('/api/v1/franchises/<string:franchise_id>/teams')
def get_franchise_teams(franchise_id):
    team = session.query(Teams).filter(Teams.franchID == franchise_id).first()
    return jsonify(team)

@app.route('/api/v1/teams/<string:team_id>')
def get_team(team_id):
    team = session.query(Teams).filter(Teams.teamID == team_id).first()
    return jsonify(team)
