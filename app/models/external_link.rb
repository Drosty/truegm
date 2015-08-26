# == Schema Information
#
# Table name: external_links
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  description :text
#  url         :string
#  created_at  :datetime
#  updated_at  :datetime
#

class ExternalLink < ActiveRecord::Base
  attr_accessible :description, :name, :url

  belongs_to :user

  before_save :fix_url

  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :url

  private

  def fix_url
    self.url = "http://" + self.url if !self.url.starts_with? 'http://' and !self.url.starts_with? 'https://'
  end

end
