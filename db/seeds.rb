# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 4 categories
# different number of tools and attributes
class Seed
  def initialize
    create_categories
    create_power_tools
    create_shovels
    create_saws
    create_auto_tools
  end

  def create_categories
    @cat1 = Category.create(name: "Power Tools")
    @cat2 = Category.create(name: "Shovels")
    @cat3 = Category.create(name: "Saws")
    @cat4 = Category.create(name: "Automotive")
    puts "Created four categories."
  end

  def create_power_tools
    5.times do |n|
      Tool.create(name: "power#{n}",
                  description: "Description for power#{n}.",
                  price: "#{n}",
                  image_path: Faker::Avatar.image,
                  category_id: @cat1.id
                  )
    end
    puts "Created five power tools"
  end

  def create_shovels
    7.times do |n|
      Tool.create(name: "shovel#{n}",
                  description: "Description for shovel#{n}.",
                  price: "#{n}",
                  image_path: Faker::Avatar.image,
                  category_id: @cat2.id
                  )
    end
    puts "Created seven shovels."
  end

  def create_saws
    9.times do |n|
      Tool.create(name: "saw#{n}",
                  description: "Description for saw#{n}.",
                  price: "#{n}",
                  image_path: Faker::Avatar.image,
                  category_id: @cat3.id
                  )
    end
    puts "Created nine shovels."
  end

  def create_auto_tools
    11.times do |n|
      Tool.create(name: "auto#{n}",
                  description: "Description for auto#{n}.",
                  price: "#{n}",
                  image_path: Faker::Avatar.image,
                  category_id: @cat4.id
                  )
    end
    puts "Created eleven saws."
  end
end

Seed.new
