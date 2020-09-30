class ChangeValueToNumber < ActiveRecord::Migration[6.0]
  def change
    change_table :metrics do |t|
      t.change :value, :integer
    end
  end
end
