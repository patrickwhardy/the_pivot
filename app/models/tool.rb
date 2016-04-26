class Tool < ActiveRecord::Base

  def out_of_stock?
    inventory <= 0 if inventory
  end

  def display_availability
    self.out_of_stock? ? "Out of Stock" : (link_to "Add to Cart", cart_tools_path(tool: tool.id), method: "post", class: "btn btn-one btn-sm")
  end

end
