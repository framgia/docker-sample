class User < ApplicationRecord

  scope :available, -> { where archived_at: nil }

  def unavilable!
    self.update archived_at: Time.zone.now
  end
end
