class UnknownActionError < StandardError
  def message
    'Unknown action'
  end
end
