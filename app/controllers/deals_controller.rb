class DealsController < ApplicationController
  before_action :set_deal, only: %i[show edit update destroy]
  before_action :set_category, except: %i[destroy create update]

  def index
    @categories = Category.where(author_id: current_user.id)
    @deals = @category.deals
    @total_amount = 0
    @deals.each do |deal|
      @total_amount += deal.amount
    end
  end

  def new
    @categories = Category.where(author_id: current_user.id)
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    @categories = Category.where(id: categories_params['categories'])
    @deal.categories << @categories
    @deal.author = current_user
    if @deal.save
      redirect_to category_deals_path, notice: 'Purchase was successfully created.'
    else
      redirect_to new_category_deal_path, alert: 'Failed to create purchase.'
    end
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
    @category = Category.find(params[:category_id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def deal_params
    params.require(:deal).permit(:name, :amount)
  end

  def categories_params
    params.require(:deal).permit(categories: [])
  end
end
