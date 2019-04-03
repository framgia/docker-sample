class User < ApplicationRecord
  attr_accessor :archived

  scope :available, ->{where archived_at: nil}

  def available?
    return true unless archived_at
    false
  end

  def unavailable
    archived_at = Time.zone.now unless archived_at
  end

  def unavailable!
    unavailable
    save!
  end
end
