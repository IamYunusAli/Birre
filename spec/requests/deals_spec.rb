require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  before(:example) do
    @user = User.create!(email: 'Yunus@gmail.com', name: 'yunus', password: '12345678',
                         password_confirmation: '12345678')
    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    @category = Category.create!(name: 'ice cream', author: User.first, icon: file)
    sign_in @user
  end

  let(:valid_attributes) do
    { name: 'banana', amount: 120, author: @user, category: [@category] }
  end

  let(:post_attributes) do
    { name: 'juice', amount: 120, author: @user, category: [@category.id] }
  end

  let(:invalid_attributes) do
    { name: 'orange', amount: 50 }
  end

  describe 'testing index' do
    it 'successful response' do
      get category_deals_url(@category)
      expect(response).to be_successful
    end
  end

  describe 'tesing new' do
    it 'successful response' do
      get new_category_deal_url(@category)
      expect(response).to be_successful
    end
  end

  describe 'post' do
    it 'tesing to redirect to new category' do
      post category_deals_url(@category), params: { deal: post_attributes }
      expect(response).to redirect_to(new_category_deal_url)
    end
    it 'invalid input cannot creat' do
      expect do
        post category_deals_url(@category), params: { deal: invalid_attributes }
      end.to change(Deal, :count).by(0)
    end
  end
end
