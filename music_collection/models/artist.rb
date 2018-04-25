require_relative("../db/sql_runner")
require_relative("album.rb")

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

 def save()
   sql = "INSERT INTO artists
   (name)
   VALUES
   ($1)
   RETURNING *"
   values = [@name]
   returned_array = SqlRunner.run(sql, values)
   artist_hash = returned_array[0]
   id_string = artist_hash["id"]
   @id = id_string.to_i
 end

 def self.all()
   sql = "SELECT * FROM artists"
   artist_hashes = SqlRunner.run(sql)
   artist_objects = artist_hashes.map{|artist| Artist.new(artist)}
   return artist_objects
 end
end
