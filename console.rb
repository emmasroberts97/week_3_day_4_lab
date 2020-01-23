require('pry')
require_relative('models/movie.rb')
require_relative('models/star.rb')
require_relative('models/casting.rb')


star1 = Star.new(
  {
    "first_name" => "Brad",
    "last_name" => "Pitt"
  }
)

star1.save()

star2 = Star.new(
  {
    "first_name" => "Leonardo",
    "last_name" => "DiCaprio"
  }
)

star2.save()

movie1 = Movie.new(
  {
    'title' => 'Once Upon a Time in Hollywood',
    'genre' => 'Tarantino'
  }
)

movie1.save()

movie2 = Movie.new(
  {
    'title' => "Mr and Mrs Smith",
    'genre' => "Action"
  }
)

movie2.save()


casting1 = Casting.new(
  {
  'movie_id' => movie1.id,
  'star_id' => star1.id,
  'fee' => '10000000'
  }
)

casting1.save()

casting2 = Casting.new(
  {
    'movie_id' => movie2.id,
    'star_id' => star1.id,
    'fee' => '5000000'
  }
)

casting2.save()

#star1.first_name = "Jim"
#star1.update()


movie1.genre = "Action"
movie1.update()











binding.pry
nil
