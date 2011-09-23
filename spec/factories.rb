FactoryGirl.define do
  factory :player do
    id {|x| x}
    name "Danny"
    colors ({:test1 => :red, :test2 => :blue})
    room
  end

  factory :room do
    id {|x| x}
    name "example room"
    desc "This is an example room"
  end
end
