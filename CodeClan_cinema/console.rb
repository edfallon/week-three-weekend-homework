require_relative( 'models/customer.rb' )
require_relative( 'models/film.rb' )
require_relative( 'models/ticket.rb' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({
  "name" => "tom",
  "funds" => 20
  })

customer1.save()

customer2 = Customer.new({
  "name" => "dave",
  "funds" => 30
  })

customer2.save()

customer3 = Customer.new({
  "name" => "emma",
  "funds" => 40
  })

customer3.save()

film1 = Film.new({
  "title" => "finding nemo",
  "price" => 10
  })

  film1.save()

film2 = Film.new({
  "title" => "toy story",
  "price" => 10
  })

    film2.save()

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
  })

  ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film2.id
  })

  ticket2.save()

ticket3 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film1.id
  })

  ticket3.save()

# customer1.buy_ticket(film2)








binding.pry
nil
