class ChangeEngineToCars < ActiveRecord::Migration[7.0]
  def self.up
    change_table :cars do |t|
      t.change :engine, :boolean, default: :false
    end
  end
  
  def self.down
    change_table :cars do |t|
      t.change :engine, :boolean
    end
  end

  def change
    add_column :cars, :turn_on, :boolean, default: :false
  end
end
