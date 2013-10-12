# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :policy do
    name "MyString"
    description "MyText"
    company "MyString"
    address "MyText"
    start_date "2013-10-12"
    end_date "2013-10-12"
    status "MyString"
    amount 1.5
    interest_rate 1.5
    time_period "MyString"
    description_typetext "MyString"
    description_fulltext "MyText"
  end
end
