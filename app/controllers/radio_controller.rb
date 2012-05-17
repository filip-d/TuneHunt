class RadioController < ApplicationController

  def like
      session[:radio] ||= Radio.new
      radio = session[:radio]

      if params[:artist_id] then
        radio.add_artist(params[:artist_id].to_i, 1)
      end

      redirect_to radio_play_path
  end

  def hate
    session[:radio] ||= Radio.new
    radio = session[:radio]

    if params[:artist_id] then
      radio.add_artist(params[:artist_id].to_i, -1.quo(2))
    end

    redirect_to radio_play_path
  end

  def play
      puts "RADIO SESSION: #{session[:radio].inspect}"
      session[:radio] ||= Radio.new
      @radio = session[:radio]

      artist_id = @radio.get_random_artist
      puts "PICKED ARTIST #{artist_id}"
      @tune = Tune.parse(sd_client.artist.get_top_tracks(@radio.get_random_artist, {:image_size=>500}).sort_by{rand}.first, sd_client)
    #  @tune = Tune.fake
      @page_sub_title = "- #{@tune.artist_name} - #{@tune.track_title}"
  end

  def play2
      puts "RADIO SESSION: #{session[:radio].inspect}"
      session[:radio] ||= Radio.new
      @radio = session[:radio]

      artist_id = @radio.get_random_artist
      puts "PICKED ARTIST #{artist_id}"
      @tune = Tune.parse(sd_client.artist.get_top_tracks(@radio.get_random_artist, {:image_size=>500}).sort_by{rand}.first, sd_client)
    #  @tune = Tune.fake
      @page_sub_title = "- #{@tune.artist_name} - #{@tune.track_title}"
  end

  def start
      session[:radio] = Radio.new
      artist_id = SEVENDIGITAL_CLIENT.artist.search(params[:q]).first.id

      @radio = session[:radio]
      @radio.add_artist(artist_id, 1)

      @tune = Tune.parse(SEVENDIGITAL_CLIENT.artist.get_top_tracks(artist_id, {:image_size=>500}).sort_by{rand}.first, sd_client)
      @page_sub_title = "- #{@tune.artist_name} - #{@tune.track_title}"

      render :play

  end

  def new
  end

  private

  def sd_client
    return @sd_client if @sd_client
    if !params[:host].nil? && params[:host] != "" then
      session[:host] = params[:host]
    end
    if !session[:host].nil? then
      @sd_client = Sevendigital::Client.new(:country => 'GB', :cache => SIMPLE_CACHE, :verbose => "very_verbose", :media_api_url => session[:host])
    else
      @sd_client = Sevendigital::Client.new(:country => 'GB', :cache => SIMPLE_CACHE, :verbose => "very_verbose")
    end
    @sd_client
  end

end
