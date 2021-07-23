class Admin::DashboardController < ApplicationController
  def show
    @products = Product.count
    @line_items = LineItem.count
    @categories = Category.count
  end
end
