class Tune < ActiveRecord::Base

  def self.parse(track)
    tune = Tune.new
    tune.track_id = track.id
    tune.track_title = track.title
    tune.artist_id = track.artist.appears_as
    tune.artist_name = track.artist.appears_as
    tune.image_url = track.release.image
#    tune.track = track
    tune
  end

  def preview_url
    "http://previews.7digital.com/clips/34/#{track_id}.clip.mp3"
  end

end
