require "rails_helper"

RSpec.feature "Admin logs in with tools created" do
  include SpecTestHelper
  scenario "then can edit a tool" do
    # Background: an existing item
    # As an admin
    # When I visit "admin/items"
    # And I click "Edit"
    # Then my current path should be "/admin/items/:ITEM_ID/edit"
    # And I should be able to upate title, description, image, and status
    new_name = "name"
    new_description = "description"
    new_price = "111"
    new_image = "image"
    category = create(:category)
    tool = create(:tool, category_id: category.id)
    admin = create(:user, role: 1)
    login_user(admin)

    visit "/admin/tools"
    click_on "Edit"

    assert_equal "/admin/tools/#{tool.id}/edit", current_path

    fill_in "Name", with: new_name
    fill_in "Description", with: new_description
    fill_in "Price", with: new_price
    fill_in "Image Path", with: new_image
    click_on "Update Tool"

    assert_equal new_name, Tool.find(tool.id).name
    assert_equal tool_path(tool.id), current_path
    expect(page).to have_content new_description
  end
end
