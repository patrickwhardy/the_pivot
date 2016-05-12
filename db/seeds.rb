class Seed
  def initialize
    create_users
    create_homes
  end

  def create_users
    User.create(
      email: "josh@turing.io",
      password: "password",
      username: "josh@turing.io",
      first_name: "josh",
      last_name: "mejia"
    )
    User.create(
      email: "andrew@turing.io",
      password: "password",
      username: "andrew@turing.io",
      first_name: "andrew",
      last_name: "carmer"
    )
    User.create(
      email: "jorge@turing.io",
      password: "password",
      username: "jorge@turing.io",
      first_name: "jorge",
      last_name: "jorge",
      role: 1
    )
    100.times do |n|
      user = User.create(
        email: Faker::Internet.email,
        password: "password",
        username: Faker::Internet.user_name,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
      )
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
    end
  end
end

Seed.new

# 10 orders per registered customer
