ActiveAdmin.register League do
  config.filters = false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    column :name
    column :description
    column :salary_cap
    actions
  end

  form do |f|
    f.inputs "League Fields" do
      f.input :name
      f.input :description
      f.input :salary_cap
      f.input :passing_yard_points
      f.input :passing_touchdown_points
      f.input :passing_interception_points
      f.input :fumbles_lost_points
      f.input :rushing_yards_points
      f.input :rushing_touchdown_points
      f.input :receiving_yards_points
      f.input :receiving_touchdown_points
      f.input :points_per_reception_points
      f.input :defensive_interception_points
      f.input :defensive_fumble_recovered_points
      f.input :defensive_sack_points
      f.input :defensive_saftey_points
      f.input :defensive_touchdown_points
      f.input :defensive_points_allowed_under_7_points
      f.input :defensive_points_allowed_under_14_points
      f.input :defensive_points_allowed_under_21_points
      f.input :defensive_points_allowed_under_28_points
      f.input :defensive_points_allowed_under_35_points
      f.input :defensive_points_allowed_equal_or_over_35_points
    end

    f.actions

    f.inputs "Teams" do
      f.has_many :teams, :allow_destroy => true, :heading => 'Teams' do |cf|
        # cf.input :id, :label => 'Member', :as => :select, :collection => Team.all.map{|u| ["#{u.name}", u.id]}
        cf.input :name
        cf.input :tagline
        cf.actions
      end
    end

  end

end
