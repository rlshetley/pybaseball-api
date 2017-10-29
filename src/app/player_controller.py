from flask import Flask, jsonify, abort, request, make_response, url_for
from app.models import *
from app import app, db

from app.database import *
from itertools import groupby
from sqlalchemy import and_

from elasticsearch import Elasticsearch

@app.route('/api/v1/players')
def get_players():
    # Check if there is a name query
    name = request.args.get('name')
    if name is not None:
        es = Elasticsearch()
        searchResults = es.search(index="player-index", doc_type="player", body={"query": {"multi_match": {"query": name, "fields": ["lastName", "firstName"]}}})

        if searchResults['hits']['total'] > 0:
            ids = []
            for doc in searchResults['hits']['hits']:
                ids.append(doc['_id'])

            items  = session.query(Master).filter(Master.playerID.in_(ids)).all()

            return jsonify(transform_model_col(items))

@app.route('/api/v1/players/<string:player_id>')
def get_player(player_id):
    player = session.query(Master).filter(Master.playerID == player_id).first()
    return jsonify(transform_model(player))

@app.route('/api/v1/players/<string:player_id>/statistics', methods=['GET'])
def get_player_stats(player_id):
    batting = get_batting_stats(player_id)
    pitching = get_pitching_stats(player_id)
    fielding = get_fielding_stats(player_id)

    return jsonify({
        'batting': batting,
        'pitching': pitching,
        'fielding': fielding
        })

@app.route('/api/v1/players/<string:player_id>/hallOfFame', methods=['GET'])
def get_player_hall_of_fame(player_id):
    hof = session.query(HallOfFame).filter(HallOfFame.playerID == player_id).all()

    return jsonify(transform_model(hof))

@app.route('/api/v1/players/<string:player_id>/allStar', methods=['GET'])
def get_player_all_star(player_id):
    asf = session.query(AllstarFull).filter(AllstarFull.playerID == player_id).all()

    return jsonify(transform_model(asf))
