class Cart
  attr_reader :contents

  def initialize(session_contents)
    @contents = session_contents || {}
  end

  def add_tool(tool_id)
    @contents[tool_id] ||= 0
    @contents[tool_id] += 1
  end

  def toolbag
    @contents.transform_keys { |key| Tool.find(key) }
  end

  def cart_total(toolbag)
    toolbag.map do |tool, quantity|
      tool.price * quantity
    end.reduce(:+)
  end


end
