module Snake
  class Window < Gosu::Window
    def initialize
      super(640, 480)
      self.caption = "Snake"
      @scale = 20
      @controller = Controller.new(
        map: {
          82 => :up,
          81 => :down,
          80 => :left,
          79 => :right,
        },
        action_down: {
          up: :up,
          down: :down,
          left: :left,
          right: :right
        }
      )
      new_game!
    end

    def new_game!
      @player = Player.new
      @controller.link = @player
      generate_apple
    end

    def button_down(id)
      @controller.down(id)
    end

    def button_up(id)
      @controller.up(id)
    end

    def update
      @player.update
      if @player.eating?(@apple)
        @player.grow(rand(1..5))
        generate_apple
      end
      new_game! if @player.crashed?
      new_game! unless in_bounds?(@player.head)
    end

    def draw
      draw_rect *@player.head.rect(@scale)
      @player.segments.each do |segment|
        draw_rect *segment.rect(@scale)
      end
      draw_rect *@apple.rect(@scale)
    end

    def scaled_width
      width / @scale - 1
    end

    def scaled_height
      height / @scale - 1
    end

    def in_bounds?(entity)
      pos = entity.position
      (0..scaled_width).include?(pos[0]) && (0..scaled_height).include?(pos[1])
    end

    def generate_apple
      x = rand(0..scaled_width)
      y = rand(0..scaled_height)
      @apple = Entity.new(position: Vector[x,y], size: Vector[1,1], color: Gosu::Color::RED, z_index: 0)
    end
  end
end
