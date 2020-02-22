class ApplicationService
  extend Dry::Initializer

  class << self
    def call(*args, &block)
      new(*args).call(&block)
    end

    def new(*args)
      super(*args)
    end
  end
end
