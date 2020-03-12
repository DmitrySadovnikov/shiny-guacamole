module Robots
  class Move < ApplicationService
    STEP = 1

    param :robot
    option :point, default: -> { robot.point }
    option :facing, default: -> { robot.facing }
    option :dry_run, optional: true

    def call
      return if Obstacles::Retrieve.call(new_point)
      return unless new_point.valid?
      return new_point if dry_run

      robot.point = new_point if new_point.valid?
    end

    private

    def new_point
      @new_point ||=
        case facing
        when :north then Point.new(point.x, point.y + STEP)
        when :east then Point.new(point.x + STEP, point.y)
        when :south then Point.new(point.x, point.y - STEP)
        when :west then Point.new(point.x - STEP, point.y)
        end
    end
  end
end
