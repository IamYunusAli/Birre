require 'rails_helper'

RSpec.describe 'groups', type: :system do
  before(:example) do
    @user = User.create!(email: 'Yunus@gmail.com', name: 'Yunus', password: '12345678',
                         password_confirmation: '12345678')
    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    @category = Category.create!(name: 'food', author: User.first, icon: file)
    @category1 = Category.create!(name: 'cars', author: User.first, icon: file)
    @transaction = Deal.create!(name: 'fruit', amount: 50, categories: [@category], author: @user)
    sign_in @user
  end

  it 'shows the list of added category' do
    visit categories_path
    expect(page).to have_content('food')
    expect(page).to have_content('cars')
  end

  it 'show the number of transation in each category' do
    visit categories_path
    expect(page).to have_content('Total Transactions: $50')
  end

  it 'clicking on Add category will send you too the form' do
    visit categories_path
    find('a', text: 'ADD CATEGORY').click
    expect(page).to have_current_path(new_category_path)
  end
end
