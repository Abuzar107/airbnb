require "open-uri"

description = "Sample description text"

amenities_data = [
  {name: 'Balcony', icon: "balcony.svg"},
  {name: 'Bed linen', icon: "bed_linen.svg"},
  {name: 'Board games', icon: "board_games.svg"},
  {name: 'Carbon monoxide alarm', icon: "carbon_monoxide_alarm.svg"},
  {name: 'Coffee maker', icon: "coffee_maker.svg"},
  {name: 'Cooker', icon: "cooker.svg"},
  {name: 'Cooking basics', icon: "cooking_basics.svg", description: 'Pots and pans, oil, salt and pepper'},
  {name: 'Cot', icon: "cot.svg"},
  {name: 'Dedicated workspace', icon: "dedicated_workspace.svg"},
  {name: 'Dishes and cutlery', icon: "dishes_and_cutlery.svg", description: 'Bowls, chopsticks, plates, cups, etc.'},
  {name: 'Dishwasher', icon: "dishwasher.svg"},
  {name: 'Dryer', icon: "dryer.svg"},
  {name: 'Esssentials', icon: "essentials.svg", description: 'Towels, bed sheets, soap and toilet paper'},
  {name: 'Fire extinguisher', icon: "fire_extinguisher.svg"},
  {name: 'First aid kit', icon: "first_aid_kit.svg"},
  {name: 'Free parking', icon: "free_parking.svg"},
  {name: 'fridge', icon: "fridge.svg"},
  {name: 'Garden', icon: "garden.svg", description: 'An open space on the property usually covered in grass'},
  {name: 'Hangers', icon: "hangers.svg"},
  {name: 'Heating', icon: "heating.svg"},
  {name: 'Hot tub', icon: "hot_tub.svg"},
  {name: 'Hot water', icon: "hot_water.svg"},
  {name: 'Iron', icon: "iron.svg"},
  {name: 'Kitchen', icon: "kitchen.svg", description: 'Space where guests can cook their own meals'},
  {name: 'Lockbox', icon: "lockbox.svg"},
  {name: 'Microwave', icon: "microwave.svg"},
  {name: 'Mountain view', icon: "mountain_view.svg"},
  {name: 'Pool table', icon: "pool_table.svg"},
  {name: 'Private entrance', icon: "private_entrance.svg", description: 'Separate street or building entrance'},
  {name: 'Private pool', icon: "private_pool.svg" },
  {name: 'Shampoo', icon: "shampoo.svg"},
  {name: 'Smoke alarm', icon: "smoke_alarm.svg"},
  {name: 'TV', icon: "tv.svg"},
  {name: 'Washing machine', icon: "washing_machine.svg"},
  {name: 'Wifi', icon: "wifi.svg"},
]

amenities_data.each do |data|
  amenity = Amenity.create!(name: data[:name], icon: data[:icon], description: data[:description])
end

user = User.create!(
  email: 'test4@gmail.com',
  password: '123456',
)

profile = Profile.create!({
  name: Faker::Lorem.unique.sentence(word_count: 3),
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_name,
  city: Faker::Address.city,
  state: Faker::Address.state,
  country_code: Faker::Address.country_code,
  user_id: user.id
})

# attach local placeholder image instead of Faker remote URL
profile.picture.attach(io: File.open("db/images/property_1.png"), filename: "user.png")

2.times do |i|
  u = User.create!(
    email: "test#{i+5}@gmail.com",
    password: '123456',
  )

  p = Profile.create!({
    name: Faker::Lorem.unique.sentence(word_count: 3),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country_code: Faker::Address.country_code,
    user_id: u.id
  })

  p.picture.attach(io: File.open("db/images/property_#{i+2}.png"), filename: "p#{i+2}.png")
end

3.times do
  property = Property.create!(
    name: Faker::Lorem.unique.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 3),
    headline: Faker::Lorem.unique.sentence(word_count: 6),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country_code: Faker::Address.country_code,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    price: Money.from_amount((50..100).to_a.sample, "USD"),
    bedroom_count: rand(2..5),
    bed_count: rand(4..10),
    guest_count: rand(4..20),
    bathroom_count: rand(1..4),
    user_id: User.all.sample.id
  )

  # attach images
  2.times do
    property.images.attach(
      io: File.open("db/images/property_#{rand(1..12)}.png"),
      filename: "property.png"
    )
  end

  # attach random amenities
  rand(1..amenities_data.length).times do
    amenity = Amenity.all.sample
    property.amenities << amenity unless property.amenities.include?(amenity)
  end

  # create reviews
  rand(5..10).times do
    Review.create!(
      content: Faker::Lorem.paragraph(sentence_count: 10),
      cleanliness_rating: rand(1..5),
      accuracy_rating: rand(1..5),
      checkin_rating: rand(1..5),
      communication_rating: rand(1..5),
      location_rating: rand(1..5),
      value_rating: rand(1..5),
      property: property,
      user: User.all.sample
    )
  end
end
