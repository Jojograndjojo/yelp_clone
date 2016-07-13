require 'rails_helper'

describe Review, type: :model do
  it 'is invalid if more than 5' do
    review = Review.new(rating: 345)
    expect(review).to have(1).error_on(:rating)
  end
end
