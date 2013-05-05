module Playhouse
  class ContextUsageError < ArgumentError
  end

  class ActorKeyError < ContextUsageError
    def initialize(context_name, actor_name)
      @context_name = context_name
      @actor_name = actor_name
    end
  end

  class InvalidActorKeyError < ActorKeyError
    def message
      "Actor key #{@actor_name.inspect} is not a symbol, for #{@context_name}"
    end
  end

  class UnknownActorKeyError < ActorKeyError
    def message
      "Unknown actor #{@actor_name.inspect} for #{@context_name}"
    end
  end

  class ContextValidationError < Exception
    def initialize(*params)
      @part_errors = {}
    end

    def for_part(part_name)
      @part_errors[part_name] || []
    end

    def add_to_part(part_name, error)
      @part_errors[part_name] ||= []
      @part_errors[part_name] << error
    end
  end

  class ActorValidationError < Exception
    def initialize(options)
      @part_name = options[:part_name]
    end

    attr_reader :part_name
  end

  class RequiredActorMissing < ActorValidationError
    def message
      "Missing actor #{@name}"
    end
  end
end