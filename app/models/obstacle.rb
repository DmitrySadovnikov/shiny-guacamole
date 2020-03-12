class Obstacle
  attr_reader :point

  class << self
    def list
      @@obstacle_list ||= []
    end
  end

  def initialize(point)
    @point = point
  end
end
