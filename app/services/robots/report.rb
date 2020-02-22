module Robots
  class Report < ApplicationService
    param :robot

    def call
      [robot.point.x, robot.point.y, robot.facing].map(&:to_s).join(',').upcase
    end
  end
end
