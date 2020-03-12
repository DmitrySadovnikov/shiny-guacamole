module Obstacles
  class Place < ApplicationService
    param :x
    param :y

    def call
      obstacle = Obstacle.new(point)
      Obstacle.list << obstacle
      obstacle
    end

    private

    def point
      @point ||= Point.new(x, y)
    end
  end
end
