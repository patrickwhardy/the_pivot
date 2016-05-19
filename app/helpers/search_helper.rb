module SearchHelper
  def location_search_form
    text_field_tag(
      :location,
      params[:location],
      class: "form-control",
      placeholder: "Where to?"
    )
  end

  def checkin_search_form
    text_field_tag(
      :checkin,
      params[:checkin],
      class: "date-picker form-control",
      placeholder: "Arrival"
    )
  end

  def checkout_search_form
    text_field_tag(
      :checkout,
      params[:checkout],
      class: "date-picker form-control",
      placeholder: "Departure"
    )
  end
end
