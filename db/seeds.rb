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
League.find_or_create_by(name: "First Test League", description: "Test league from seed data", tagline: "test", salary: "32000000")

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
first_user = User.find_by(name: "Test User")
second_user = User.find_by(name: "Admin User")

team_list.each do |name, tagline|
  t = Team.find_or_create_by(name: name, tagline: tagline)
  t.league = league
  t.user = nil
  t.user = first_user if name == "Team Uno"
  t.user = second_user if name == "All Days"
  t.save
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
