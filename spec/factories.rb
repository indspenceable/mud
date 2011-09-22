FactoryGirl.define do
  factory :player do
    id {|x| x}
    name "Danny"
    colors Hash.new
  end
end
