require_relative('../db/sql_runner.rb')

class Casting

  attr_accessor :movie_id, :star_id, :fee, :id

  def initialize(options)
    @id = options['id']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
    @fee = options['fee']
  end

  def save() #CREATE
    sql = "INSERT INTO castings (movie_id, star_id, fee)
          VALUES ($1, $2, $3) RETURNING id"
    values = [@movie_id, @star_id, @fee]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM castings"
    result = SqlRunner.run(sql)
    castings = result.map{|casting| Casting.new(casting)}
    return castings
  end

  def update() #UPDATE
    sql = "UPDATE castings SET (movie_id, star_id, fee) = ($1, $2, $3) WHERE id = $4"
    values = [@movie_id, @star_id, @fee, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete() #DELETE
    sql = "DELETE FROM castings WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end
end
