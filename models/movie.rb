require_relative('../db/sql_runner.rb')

class Movie

  attr_accessor :title, :genre, :id

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

  def save() #CREATE
    sql = "INSERT INTO movies (title, genre)
          VALUES ($1, $2) RETURNING id"
    values = [@title, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM movies"
    result = SqlRunner.run(sql)
    movies = result.map{|movie| Movie.new(movie)}
    return movies
  end

  def update() #UPDATE
    sql = "UPDATE movies SET (title, genre) = ($1, $2) WHERE id = $3"
    values = [@title, @genre, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete() #DELETE
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def stars() #FINDS STARS
    sql = "SELECT stars.* FROM stars
           INNER JOIN castings
           ON stars.id = castings.star_id
           WHERE castings.movie_id = $1;"
    values = [@id]
    stars_data = SqlRunner.run(sql, values)
    result = stars_data.map{|star| Star.new(star)}
    return result
  end

  def remaining_budget() #EXTENSION 
    cost = 0
    sql = "SELECT castings.fee FROM castings WHERE castings.movie_id = $1"
    values = [@id]
    fees = SqlRunner.run(sql, values)
    for fee in fees
      cost += fee['fee'].to_i
    end
    return remaining = @budget - cost
  end

end
