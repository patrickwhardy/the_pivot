FactoryGirl.define do
  factory :photo do
    image { File.new("#{Rails.root}/spec/asset_specs/photos/photo.jpeg") } 
  end
end
