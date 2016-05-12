class Seed
  def initialize
    create_users
    create_homes
  end

  def create_users
    user = User.new(
      email: "josh@turing.io",
      password: "password",
      username: "josh@turing.io",
      first_name: "josh",
      last_name: "mejia"
    )
    user.slug = user.username.parameterize
    puts user.save
    User.new(
      email: "andrew@turing.io",
      password: "password",
      username: "andrew@turing.io",
      first_name: "andrew",
      last_name: "carmer"
    )
    user.slug = user.username.parameterize
    puts user.save
    User.new(
      email: "jorge@turing.io",
      password: "password",
      username: "jorge@turing.io",
      first_name: "jorge",
      last_name: "jorge",
      role: 1
    )
    user.slug = user.username.parameterize
    puts user.save
    100.times do |n|
      user = User.new(
        email: Faker::Internet.email,
        password: "password",
        username: Faker::Internet.user_name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
      )
      user.slug = user.username.parameterize
      puts user.save
      10.times do |n|
        order = Order.new(
          total: Faker::Number.number(4),
          user: user
        )
        reservation = Reservation.new(
          home_id: rand(1..1000),
          checkin: Faker::Date.forward(23),
          checkout: Faker::Date.forward(23)
        )
        order.reservations << reservation
        puts order.save
        puts order.errors.full_messages
      end
    end
  end

  def create_homes
    photo1 = Photo.new(
      image: File.open(File.join(Rails.root, '/public/photos/tinyhome1.jpg'))
    )
    photo2 = Photo.new(
      image: File.open(File.join(Rails.root, '/public/photos/tinyhome2.jpg'))
    )
    photo3 = Photo.new(
      image: File.open(File.join(Rails.root, '/public/photos/tinyhome3.jpg'))
    )
    20.times do |n|
      user = User.new(
        email: Faker::Internet.email,
        password: "password",
        username: Faker::Internet.user_name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
      user.slug = user.username.parameterize
      50.times do |n|
        home = Home.new(
          name: Faker::Hipster.words(3).join(" "),
          description: Faker::Hipster.sentence,
          price_per_night: Faker::Number.number(3),
          address: "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.state_abbr} #{Faker::Address.zip}",
        )
        home.photos << [photo1.dup, photo2.dup, photo3.dup]
        user.homes << home
      end
      puts user.save
      10.times do |n|
        order = Order.new(
          total: Faker::Number.number(4),
          user: user
        )
        checkin = Faker::Date.forward(23)
        checkout = checkin + rand(1..10)
        reservation = Reservation.new(
          home_id: rand(1..1000),
          checkin: checkin,
          checkout: checkout
        )
        order.reservations << reservation
        puts order.save
        puts order.errors.full_messages
      end
    end
  end
end

Seed.new
