class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.string :key
      t.string :desc
      t.string :style
    end
  end

  def self.down
    drop_table :flags
  end
end
