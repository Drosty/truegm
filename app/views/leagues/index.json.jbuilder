json.leagues @leagues do |league|
  json.(league, :id, :name, :description, :tagline)
end
