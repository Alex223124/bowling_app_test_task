class AddPlayerIdToThrows < ActiveRecord::Migration[5.2]
  def change
    add_column :throws, :player_id, :integer
  end
end
