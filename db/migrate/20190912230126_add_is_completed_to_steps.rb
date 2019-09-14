class AddIsCompletedToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :is_completed, :boolean, default: false
  end
end
