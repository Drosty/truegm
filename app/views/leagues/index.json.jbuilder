json.leagues @leagues do |league|
  json.id league.id
  json.name league.name
  json.description league.description
  json.tagline league.tagline
end
