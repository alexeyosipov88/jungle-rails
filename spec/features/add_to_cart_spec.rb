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
  scenario "They can  click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one" do
    # ACT
    visit root_path
    @navbar = page.find("nav.navbar")
    expect(@navbar).to have_content(0)
    first('article.product').click_button('Add')
    sleep 5
    # DEBUG / VERIFY
    save_screenshot
    expect(@navbar).to have_content(1)
  end

end