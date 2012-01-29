class TuneController < ApplicationController

  def index
    @flag = Flag.find_by_key(params[:flag])
    @tunes = Tune.joins(:user_tune_flags).where(:user_tune_flags => {:flag_id => @flag.id})
  end

  def next
    redirect_to tune_path(:id => next_track_id)
  end

  def view
      @sevendigital_client = Sevendigital::Client.new

      @tune = Tune.parse(SEVENDIGITAL_CLIENT.track.get_details(params[:id], {:imageSize=>"500"}))

      @flags = Flag.find_all_by_style(:hipster)

  end

  def flag
    tune = Tune.find_by_track_id(params[:id])

    if tune.nil?
      tune = Tune.parse(SEVENDIGITAL_CLIENT.track.get_details(params[:id], {:imageSize=>"500"}))
      tune.save
    end
    tune.flag(0, params[:flag])

    redirect_to tune_path(:id => next_track_id)
  end

  private

  def next_track_id
    session[:latest_release_id] ||= SEVENDIGITAL_CLIENT.release.get_by_date.first.id
    begin
    random_release_id = rand(session[:latest_release_id])
      begin
        recommendations = SEVENDIGITAL_CLIENT.release.get_recommendations(random_release_id, {:imageSize=>"500"})
        if recommendations.empty?
          track_id = SEVENDIGITAL_CLIENT.release.get_tracks(random_release_id, {:imageSize=>"500"}).sort_by{rand}.first.id
        end
      rescue Sevendigital::SevendigitalError;
      end
    end while !track_id
    track_id
  end

end
