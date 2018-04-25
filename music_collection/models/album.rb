require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @artist_id = options["artist_id"].to_i
    @title = options["title"]
    @genre = options["genre"]

  end

  def artist()
  sql = "SELECT * FROM artists
  WHERE id = $1"
  values = [@artist_id]
  results = SqlRunner.run( sql, values )
  artist_data = results[0]
  artist = Artist.new(artist_data )
  return artist
end

  def save()
    sql = "INSERT INTO albums
    (artist_id,
     title,
     genre)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@artist_id, @title, @genre]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
      sql = "
      UPDATE albums SET (
        artist_id,
        title,
        genre
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4"
      values = [@artist_id, @title, @genre]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM albums
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end


  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    album_objects = album_hashes.map{|album| Album.new(album)}
    return album_objects
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    album = Album.new(album_hash)
    return album
  end

  def self.delete_all()
     sql = "DELETE FROM albums"
     SqlRunner.run(sql)
   end
end
