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
      @sevendigital_client = Sevendigital::Client.new
      puts "RADIO SESSION: #{session[:radio].inspect}"
      session[:radio] ||= Radio.new
      @radio = session[:radio]

      artist_id = @radio.get_random_artist
      puts "PICKED ARTIST #{artist_id}"
      @tune = Tune.parse(SEVENDIGITAL_CLIENT.artist.get_top_tracks(@radio.get_random_artist, {:image_size=>500}).sort_by{rand}.first)
    #  @tune = Tune.fake
      @page_sub_title = "- #{@tune.artist_name} - #{@tune.track_title}"

  end

  def start
      session[:radio] = Radio.new
      artist_id = SEVENDIGITAL_CLIENT.artist.search(params[:q]).first.id

      @radio = session[:radio]
      @radio.add_artist(artist_id, 1)

      @tune = Tune.parse(SEVENDIGITAL_CLIENT.artist.get_top_tracks(artist_id, {:image_size=>500}).sort_by{rand}.first)
      @page_sub_title = "- #{@tune.artist_name} - #{@tune.track_title}"

      render :play

  end

  def new
  end

end
