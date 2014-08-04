class Invite < ActiveRecord::Base
  attr_accessible :team_id, :sender_id, :recipient_id, :email

  belongs_to :team
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.team_id, Time.now, rand].join)
  end

end
