FactoryGirl.define do
  factory :player do
    name "Danny"
    colors ({:test1 => :red, :test2 => :blue})
    room
  end

  factory :room do
    name "example room"
    desc "This is an example room"
  end
  
  factory :item do
    owner :factory => :room
    factory :basic_item, :class => Items::BasicItem do
      type "Items::BasicItem"
    end
  end
  
  factory :simple_item
end
