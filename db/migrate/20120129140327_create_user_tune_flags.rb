class CreateUserTuneFlags < ActiveRecord::Migration
  def self.up
    create_table :user_tune_flags do |t|
      t.integer :user_id
      t.integer :tune_id
      t.integer :flag_id
    end
  end

  def self.down
    drop_table :user_tune_flags
  end
end
