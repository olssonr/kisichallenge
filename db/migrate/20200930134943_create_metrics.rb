class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.string :name
      t.decimal :value

      t.timestamps
    end
  end
end
