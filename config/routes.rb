EvokeTruegmRails::Application.routes.draw do

  resources :rosters

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'rosters#index'

end
