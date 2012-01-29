class TuneController < ApplicationController


  def next
    latest_release_id = SEVENDIGITAL_CLIENT.release.get_by_date.first.id
    begin
      random_release_id = rand(latest_release_id)
      begin
        release = SEVENDIGITAL_CLIENT.release.get_details(random_release_id, {:imageSize=>"350"})
      rescue Sevendigital::SevendigitalError;
      end
    end while !release

    track = release.tracks.sort_by{rand}.first

    redirect_to "/songs/#{track.id}"
  end

  def view
      @sevendigital_client = Sevendigital::Client.new

      @tune = Song.parse(SEVENDIGITAL_CLIENT.track.get_details(params[:id], {:imageSize=>"350"}))

      @flags = Flag.find_all_by_style(:hipster)

  end

  def flag
    
  end


end
