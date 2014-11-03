class Tune < ActiveRecord::Base

  attr_accessor :track
  attr_accessor :api_client
  has_many :flags, :through => :user_tune_flags
  has_many :user_tune_flags

  def self.parse(track, sd_client)
    tune = Tune.new
    tune.track_id = track.id
    tune.track_title = track.title
    tune.artist_id = track.artist.id
    tune.artist_name = track.artist.appears_as
    tune.image_url = track.release.image
    tune.buy_url = track.url
    tune.track = track
    tune.api_client = sd_client
    tune
  end

  def self.fake()
    tune = Tune.new
    tune.track_id = rand(123456)
    tune.track_title = "track#{tune.track_id}"
    tune.artist_id = 1
    tune.artist_name = "unknown"
    tune.image_url = "http://asdsads.com/adsds.jpg"
    tune.buy_url = "http://7digital.com"
    tune.track = Sevendigital::Track.new(SEVENDIGITAL_CLIENT)
    tune.api_client = SEVENDIGITAL_CLIENT
    tune
  end

  def self.random_flagged_tune
    Tune.first(
        :select => "track_id",
        :joins => "inner join user_tune_flags ON user_tune_flags.tune_id = tunes.id",
        :conditions => "user_tune_flags.flag_id IN (#{Flag.useful_flags.map{|f|f.id}.join(",")})",
        :order => "RAND()",
        :limit => "1"
    )
  end

  def preview_url
    track.preview_url
#    "http://api.7digital.com/1.2/track/preview?trackid=#{track_id}&oauth_consumer_key=YOUR_KEY_HERE"
  end

  def stream_url(user_id)
      api_request = api_client.create_api_request(:GET, "track/stream", {:formatId => 55, :trackId => track_id, :userId => user_id})
      api_request.api_service = :media
      api_request.require_signature
      api_client.operator.get_request_uri(api_request)
  end

  def track
    begin
      @track ||= SEVENDIGITAL_CLIENT.track.get_details(track_id)
    rescue
      @track ||= nil
    end
  end

  def flag(user_id, flag_id)
    my_flag = UserTuneFlag.new()
    my_flag.tune_id = id
    my_flag.user_id = user_id
    my_flag.flag_id = flag_id
    my_flag.save
  end

  def url
    return buy_url if buy_url
    buy_url = track ? track.url : 'http://7digital.com'
    save
    buy_url
  end

end
