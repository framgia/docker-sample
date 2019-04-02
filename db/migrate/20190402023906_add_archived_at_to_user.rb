class AddArchivedAtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :archived_at, :date
  end
end
