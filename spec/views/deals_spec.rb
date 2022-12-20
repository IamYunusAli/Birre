require 'rails_helper'

RSpec.describe 'purchases', type: :system do
  before(:example) do
    @user = User.create!(email: 'Yunus@gmail.com', name: 'Yunus', password: '12345678', password_confirmation: '12345678')
    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    @category = Category.create!(name: 'food', author: User.first, icon: file)
    @category1 = Category.create!(name: 'cars', author: User.first, icon: file)
    @transaction = Deal.create!(name: 'fruit', amount: 50, categories: [@category], author: @user)
    @transaction1 = Deal.create!(name: 'milk', amount: 111, categories: [@category], author: @user)
    sign_in @user
  end

  it 'shows the list of items in the category' do
    visit category_deals_path(@category)
    expect(page).to have_content('fruit')
    expect(page).to have_content('milk')
  end

  it 'shows the amount for a  evey item in category' do
    visit category_deals_path(@category)
    expect(page).to have_content('Amount: $50')
    expect(page).to have_content('Amount: $111')
  end

  it 'shows the amount of total sum' do
    visit category_deals_path(@category)
    expect(page).to have_content('$161')
  end

  it 'when clicked on the Add transation direct them to add transation form.' do
    visit category_deals_path(@category)
    find('a', text: 'Add Transaction').click
    expect(page).to have_current_path(new_category_deal_path(@category))
  end
end
