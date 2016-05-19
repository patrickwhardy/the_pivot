module HomesHelper
  def determine_active_photo(photo, photos)
    return "active" if photo == photos.first
    "inactive"
  end

  def link_to_show(home, user)
    link_to(
      "#{number_with_precision(home.price_per_night, precision: 2)} Per Night",
      user_home_path(user.slug, home),
      class: "center price btn btn-one btn-wide center-block"
     )
  end

  def link_to_edit(home, user)
    link_to(
      "Edit Home",
      edit_user_home_path(user.slug, home),
      class: "btn btn-one"
    )
  end

  def link_to_delete(home, user)
    link_to("Delete Home",
      user_home_path(user.slug, home),
      method: :delete,
      class: "btn btn-one"
    )
  end
end
