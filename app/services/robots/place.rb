module Robots
  class Place < ApplicationService
    param :x
    param :y
    param :facing

    def call
      return unless robot.valid?
      return if Obstacles::Retrieve.call(point)

      Robot.current = robot
    end

    private

    def point
      @point ||= Point.new(x, y)
    end

    def robot
      @robot ||= Robot.new(point, facing)
    end
  end
end
