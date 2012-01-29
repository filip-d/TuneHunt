class Song
  attr_accessor :artist_name, :title, :track_id, :preview_url, :track

  def self.parse(track)
    @song = Song.new
    @song.artist_name = track.artist.appears_as
    @song.title = track.title
    @song.track_id = track.id
    @song.preview_url = "http://previews.7digital.com/clips/34/#{track.id}.clip.mp3"
    @song.track = track
#    @track_preview_url = "http://previews.7digital.com/clips/34/#{@track.id}.clip.mp3"
    @song
  end
end