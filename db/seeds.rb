NflTeam.find_or_create_by(mascot: 'Cardinals', location: 'Arizona', abbreviation: 'ARI')
NflTeam.find_or_create_by(mascot: 'Falcons', location: 'Atlanta', abbreviation: 'ATL')
NflTeam.find_or_create_by(mascot: 'Ravens', location: 'Baltimore', abbreviation: 'BAL')
NflTeam.find_or_create_by(mascot: 'Bills', location: 'Buffalo', abbreviation: 'BUF')
NflTeam.find_or_create_by(mascot: 'Panthers', location: 'Carolina', abbreviation: 'CAR')
NflTeam.find_or_create_by(mascot: 'Bears', location: 'Chicago', abbreviation: 'CHI')
NflTeam.find_or_create_by(mascot: 'Bengals', location: 'Cincinnati', abbreviation: 'CIN')
NflTeam.find_or_create_by(mascot: 'Browns', location: 'Cleveland', abbreviation: 'CLE')
NflTeam.find_or_create_by(mascot: 'Cowboys', location: 'Dallas', abbreviation: 'DAL')
NflTeam.find_or_create_by(mascot: 'Broncos', location: 'Denver', abbreviation: 'DEN')
NflTeam.find_or_create_by(mascot: 'Lions', location: 'Detroit', abbreviation: 'DET')
NflTeam.find_or_create_by(mascot: 'Packers', location: 'Green Bay', abbreviation: 'GB')
NflTeam.find_or_create_by(mascot: 'Texans', location: 'Houston', abbreviation: 'HOU')
NflTeam.find_or_create_by(mascot: 'Colts', location: 'Indianapolis', abbreviation: 'IND')
NflTeam.find_or_create_by(mascot: 'Jaguars', location: 'Jacksonville', abbreviation: 'JAX')
NflTeam.find_or_create_by(mascot: 'Chiefs', location: 'Kansas City', abbreviation: 'KC')
NflTeam.find_or_create_by(mascot: 'Dolphins', location: 'Miami', abbreviation: 'MIA')
NflTeam.find_or_create_by(mascot: 'Vikings', location: 'Minnesota', abbreviation: 'MIN')
NflTeam.find_or_create_by(mascot: 'Patriots', location: 'New England', abbreviation: 'NE')
NflTeam.find_or_create_by(mascot: 'Saints', location: 'New Orleans', abbreviation: 'NO')
NflTeam.find_or_create_by(mascot: 'Giants', location: 'New York', abbreviation: 'NYG')
NflTeam.find_or_create_by(mascot: 'Jets', location: 'New York', abbreviation: 'NYJ')
NflTeam.find_or_create_by(mascot: 'Raiders', location: 'Oakland', abbreviation: 'OAK')
NflTeam.find_or_create_by(mascot: 'Eagles', location: 'Philadelphia', abbreviation: 'PHI')
NflTeam.find_or_create_by(mascot: 'Steelers', location: 'Pittsburgh', abbreviation: 'PIT')
NflTeam.find_or_create_by(mascot: 'Chargers', location: 'San Diego', abbreviation: 'SD')
NflTeam.find_or_create_by(mascot: '49ers', location: 'San Francisco', abbreviation: 'SF')
NflTeam.find_or_create_by(mascot: 'Seahawks', location: 'Seattle', abbreviation: 'SEA')
NflTeam.find_or_create_by(mascot: 'Rams', location: 'St. Louis', abbreviation: 'STL')
NflTeam.find_or_create_by(mascot: 'Buccaneers', location: 'Tampa Bay', abbreviation: 'TB')
NflTeam.find_or_create_by(mascot: 'Titans', location: 'Tennessee', abbreviation: 'TEN')
NflTeam.find_or_create_by(mascot: 'Redskins', location: 'Washington', abbreviation: 'WAS')

# create a admin test user for logging in
u = User.find_or_create_by(email: "admin@gmail.com", name: "Admin User")
u.password = "qwerty1234"
u.is_admin = true
u.save

# create a regular test user for logging in
u = User.find_or_create_by(email: "test@gmail.com", name: "Test User")
u.password = "qwerty1234"
u.is_admin = false
u.save

# Create a league for us to use
League.find_or_create_by(name: "First Test League", description: "Test league from seed data", tagline: "test")

team_list = [
  [ "Team Uno", "tagline"],
  [ "Basken Robins", "tagline" ],
  [ "All Days",  "tagline"],
  [ "One Timerz", "tagline" ],
  [ "someone top, someone bottom", "Tagline" ],
  [ "really really really long team name that is super obnoxious", "tagline" ],
  [ "Jimmerz", "tag" ],
  [ "Teach me how to Dougie", "taglinez" ],
  [ "Show me your TDs", "line of tag" ],
  [ "Ballerz", "tag" ]
]

league = League.find_or_create_by(name: "First Test League")
first_user = User.find_or_create_by(name: "Test User")

team_list.each do |name, tagline|
  t = Team.find_or_create_by(name: name, tagline: tagline)
  t.league = league
  t.user = first_user
  t.save

  first_user = nil
end

qb_idx = 0
rb_idx = 0
wr_idx = 0
te_idx = 0
d_idx = 0
k_idx = 0

10.times do |idx|
  team = league.teams[idx]
  team.nfl_players = []
  idx += 1

  team.nfl_players << NflPlayer.positions('QB')[qb_idx]
  qb_idx += 1
  team.nfl_players << NflPlayer.positions('QB')[qb_idx]
  qb_idx += 1

  team.nfl_players << NflPlayer.positions('RB')[rb_idx]
  rb_idx += 1
  team.nfl_players << NflPlayer.positions('RB')[rb_idx]
  rb_idx += 1
  team.nfl_players << NflPlayer.positions('RB')[rb_idx]
  rb_idx += 1
  team.nfl_players << NflPlayer.positions('RB')[rb_idx]
  rb_idx += 1
  team.nfl_players << NflPlayer.positions('RB')[rb_idx]
  rb_idx += 1

  team.nfl_players << NflPlayer.positions('WR')[wr_idx]
  wr_idx += 1
  team.nfl_players << NflPlayer.positions('WR')[wr_idx]
  wr_idx += 1
  team.nfl_players << NflPlayer.positions('WR')[wr_idx]
  wr_idx += 1
  team.nfl_players << NflPlayer.positions('WR')[wr_idx]
  wr_idx += 1

  team.nfl_players << NflPlayer.positions('TE')[te_idx]
  te_idx += 1
  team.nfl_players << NflPlayer.positions('TE')[te_idx]
  te_idx += 1

  team.nfl_players << NflPlayer.positions('D')[d_idx] if NflPlayer.positions('D').count > 0
  d_idx += 1

  team.nfl_players << NflPlayer.positions('PK')[k_idx] if NflPlayer.positions('PK').count > 0
  k_idx += 1
end
