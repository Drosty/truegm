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
    f.inputs "Name" do
      f.input :name
      f.input :description
    end

    f.inputs "Teams" do
      f.has_many :teams, :allow_destroy => true, :heading => 'Teams' do |cf|
        # cf.input :id, :label => 'Member', :as => :select, :collection => Team.all.map{|u| ["#{u.name}", u.id]}
        cf.input :name
        cf.input :tagline
        cf.input :invite_code
        cf.actions
      end
    end
    f.actions
  end

end
