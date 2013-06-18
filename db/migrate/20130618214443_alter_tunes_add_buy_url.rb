class AlterTunesAddBuyUrl < ActiveRecord::Migration
  def self.up
    add_column :tunes, :buy_url, :string
  end

  def self.down
    remove_column :tunes, :buy_url
  end
end