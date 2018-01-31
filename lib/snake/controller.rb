module Snake
  class Controller
    attr_reader :keys

    def initialize(map: {}, action_down: {}, action_up: {}, link: nil)
      @keys = Hash.new { false }
      @map = map
      @action_down = action_down
      @action_up = action_up
      @link = link
    end

    def down(id)
      if key = @map[id]
        @keys[key] = true
        @link.public_send(@action_down[key]) if @action_down[key]
      end
    end

    def up(id)
      if key = @map[id]
        @keys.delete(key)
        @link.public_send(@action_up[key]) if @action_up[key]
      end
    end
  end
end
