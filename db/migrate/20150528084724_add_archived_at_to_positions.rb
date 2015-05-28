class AddArchivedAtToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :archived_at, :datetime
  end
end
