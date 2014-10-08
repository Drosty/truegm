json.week @week

json.qbs @qbs do |qb|
  json.(qb, :id, :player_name, :position, :team, :salary, :projection)
  json.status 0
end

json.rbs @rbs do |rb|
  json.(rb, :id, :player_name, :position, :team, :salary, :projection)
  json.status 0
end

json.wrs @wrs do |wr|
  json.(wr, :id, :player_name, :position, :team, :salary, :projection)
  json.status 0
end

json.tes @tes do |te|
  json.(te, :id, :player_name, :position, :team, :salary, :projection)
  json.status 0
end

json.ks @ks do |k|
  json.(k, :id, :player_name, :position, :team, :salary, :projection)
  json.status 0
end

json.dsts @dsts do |d|
  json.(d, :id, :player_name, :position, :team, :salary, :projection)
  json.status 0
end
