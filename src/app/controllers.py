from flask import Flask, jsonify, abort, request, make_response, url_for
from app.models import *
from app import app, db

from app.database import *
from itertools import groupby
from sqlalchemy import and_

@app.route('/api/v1/players')
def get_players():
    # Check if there is a last name query
    last_name = request.args.get('last_name')
    if last_name is not None:
        items = session.query(Master).filter(Master.nameLast == last_name).all()

        res = []

        for item in items:
            res.append(to_dict(item))

        return jsonify(res)

@app.route('/api/v1/players/<string:player_id>')
def get_player(player_id):
    player = session.query(Master).filter(Master.playerID == player_id).first()
    return jsonify(player)

@app.route('/api/v1/players/<string:player_id>/statistics', methods=['GET'])
def get_playerStats(player_id):
    batting = get_batting_stats(player_id)
    pitching = get_pitching_stats(player_id)
    fielding = get_fielding_stats(player_id)

    return jsonify({
        'batting': batting,
        'pitching': pitching,
        'fielding': fielding
        })
