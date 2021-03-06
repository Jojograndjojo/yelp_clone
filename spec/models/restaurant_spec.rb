require 'spec_helper'

describe Restaurant, type: :model do

  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: 'A')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

end
