require 'rails_helper'

feature 'User can sign in and out' do

  before do
    Restaurant.create(name: 'KFC')
  end

  context 'User not signed in and on the homepage' do
    it 'should see a \'Sign in\' and a \'Sign up \' link' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it 'can create restaurants only if logged in' do
      visit('/')
      click_link('Add a restaurant')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'can only edit/delete restaurants which it has created' do
      visit('/')
      click_link('Delete')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'user signed in on the homepage' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'a@mail.com')
      fill_in('Password', with: '123456')
      fill_in('Password confirmation', with: '123456')
      click_button('Sign up')
    end

    it 'should see \'Sign out\' Link' do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it 'should not see a \'Sign in\' Link' do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end


  end
end
