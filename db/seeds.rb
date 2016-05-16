class Seed
  def initialize
    create_users
    create_homes
  end

  def create_users
    puts "Creating Required Users"
    user = User.new(
      email: "josh@turing.io",
      password: "password",
      username: "josh@turing.io",
      first_name: "josh",
      last_name: "mejia",
      description: Faker::Lorem.paragraph(2)
    )
    user.slug = user.username.parameterize
    user.roles << Role.new(role: "admin")    
    puts user.save
    user = User.new(
      email: "andrew@turing.io",
      password: "password",
      username: "andrew@turing.io",
      first_name: "andrew",
      last_name: "carmer",
      description: Faker::Lorem.paragraph(2)
    )
    user.slug = user.username.parameterize
    user.roles << Role.new(role: "admin")    
    puts user.save
    user = User.new(
      email: "jorge@turing.io",
      password: "password",
      username: "jorge@turing.io",
      first_name: "jorge",
      last_name: "jorge",
      role: 1,
      description: Faker::Lorem.paragraph(2)
    )
    user.roles << Role.new(role: "admin")
    user.slug = user.username.parameterize
    puts user.save
    puts "Creating Generic Users"
    100.times do |n|
      user = User.new(
        email: Faker::Internet.email,
        password: "password",
        username: Faker::Internet.user_name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        description: Faker::Lorem.paragraph(2)
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
    puts "Creating Home Owners and Homes"
    50.times do |n|
      user = User.new(
        email: Faker::Internet.email,
        password: "password",
        username: Faker::Internet.user_name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        description: Faker::Lorem.paragraph(2)
      )
      user.slug = user.username.parameterize
      rand(1..3).times do |n|
        home = Home.new(
          name: generate_name,
          description: generate_description,
          price_per_night: Faker::Number.number(2),
          address: generate_address
        )
        home.photos << Photo.create(
          image: File.open(File.join(Rails.root, '/public/photos/tinyhome1.jpg'))
        )
        home.photos << Photo.create(
          image: File.open(File.join(Rails.root, '/public/photos/tinyhome2.jpg'))
        )
        user.homes << home
      end
      puts user.save
      puts "Creating Orders for User"
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

  def generate_address
    "#{Faker::Address.street_address} #{Faker::Address.city} #{Faker::Address.state_abbr} #{Faker::Address.zip}"
  end

  def generate_name
    "One Bedroom #{Faker::Hipster.word} friendly, centrally located tiny home"
  end

  def generate_description
    "This tiny home is close to #{Faker::Hipster.word} #{Faker::Company.suffix}, #{Faker::Hipster.word} #{Faker::Company.suffix}, and #{Faker::Hipster.word} #{Faker::Company.suffix}. Relaxing, comfortable, with great neighbords and #{Faker::Hipster.word} ammenities"
  end
end

Seed.new
