# == Schema Information
#
# Table name: invites
#
#  id           :integer          not null, primary key
#  email        :string
#  team_id      :integer
#  sender_id    :integer
#  recipient_id :integer
#  token        :string
#  created_at   :datetime
#  updated_at   :datetime
#

class Invite < ActiveRecord::Base
  attr_accessible :team_id, :sender_id, :recipient_id, :email

  belongs_to :team
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  before_create :generate_token
  before_save :check_user_existence

private

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.team_id, Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

end
