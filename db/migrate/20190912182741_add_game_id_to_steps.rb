class AddGameIdToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :game_id, :integer
  end
end
