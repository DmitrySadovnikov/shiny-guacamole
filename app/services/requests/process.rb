module Requests
  class Process < ApplicationService
    param :request

    def call
      action, args = parse_request(request)
      case action
      when :exit then raise ExitError
      when :place then Robots::Place.call(*args)
      when :place_obstacle then Obstacles::Place.call(*args)
      when :move, :left, :right, :report, :find_path, :path_commands then robot_requests(action, args)
      else raise UnknownActionError
      end
    end

    private

    def robot_requests(action)
      raise RobotNotPlacedError unless robot

      case action
      when :move then Robots::Move.call(robot)
      when :left then Robots::Rotate.call(robot, :left)
      when :right then Robots::Rotate.call(robot, :right)
      when :report then puts Robots::Report.call(robot)
      end
    end

    def robot
      @robot ||= Robot.current
    end

    def parse_request(request)
      action, raw_args = request.strip.downcase.split(' ')
      args = [] unless raw_args
      args ||= raw_args.split(',').map { |string| integer?(string) ? string.to_i : string.strip }
      [action&.to_sym, args]
    end

    def integer?(string)
      true if Integer(string)
    rescue ArgumentError
      false
    end
  end
end
