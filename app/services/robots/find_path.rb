module Robots
  class FindPath < ApplicationService
    param :robot
    param :x
    param :y

    def call
      graph = path_graph
      return [] unless graph

      paths_coords(graph)
      paths.min_by(&:size)
    end

    private

    def paths
      @paths ||= []
    end

    def paths_coords(hsh, arr = [])
      return paths << arr if hsh == 'FINISH'

      hsh.keys.each { |k| paths_coords(hsh[k], arr.dup << k) }
    end

    def available_coords(x, y, prev_steps)
      result = [
        [x + 1, y],
        [x - 1, y],
        [x, y + 1],
        [x, y - 1]
      ]
      result -= prev_steps
      result.select do |coords|
        point = Point.new(*coords)
        point.valid? && !Obstacles::Retrieve.call(point)
      end
    end

    def path_graph(current_coords = robot.point.to_a, graph = {}, prev_steps = [])
      return 'FINISH' if current_coords == [x, y]

      available_coords = available_coords(*current_coords, prev_steps)
      return if available_coords == []

      prev_steps << current_coords
      available_coords.each do |coords|
        res = path_graph(coords, {}, prev_steps)
        graph[coords] = res if res && res != {}
      end

      graph
    end
  end
end
