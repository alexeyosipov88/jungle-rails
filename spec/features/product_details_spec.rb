require 'rails_helper'

RSpec.feature "Users can navigate from the home page to the product detail page by clicking on a product.", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They can see details of a product" do
    # ACT
    visit root_path

    first('.product').click_link('Details')
    # visit "/products/1"
    # within(".product") do
    #   click_on("Details")
    # end
    sleep 5
  
    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_content('Description')
  end
 
end