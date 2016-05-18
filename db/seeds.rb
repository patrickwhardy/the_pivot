class Seed
  def initialize
    @addresses = get_addresses
    puts @addresses
    create_admins
    create_homes_and_owners
    create_generic_users
    create_demo_data
  end

  def create_demo_data
    puts "Creating Demo Data"
    # 8 homes in Denver in different neighborhoods
    # 3 owners owning each of these homes with full pictures and things
    # one reservation for each one in May or June
    # custom photos for each one
    # home owner account to create new home during demo and show reservation process
    # user account to show conflict when trying to reserve on already reserved date

    #shopping list: 24 tiny home picutres, 5 profile pictures
    josh = User.new(
      email: "jwashke@gmail.com",
      password: "password",
      username: "josh_turing",
      first_name: "josh",
      last_name: "lupercal",
      description: "I have the best tiny homes, You wont find better than these tiny homes."
    )
    josh.slug = josh.username.parameterize
    josh_home_one = Home.new(
      name: "One bedroom Tiny Home with a view",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "1510 Blake Street Denver CO 80202"
    )
    josh_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home1/1.jpg"))
    )
    josh_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home1/2.jpg"))
    )
    josh_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home1/interior.jpg"))
    )
    josh_home_two = Home.new(
      name: "Affordable pest friendly Tiny Home",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "8801 W Belleview Ave Littleton CO 80123"
    )
    josh_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home2/exterior.jpg"))
    )
    josh_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home2/exterior2.jpg"))
    )
    josh_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home2/interior.jpg"))
    )
    josh.homes << josh_home_one
    josh.homes << josh_home_two
    puts josh.save

    ashwin = User.new(
      email: "ashwin@example.com",
      password: "password",
      username: "ashwin_turing",
      first_name: "ashwin",
      last_name: "lupercal",
      description: "These are some pretty good tiny homes right here"
    )
    ashwin.slug = ashwin.username.parameterize
    ashwin_home_one = Home.new(
      name: "One bedroom Tiny Home with a view",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "4370 Quay St Wheat Ridge, CO 80033"
    )
    ashwin_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home3/exterior.jpg"))
    )
    ashwin_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home3/exterior2.jpg"))
    )
    ashwin_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home3/interior.jpg"))
    )
    ashwin_home_two = Home.new(
      name: "Affordable pest friendly Tiny Home",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "2960 Inca St Unit 107, Denver, CO 80202"
    )
    ashwin_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home4/home4.jpg"))
    )
    ashwin_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home4/interior.jpg"))
    )
    ashwin_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home4/interior2.jpg"))
    )
    ashwin_home_three = Home.new(
      name: "One bedroom Tiny Home with a view",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "106 S University Blvd Unit 13, Denver, CO 80209"
    )
    ashwin_home_three.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home5/exterior.JPG"))
    )
    ashwin_home_three.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home5/interior.jpg"))
    )
    ashwin_home_three.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home5/interior2.jpg"))
    )
    ashwin.homes << ashwin_home_one
    ashwin.homes << ashwin_home_two
    ashwin.homes << ashwin_home_three
    puts ashwin.save

    patrick = User.new(
      email: "patrick@example.com",
      password: "password",
      username: "patrick_turing",
      first_name: "patrick",
      last_name: "lupercal",
      description: "These are legally Tiny Homes, come and stay in them."
    )
    patrick.slug = ashwin.username.parameterize
    patrick_home_one = Home.new(
      name: "One bedroom Tiny Home with a view",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "4305 Zuni St, Denver, CO 80211"
    )
    patrick_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home6/exterior.jpg"))
    )
    patrick_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home6/exterior2.jpg"))
    )
    patrick_home_one.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home6/interior.jpg"))
    )
    patrick_home_two = Home.new(
      name: "Affordable pest friendly Tiny Home",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "10718 Troy St, Commerce City, CO 80022"
    )
    patrick_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home7/exterior.jpg"))
    )
    patrick_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home7/interior.jpg"))
    )
    patrick_home_two.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home7/interior2.jpg"))
    )
    patrick_home_three = Home.new(
      name: "Affordable pest friendly Tiny Home",
      description: generate_description,
      price_per_night: Faker::Number.number(2),
      address: "18062 E 104th Pl Unit C, Commerce City, CO 80022"
    )
    patrick_home_three.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home8/exterior.jpg"))
    )
    patrick_home_three.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home8/interior.jpg"))
    )
    patrick_home_three.photos << Photo.create(
      image: File.open(File.join(Rails.root, "/public/tiny_home_pictures/home8/interior2.jpg"))
    )
    patrick.homes << patrick_home_one
    patrick.homes << patrick_home_two
    patrick.homes << patrick_home_three
    puts patrick.save
  end

  def create_admins
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
  end

  def create_homes_and_owners
    puts "Creating Home Owners and Homes"
    50.times do |n|
      sleep(1) if n.even?
      @count = n
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
          address: @addresses.pop
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
          home_id: rand(1..@count),
          checkin: checkin,
          checkout: checkout
        )
        (checkin..checkout-1).each do |date|
          reservation.reservation_nights << ReservationNight.new(night: date)
        end
        order.reservations << reservation
        puts order.save
        puts order.errors.full_messages
      end
    end
  end


  def create_generic_users
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
        checkin = Faker::Date.forward(23)
        checkout = checkin + rand(1..10)
        reservation = Reservation.new(
          home_id: rand(1..50),
          checkin: checkin,
          checkout: checkout
        )
        (checkin..checkout-1).each do |date|
          reservation.reservation_nights << ReservationNight.new(night: date)
        end
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

  def get_addresses
    filepath = 'db/raw_addresses'
    array = IO.readlines(filepath)

    addresses = []

    array.each_with_index do |line, index|
      if index.even?
        address = [array[index].chomp, array[index + 1].chomp].join(", ")
        addresses << address
      end
    end

    addresses
  end
end

Seed.new
