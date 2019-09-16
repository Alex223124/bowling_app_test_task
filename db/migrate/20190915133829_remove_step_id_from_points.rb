class RemoveStepIdFromPoints < ActiveRecord::Migration[5.2]
  def change
    remove_column :points, :step_id, :integer
  end
end
