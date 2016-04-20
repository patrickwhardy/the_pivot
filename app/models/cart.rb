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
    @toolbag ||= @contents.transform_keys { |key| Tool.find(key) }
  end

  def cart_total
    toolbag.inject(0) do |sum, hash|
      sum += hash.first.price * hash.second
    end
  end

  def remove(tool_id)
    @contents.delete(tool_id)
  end
end
