module KitchenToolkit
  class Suite

    attr_reader :name, :attrs

    def initialize(attrs = {})
      @name  = attrs.fetch(:name)
      @attrs = attrs
    end

    def to_s
      name
    end
  end
end
