
# create a test user for logging in
User.create(email: "test@gmail.com", password: "qwerty1234", name: "Test User")

# Create a league for us to use
League.create(name: "First Test League", description: "Test league from seed data", tagline: "test")

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

league = League.find_by(name: "First Test League")
first_user = User.find_by(name: "Test User")

team_list.each do |name, tagline|
  t = Team.create(name: name, tagline: tagline)
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

  team.nfl_players << NflPlayer.positions('D')[d_idx]
  d_idx += 1

  team.nfl_players << NflPlayer.positions('PK')[k_idx]
  k_idx += 1
end
