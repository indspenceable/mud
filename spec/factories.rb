FactoryGirl.define do
  factory :player do
    sequence :id 
    name "Danny"
    colors ({:test1 => :red, :test2 => :blue})
    room
  end

  factory :room do
    sequence :id 
    name "example room"
    desc "This is an example room"
  end
  
  factory :item do
    sequence :id
    owner :factory => :room
    factory :basic_item, :class => Items::BasicItem do
      type "Items::BasicItem"
    end
  end
end
