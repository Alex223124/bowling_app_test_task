class AddStepIdToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :step_id, :integer
  end
end
