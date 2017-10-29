from __future__ import division

def get_batting_average(hits, at_bats):
    if (at_bats < 1):
        return 0

    return hits / at_bats;

def get_era(runs_allowed, innings_pitched):

    if (innings_pitched < 1):
        return 0

    return 9 * runs_allowed / innings_pitched
