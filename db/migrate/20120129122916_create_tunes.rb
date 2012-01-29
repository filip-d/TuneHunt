class CreateTunes < ActiveRecord::Migration
  def self.up
    create_table :tunes do |t|
      t.integer :track_id
      t.string :track_title
      t.integer :artist_id
      t.string :artist_name
      t.string :image_url
    end
  end

  def self.down
    drop_table :tunes
  end
end
