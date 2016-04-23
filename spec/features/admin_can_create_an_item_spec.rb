require "rails_helper"

RSpec.feature "Admin exists" do
  include SpecTestHelper

  scenario "logs in to create item" do
    # As an authenticated Admin:
    #   I can create an item.
    #     - An item must have a title, description and price.
    admin = create(:user, role: 1)
    Category.create(name: "Hammer")
    login_user(admin)
    assert_equal admin_dashboard_path, current_path
    click_on "Create New Tool"
    assert_equal admin_tools_new_path, current_path
    fill_in "Name", with: "Jackhammer"
    fill_in "Description", with: "Ipso quod quorum et"
    fill_in "Price", with: "20.00"
    # save_and_open_page
    fill_in "Image Path", with: "Image"
    #     - An item must belong to at least one category.
    select "Hammer", from: "tool_category_id"

    click_on "Create Tool"
    assert_equal "Jackhammer", Tool.last.name
    assert_equal "Ipso quod quorum et", Tool.last.description
    assert_equal 20.00, Tool.last.price
    assert_equal "Image", Tool.last.image_path



    #     - The title and description cannot be empty.
    #     - The title must be unique for all items in the system.
    #     - The price must be a valid decimal numeric value and greater than zero.
    #     - The photo is optional. If not present, a stand-in photo is used. (try using)
  end
end
