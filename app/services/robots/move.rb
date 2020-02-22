module Robots
  class Move < ApplicationService
    STEP = 1

    param :robot

    def call
      robot.point = new_point if new_point.valid?
    end

    private

    def new_point
      @new_point ||=
        case robot.facing
        when :north then Point.new(robot.point.x, robot.point.y + STEP)
        when :east then Point.new(robot.point.x + STEP, robot.point.y)
        when :south then Point.new(robot.point.x, robot.point.y - STEP)
        when :west then Point.new(robot.point.x - STEP, robot.point.y)
        end
    end
  end
end
