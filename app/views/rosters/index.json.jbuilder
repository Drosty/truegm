json.array!(@rosters) do |roster|
  json.extract! roster, :id, :name, :qb1, :rb1, :rb2, :wr1, :wr2, :te, :flex, :utility, :pk
  json.url roster_url(roster, format: :json)
end
