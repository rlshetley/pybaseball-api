
from app.database import *
from itertools import groupby
from sqlalchemy import and_

from stats_calculator.stats_calculator import *

def get_batting_stats(player_id):
    items = session.query(Batting, Teams).\
		join(Teams, and_(Teams.teamID == Batting.teamID, Teams.yearID == Batting.yearID, Teams.lgID == Batting.lgID)).\
		filter(Batting.playerID == player_id).all()

    batting_stats = _process_items(items)

    for batting_stat in batting_stats:
        batting_stat['avg'] = get_batting_average(int(batting_stat['H']) , int(batting_stat['AB']))

    return batting_stats;

def get_pitching_stats(player_id):
    items = session.query(Pitching, Teams).\
		join(Teams, and_(Teams.teamID == Pitching.teamID, Teams.yearID == Pitching.yearID, Teams.lgID == Pitching.lgID)).\
		filter(Pitching.playerID == player_id).all()

    return _process_items(items)

def get_fielding_stats(player_id):
    items = session.query(Fielding, Teams).\
		join(Teams, and_(Teams.teamID == Fielding.teamID, Teams.yearID == Fielding.yearID, Teams.lgID == Fielding.lgID)).\
		filter(Fielding.playerID == player_id).all()

    return _process_items(items)

def transform_model_col(items):
    res = []

    for item in items:
        res.append(to_dict(item))

    return res

def transform_model(item):
    return to_dict(item)

def _process_items(items):

    res = []

    for item in items:
        stat = item[0]
        team = item[1]
        item_dict = to_dict(stat)

        item_dict['teamName'] = team.name
        item_dict['teamId'] = team.teamID

        res.append(item_dict)

    return res

def get_team(team_id, year_id, league_id):
    return session.query(Teams).filter(Teams.teamID == team_id, Teams.yearID == year_id, Teams.lgID == league_id).first()
