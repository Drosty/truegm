json.success "true"
json.projection @projection

json.qb do
  json.(@qb, :id, :player_name, :position, :team, :salary, :projection)
end

json.rb1 do
  json.(@rb1, :id, :player_name, :position, :team, :salary, :projection)
end

json.rb2 do
  json.(@rb2, :id, :player_name, :position, :team, :salary, :projection)
end

json.wr1 do
  json.(@wr1, :id, :player_name, :position, :team, :salary, :projection)
end

json.wr2 do
  json.(@wr2, :id, :player_name, :position, :team, :salary, :projection)
end

json.wr3 do
  json.(@wr3, :id, :player_name, :position, :team, :salary, :projection)
end

json.te do
  json.(@te, :id, :player_name, :position, :team, :salary, :projection)
end

json.k do
  json.(@k, :id, :player_name, :position, :team, :salary, :projection)
end

json.dst do
  json.(@d, :id, :player_name, :position, :team, :salary, :projection)
end
