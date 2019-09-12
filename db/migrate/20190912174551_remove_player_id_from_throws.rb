class RemovePlayerIdFromThrows < ActiveRecord::Migration[5.2]
  def change
    remove_column :throws, :player_id
  end
end
