class User < ApplicationRecord
  def self.all_avilable_users
    User.where archived_at: nil
  end
  def self.find_avilable_user id
    user = User.find(id)
    user.archived_at.nil? ? user : nil
  end
end
