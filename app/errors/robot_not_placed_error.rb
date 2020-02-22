class RobotNotPlacedError < StandardError
  def message
    'Robot is not placed'
  end
end
