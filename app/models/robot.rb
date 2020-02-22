class Robot
  FACINGS = %i[north east south west].freeze

  attr_accessor :point, :facing, :errors

  class << self
    def current
      @@current_robot ||= nil
    end

    def current=(robot)
      @@current_robot = robot
    end
  end

  def initialize(point, facing)
    @point = point
    @facing = facing&.to_sym
    @errors = []
  end

  def valid?
    validate
    errors.empty?
  end

  private

  def validate
    errors << :facing_empty unless facing
    errors << :point_empty unless point
    return unless errors.empty?

    errors << :point_invalid unless point.valid?
    errors << :facing_invalid unless FACINGS.include?(facing)
  end
end
