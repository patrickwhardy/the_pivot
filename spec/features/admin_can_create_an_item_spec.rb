require "rails_helper"

RSpec.feature "Admin exists" do
  include SpecTestHelper

  scenario "logs in to create item" do
    admin = create(:user, role: 1)
    Category.create(name: "Hammer")
    login_user(admin)

    assert_equal admin_dashboard_path, current_path

    click_on "Create New Tool"

    assert_equal new_admin_tool_path, current_path

    fill_in "Name", with: "Jackhammer"
    fill_in "Description", with: "Ipso quod quorum et"
    fill_in "Price", with: "20.00"
    fill_in "Image Path", with: "Image"
    select "Hammer", from: "tool_category_id"
    click_on "Create Tool"

    assert_equal tool_path(Tool.last.id), current_path
    assert_equal "Jackhammer", Tool.last.name
    assert_equal "Ipso quod quorum et", Tool.last.description
    assert_equal 20.00, Tool.last.price
    assert_equal "Image", Tool.last.image_path
  end

  scenario "tool created without image path autopopulates image_path column" do
    admin = create(:user, role: 1)
    Category.create(name: "Hammer")
    login_user(admin)

    tool_name = "Jackhammer"

    assert_equal admin_dashboard_path, current_path
    click_on "Create New Tool"
    assert_equal new_admin_tool_path, current_path
    fill_in "Name", with: tool_name
    fill_in "Description", with: "Ipso quod quorum et"
    fill_in "Price", with: "20.00"
    select "Hammer", from: "tool_category_id"

    click_on "Create Tool"
    assert_equal "Jackhammer", Tool.last.name
    assert Tool.last.image_path.downcase.include?(tool_name.downcase)
  end
end
