module Robots
  class Rotate < ApplicationService
    MAX_DEGREES = 360
    MIN_DEGREES = 0
    FACING_DEGREES = {
      north: 0,
      east: 90,
      south: 180,
      west: 270
    }.freeze
    ROTATIONS = {
      right: 90,
      left: -90
    }.freeze

    param :robot
    param :direction
    option :facing, default: -> { robot.facing }
    option :dry_run, optional: true

    def call
      return unless direction_degrees
      return new_facing if dry_run

      robot.facing = new_facing
    end

    private

    def new_facing
      @new_facing ||= begin
        result = facing_degrees + direction_degrees
        result = result.negative? ? MAX_DEGREES + result : result
        result = result == MAX_DEGREES ? MIN_DEGREES : result
        FACING_DEGREES.invert[result]
      end
    end

    def direction_degrees
      @direction_degrees ||= ROTATIONS[direction]
    end

    def facing_degrees
      @facing_degrees ||= FACING_DEGREES[facing]
    end
  end
end
