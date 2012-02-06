class Radio

  attr_reader :artists, :seed_total

  def initialize
    @artists = Hash.new(Rational(0))
    @seed_total = 0
  end

  def add_artist(artist_id, seed)
    seed_artist(artist_id, seed)
    return if seed.abs <= 1.quo(8)
    similar_artists = SEVENDIGITAL_CLIENT.artist.get_similar(artist_id)
    similar_artists.each do |artist|
      puts "ARTIST: #{artist.name} SEED:#{(5*seed).quo(similar_artists.count)}"
      add_artist(artist.id, seed.quo(4))
    end
  end

  def seed_artist(artist_id, seed)
    current_positive_seed = [@artists[artist_id],0].max
    new_positive_seed = [@artists[artist_id]+seed, 0].max
    @artists[artist_id] += seed
    @seed_total += new_positive_seed-current_positive_seed
  end

  def get_random_artist
    stop = rand
    pos = 0
    @artists.each do |artist_id, seed|
      pos += [seed,0].max
      return artist_id if pos >= stop*@seed_total
    end
  end
end