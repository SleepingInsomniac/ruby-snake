require 'matrix'

module Snake
  class Entity
    attr_accessor :position, :size, :speed, :color, :z_index

    def initialize(position: Vector[0,0], size: Vector[0,0], speed: Vector[0,0], color: Gosu::Color::WHITE, z_index: 1)
      @position = position
      @size = size
      @speed = speed
      @color = color
      @z_index = z_index
    end

    def update
      @position += @speed
    end

    def rect(scale = 1)
      [
        @position[0] * scale, @position[1] * scale, # x, y
        @size[0] * scale, @size[0] * scale, # width, height
        @color,
        @z_index
      ]
    end
  end
end
