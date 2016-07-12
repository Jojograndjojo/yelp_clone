require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      fill_in 'Description', with: 'Finger licking good'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC')}

    scenario 'allows user to visit a restaurant page' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC', description:'Finger licking good')}

    scenario 'allows user to update restaurant page' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'VFC'
      fill_in 'Description', with: 'veggie fried chicken is a thing'
      click_button 'Update Restaurant'
      expect(page).to have_content 'VFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC', description:'Finger licking good')}

    scenario 'allows  user to delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted'
    end
  end
end
