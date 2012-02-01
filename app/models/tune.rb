class Tune < ActiveRecord::Base

  attr_accessor :track
  has_many :flags, :through => :user_tune_flags
  has_many :user_tune_flags

  def self.parse(track)
    tune = Tune.new
    tune.track_id = track.id
    tune.track_title = track.title
    tune.artist_id = track.artist.appears_as
    tune.artist_name = track.artist.appears_as
    tune.image_url = track.release.image
    tune.track = track
    tune
  end

  def self.fake()
    tune = Tune.new
    tune.track_id = rand(123456)
    tune.track_title = "track#{tune.track_id}"
    tune.artist_id = 1
    tune.artist_name = "unknown"
    tune.image_url = "http://asdsads.com/adsds.jpg"
    tune.track = Sevendigital::Track.new(SEVENDIGITAL_CLIENT)
    tune
  end

  def preview_url
    "http://previews.7digital.com/clips/34/#{track_id}.clip.mp3"
  end

  def track
    @track ||= SEVENDIGITAL_CLIENT.track.get_details(track_id)
  end

  def flag(user_id, flag_id)
    my_flag = UserTuneFlag.new()
    my_flag.tune_id = id
    my_flag.user_id = user_id
    my_flag.flag_id = flag_id
    my_flag.save
  end

end
