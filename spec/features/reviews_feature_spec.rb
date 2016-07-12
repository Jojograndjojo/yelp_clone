require 'rails_helper'

feature 'reviewing' do
  let!(:kfc){ Restaurant.create(name:'KFC', description:'Finger licking good')}
  scenario 'allows users to leave a review' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Finger licking good INDEED!'
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(page).to have_content('Finger licking good INDEED!')
    expect(current_path).to eq '/restaurants'

  end
end
