from stats_calculator import *

def test_get_batting_average():
    assert(get_batting_average(5, 25) == 0.2)

def test_get_batting_average_no_at_bats():
    assert(get_batting_average(5, 0) == 0)

def test_get_era():
    assert(round(get_era(3, 7), 2) == 3.86)
