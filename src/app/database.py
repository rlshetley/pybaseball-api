from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session, create_session
from sqlalchemy import create_engine
from sqlalchemy.engine import url as sa_url

Base = automap_base()

engine = create_engine('mysql+mysqldb://root:change_me@/lahman2016?unix_socket=/var/run/mysql-db/mysqld.sock')

Base.prepare(engine, reflect=True)

AllstarFull = Base.classes.AllstarFull
AwardsManagers = Base.classes.AwardsManagers
AwardsPlayers = Base.classes.AwardsPlayers
AwardsShareManagers = Base.classes.AwardsShareManagers
AwardsSharePlayers = Base.classes.AwardsSharePlayers
Batting = Base.classes.Batting
BattingPost = Base.classes.BattingPost
#CollegePlaying = Base.classes.CollegePlaying
Fielding = Base.classes.Fielding
FieldingOF = Base.classes.FieldingOF
FieldingPost = Base.classes.FieldingPost
HallOfFame = Base.classes.HallOfFame
Managers = Base.classes.Managers
ManagersHalf = Base.classes.ManagersHalf
Master = Base.classes.Master
Pitching = Base.classes.Pitching
PitchingPost = Base.classes.PitchingPost
Salaries = Base.classes.Salaries
Schools = Base.classes.Schools
SeriesPost = Base.classes.SeriesPost
Teams = Base.classes.Teams
TeamsFranchises = Base.classes.TeamsFranchises
TeamsHalf = Base.classes.TeamsHalf

#Create a session to use the tables
session = create_session(bind=engine)

def to_dict(row):
    d = {}
    for column in row.__table__.columns:
        d[column.name] = str(getattr(row, column.name))

    return d
