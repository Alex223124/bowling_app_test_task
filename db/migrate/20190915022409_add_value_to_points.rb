class AddValueToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :value, :integer
  end
end
