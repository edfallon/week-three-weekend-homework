require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("ticket.rb")


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()

    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = Customer.map_customers(customers)
    return result
  end

  def films()
  sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1;"
  values = [@id]
  films = SqlRunner.run(sql, values)
  return films.map{|films_hash| Film.new(films_hash)}
  end
  #customer1.films()

  def self.map_customers(customer_data)
    return customer_data.map{|customer_hash| Customer.new(customer_hash)}
  end

  def take_film_price_off_funds(film)
    if @funds >= film.price
    @funds -= film.price
    return true
    else
    return false
    end
  end

   def buy_ticket(film)
    if take_film_price_off_funds(film)
    Ticket.new({
      "customer_id" => @id,
      "film_id" => film.id
    }).save()
    else
    return false
   end
  end

  def count_number_of_tickets
    films.count
  end







end
