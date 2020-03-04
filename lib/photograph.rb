class Photograph
  attr_reader :name, :id, :artist_id, :year

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @artist_id = attributes[:artist_id]
    @year = attributes[:year]
  end

end
