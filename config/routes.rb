EvokeTruegmRails::Application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}, :path_prefix => 'd'

  scope "/users/:user_id" do
    resources :external_link
  end

  resources :leagues, :only => [:show, :index]  do
    resources :teams, :only => [:show]

# I am removing these from the project
# These were initially going to be used as a way to keep communication
# for the group open and flowing, but I have decided to use the
# GroupMe service and tie into their API for league communication.
#
#    resources :forum_topics, :path => "topics" do
#      resources :forum_posts, only: [:new, :create, :destroy]
#    end

    resources :trades
    resources :nfl_players, :only => [:index, :show]
  end

  resources :nflteams, :only => [:index, :show]
  resources :users

  namespace :admin do
    get "/" => "leagues#index"

    resources :leagues do
      resources :teams, :only => [:index, :show, :edit, :update]
    end
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

end
