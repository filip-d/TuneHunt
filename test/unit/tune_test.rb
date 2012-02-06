require 'test_helper'

class TuneTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "single artist" do
    radio = Radio.new
    radio.add_artist(1, 1)
    artist_id = r.get_random_artist
    assert artist_id = 1
  end
end
