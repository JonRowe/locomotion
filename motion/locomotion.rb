module Locomotion
  class << self

    def watch opts = {}, &block
      watchman.process opts
      watchman.listeners << block
      watchman.go
    end

    def defer time
      watchman.pause time
    end

    def stop
      watchman.clear
    end

    def watchman
      @watchman ||= Watchman.alloc.init
    end

  end
end
