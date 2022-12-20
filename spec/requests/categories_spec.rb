require 'rails_helper'

RSpec.describe '/categories', type: :request do
  before(:example) do
    @user = User.create!(email: 'Yunus@gmail.com', name: 'yunus', password: '12345678', password_confirmation: '12345678')
    sign_in @user
  end

  let(:valid_attributes) do
    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    { name: 'ice cream', author: User.first, icon: file }
  end

  let(:invalid_attributes) do
    { name: 'chrismast gift' }
  end

  describe 'testing index' do
    it 'output index' do
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'testing new ' do
    it 'renders form' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'testing create' do
      it 'creates' do
        expect do
          post categories_url, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end
end
end
