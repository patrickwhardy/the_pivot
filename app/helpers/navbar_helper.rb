module NavbarHelper
  def nav_search_field
    text_field_tag(
      :location,
      params[:location],
      class: "form-control",
      placeholder: "Where to?"
    )
  end

  def nav_search_button
    submit_tag(
      "Search",
      name: nil,
      class: "btn btn-one"
    )
  end

  def dashboard_link(current_user)
    if current_user
      link_to(
        "My Dashboard",
        dashboard_path(current_user.slug),
        class: "nav-link"
      )
    end
  end

  def link_to_login_or_logout(user)
    if current_user
      link_to(
        "Logout",
         logout_path,
         method: :delete,
         class: "nav-link"
      )
    else
      link_to(
        "Login",
        login_path,
        class: "nav-link"
      )
    end
  end
end
