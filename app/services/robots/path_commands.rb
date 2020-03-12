module Robots
  class PathCommands < ApplicationService
    param :robot
    param :x
    param :y

    def call
      return [] unless path_coords

      current_point = robot.point
      current_facing = robot.facing
      path_coords.map do |coord|
        current_point, current_facing =
          find(coord, current_facing, current_point, [:move]) ||
          find(coord, current_facing, current_point, %i[right move]) ||
          find(coord, current_facing, current_point, %i[right right move]) ||
          find(coord, current_facing, current_point, %i[left move])
      end
      commands
    end

    private

    def find(coord, facing, point, cmds)
      cmds.each do |cmd|
        case cmd
        when :move
          point = try_move(facing, point)
        when :right, :left
          facing = try_rotate(facing, cmd)
        end
      end
      return unless point.to_a == coord

      commands.concat(cmds)
      [point, facing]
    end

    def commands
      @commands ||= []
    end

    def path_coords
      @path_coords ||= FindPath.call(robot, x, y)
    end

    def try_move(new_facing, new_point)
      Move.call(robot, facing: new_facing, point: new_point, dry_run: true) || new_point
    end

    def try_rotate(new_facing, direction)
      Rotate.call(robot, direction, facing: new_facing, dry_run: true)
    end
  end
end
