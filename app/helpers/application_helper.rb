module ApplicationHelper
  def price(number)
    "$#{number_with_precision(number, precision: 2)}"
  end

  def link_to_reserve(home)
   link_to(
     "#{price(home.price_per_night)} Per Night",
      user_home_path(home.user.slug, home),
      class: "center price btn btn-one btn-wide center-block"
    )
  end

  def remove_from_cart_link(reservation)
    link_to(
      "Remove From Cart",
      cart_path(
        home_id: reservation,
        checkin: reservation.checkin,
        checkout: reservation.checkout
      ),
      method: "delete",
      class: "btn btn-one"
    )
  end

  def link_to_reservation(reservation)
    link_to(
      reservation.name,
      user_home_path(reservation.home.user.slug, reservation.home)
    )
  end


  def link_to_suspend_or_reactivate_button(home)
    if !home.suspended?
      link_to "Suspend", admin_suspend_home_path(home), method: :patch, class: "btn btn-one"
    else
      link_to "Reactivate", admin_reactivate_home_path(home), method: :patch, class: "btn btn-one"
    end
  end
end
