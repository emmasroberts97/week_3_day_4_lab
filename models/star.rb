require_relative('../db/sql_runner.rb')

class Star

  attr_accessor :first_name, :last_name, :id

  def initialize(options)
    @id = options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save() #CREATE
    sql = "INSERT INTO stars (first_name, last_name)
          VALUES ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM stars"
    result = SqlRunner.run(sql)
    stars = result.map{|star| Star.new(star)}
    return stars
  end

  def update() #UPDATE
    sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete() #DELETE
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def movies() #FIND MOVIES
    sql = "SELECT movies.* FROM movies
           INNER JOIN castings
           ON movies.id = castings.movie_id
           WHERE castings.star_id = $1"
    values = [@id]
    movies_data = SqlRunner.run(sql, values)
    result = movies_data.map{|movie| Movie.new(movie)}
    return result
  end
end
