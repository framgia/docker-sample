class User < ApplicationRecord
  attr_accessor :archived

  scope :available, ->{where archived_at: nil}

  def available?
    return true unless archived_at
    false
  end

  def archive
    self.archived_at = Time.zone.now unless archived_at
  end

  def archive!
    archive
    save!
  end

  class << self
    def multi_archive! ids
      User.transaction do
        ids.each do |id|
          User.available.find(id).archive!
        end
      end
    end
  end
end
