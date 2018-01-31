module Snake
  class Player
    attr_reader :segments

    def initialize(update_interval: 0.05)
      @update_interval = update_interval
      @last_update = Time.now

      @head = Entity.new(size: Vector[1,1])
      @speed = Vector[1,0]
      @segments = [@head]
      @length = 5
    end

    def grow
      @length += 1
    end

    def update
      return unless update?
      segment = Entity.new(size: Vector[1,1], position: @segments.first.position + @speed)
      @segments.unshift(segment)
      @segments = @segments[0..@length] # Trim snek
    end

    def update?
      return true unless @update_interval
      if Time.now.to_f - @last_update.to_f >= @update_interval
        @last_update = Time.now
      else
        false
      end
    end

    # Controls

    def up
      @speed = Vector[0,-1]
    end

    def down
      @speed = Vector[0,1]
    end

    def left
      @speed = Vector[-1,0]
    end

    def right
      @speed = Vector[1,0]
    end
  end
end
