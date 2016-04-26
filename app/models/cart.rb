class Cart
  attr_reader :contents, :notice

  def initialize(session_contents)
    @contents = session_contents || {}
  end

  def add_tool(tool_id)
    @contents[tool_id.to_s] ||= 0
    @contents[tool_id.to_s] += 1
  end

  def toolbag
    @toolbag ||= @contents.transform_keys { |key| Tool.find(key) }
  end

  def total
    toolbag.inject(0) do |sum, (tool, qty)|   
      sum += tool.price * qty   
    end
  end

  def clear_contents
    @contents = {}
  end

  def quantity
    @contents.values.sum
  end

  def remove(tool_id)
    @contents.delete(tool_id)
  end

  def update_quantity(new_data)
    if new_data[:quantity].to_i == 0
      @contents.delete(new_data[:tool_id])
    else
      @contents[new_data[:tool_id]] = new_data[:quantity].to_i
    end

  end

  def subtotal(tool_id)
    tool = Tool.find(tool_id)
    tool.price * @toolbag[tool]
  end
end
