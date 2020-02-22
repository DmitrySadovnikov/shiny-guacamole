class Point
  X_RANGE = (0..ENV['TABLE__WIDTH'].to_i).freeze
  Y_RANGE = (0..ENV['TABLE__HEIGHT'].to_i).freeze

  attr_reader :x, :y, :errors

  def initialize(x, y)
    @x = x
    @y = y
    @errors = []
  end

  def valid?
    validate
    errors.empty?
  end

  private

  def validate
    errors << :x_empty unless x
    errors << :y_empty unless y
    return unless errors.empty?

    errors << :x_invalid unless x.is_a?(Integer)
    errors << :y_invalid unless y.is_a?(Integer)
    return unless errors.empty?

    errors << :x_out_of_range unless X_RANGE.include?(x)
    errors << :y_out_of_range unless Y_RANGE.include?(y)
  end
end
