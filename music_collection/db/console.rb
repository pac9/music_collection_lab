require('pry')
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => 'Abba'
  })
artist1.save()

artist2 = Artist.new({
  'name' => 'Dolly Parton'
  })
artist2.save()


album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Gold',
  'genre' => 'Pop'
  })
album1.save()

album2 = Album.new({
  'artist_id' => artist2.id,
  'title' => 'Dolly Parton Hits',
  'genre' => 'Country'
  })
album2.save()

album3 = Album.new({
  'artist_id' => artist2.id,
  'title' => 'Dolly on tour',
  'genre' => 'Country'
  })
album3.save()

binding.pry
nil
