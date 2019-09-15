class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.string :status
      t.string :status_reason

      t.timestamps
    end
  end
end
