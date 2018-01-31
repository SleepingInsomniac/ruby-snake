module Snake
  class Player
    attr_reader :head, :segments
    attr_accessor :alive

    def initialize(update_interval: 0.05)
      @update_interval = update_interval
      @last_update = Time.now

      @head = Entity.new(size: Vector[1,1])
      @speed = Vector[1,0]
      @segments = []
      @length = 1
      @alive = true
    end

    def grow(amount = 1)
      @length += amount
    end

    def update
      return unless update?
      segment = Entity.new(size: Vector[1,1], position: @head.position)
      @head.position += @speed
      @segments.unshift(segment)
      @segments = @segments[0..@length] # Trim snek
    end

    def update?
      return false unless alive?
      return true unless @update_interval
      if Time.now.to_f - @last_update.to_f >= @update_interval
        @last_update = Time.now
      else
        false
      end
    end

    def eating?(edible)
      @head.position == edible.position
    end

    def crashed?
      @segments.map(&:position).include? @head.position
    end

    def die!
      @alive = false
    end

    def alive?
      @alive
    end

    # Controls

    def up
      @speed = Vector[0,-1] unless @speed == Vector[0,1]
    end

    def down
      @speed = Vector[0,1] unless @speed == Vector[0,-1]
    end

    def left
      @speed = Vector[-1,0] unless @speed == Vector[1,0]
    end

    def right
      @speed = Vector[1,0] unless @speed == Vector[-1,0]
    end
  end
end
