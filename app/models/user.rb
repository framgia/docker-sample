class User < ApplicationRecord
  attr_accessor :archived

  scope :available, ->{where archived_at: nil}

  def avilable?
    return true unless archived_at
    false
  end

  def unavilable
    archived_at = Time.zone.now unless archived_at
  end

  def unavilable!
    unavilable
    save!
  end
end
