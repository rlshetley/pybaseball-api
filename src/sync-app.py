from datetime import datetime
from elasticsearch import Elasticsearch, helpers
from app.database import *

es = Elasticsearch()

# Pull the players from the database
# and then bulk insert them into the database
masterRecs = session.query(Master).all()

players = []

for record in masterRecs:
    player = {
        'lastName': record.nameLast,
        'firstName': record.nameFirst,
        'givenName': record.nameGiven
    }

    players.append({ '_index': "player-index", '_type': 'player', '_id': record.playerID, '_source': player })

helpers.bulk(es,players)


teamRecs = session.query(Teams).all()

teams = []

for record in teamRecs:
	team = {
		'name': record.name
		'park': record.park
	}

	teams.append({ '_index': 'team-index', '_type': 'team', '_id': record.teamID, '_source': team })

helpers.bulk(es, teams)
