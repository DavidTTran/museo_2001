require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/curator'
require './lib/artist'
require './lib/photograph'

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
    @artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    @artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    @artist_3 = Artist.new({
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    })
    @photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy withBottles)",
      artist_id: "1",
      year: "1954"
    })
      @photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    @photo_3 = Photograph.new({
      id: "3",
      name: "Identical Twins, Roselle, NewJersey",
      artist_id: "3",
      year: "1967"
    })
    @photo_4 = Photograph.new({
      id: "4",
      name: "Monolith, The Face of Half   Dome",
      artist_id: "3",
      year: "1927"
    })
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_attributes
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_it_can_add_photographs
  @curator.add_photograph(@photo_1)
  @curator.add_photograph(@photo_2)

  assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_artists_by_id
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal [@photo_1], @curator.find_photographs_by_artist(@artist_1)
  end

  def test_it_can_sort_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    expected =
    {
      @artist_1 => [@photo_1],
      @artist_2 => [@photo_2],
      @artist_3 => [@photo_3, @photo_4]
    }

    assert_equal expected, @curator.photographs_by_artist
  end



end
