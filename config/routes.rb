EvokeTruegmRails::Application.routes.draw do
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Upmin::Engine => '/admin'
  end

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks", :registrations => "users/registrations"},
                     :path_prefix => 'd'

  scope "/users/:user_id" do
    resources :external_link
  end

  resources :leagues, :only => [:show, :index]  do
    resources :nfl_players, :only => [:index, :show], :path => 'player' do
      post :add_player, on: :member
      post :remove_player, on: :member
    end
    resources :nfl_teams, :only => [:show]
    get 'activity', as: 'activity', :only => [:index]

    resources :forum_topics, :path => "topics" do
      resources :forum_posts, only: [:new, :create, :destroy]
    end
    get 'schedule/:week' => "schedule#index", as: 'schedule'
  end

  resources :teams, :only => [:show]
  resources :trades
  resources :users
  resources :invites

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'app#index'

end
