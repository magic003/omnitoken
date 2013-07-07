require 'singleton'

module GT
  class Registry
    include Singleton

    @@registry = {
      twitter: GT::Provider::Twitter
    }

    def initialize
      @providers = {}
    end

    def [](id)
      id = id.to_sym
      if @providers[id].nil? && @@registry.include?(id)
         @providers[id] = @@registry[id].new
      end

      @providers[id]
    end

  end
end
