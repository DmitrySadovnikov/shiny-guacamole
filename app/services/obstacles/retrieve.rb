module Obstacles
  class Retrieve < ApplicationService
    param :point

    def call
      Obstacle.list.find { |o| o.point.x == point.x && o.point.y == point.y }
    end
  end
end
