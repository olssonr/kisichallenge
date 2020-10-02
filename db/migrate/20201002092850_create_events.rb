class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :message
      t.integer :status

      t.timestamps
    end
  end
end
