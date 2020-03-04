require 'CSV'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find { |artist| artist.id == id }
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all { |photograph| photograph.artist_id == artist.id }
  end

  def photographs_by_artist
    @artists.reduce({}) do |acc, artist|
      acc[artist] = find_photographs_by_artist(artist)
      acc
    end
  end

  def artists_with_multiple_photographs
    photographs_by_artist.reduce([]) do |acc, (artist, photographs)|
      if photographs.size > 1
        acc << artist.name
      end
      acc
    end
  end

  def photographs_taken_by_artist_from(country)
    photographs_by_artist.reduce([]) do |acc, (artist, photographs)|
      if artist.country == country
        acc << photographs
      end
      acc
    end.flatten
  end

  def load_photographs(file_location)
    CSV.foreach(file_location, headers: true, header_converters: :symbol) do |row|
      @photographs << Photograph.new(row)
    end
  end

end
