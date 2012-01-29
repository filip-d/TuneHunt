class CreateTuneUserFlags < ActiveRecord::Migration
  def self.up
    create_table :tune_user_flags do |t|
    end
  end

  def self.down
    drop_table :tune_user_flags
  end
end
