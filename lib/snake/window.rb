module Snake
  class Window < Gosu::Window
    def initialize
      super(640, 480)
      self.caption = "Snake"
      @scale = 10
      @player = Player.new
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
        },
        link: @player
      )
    end

    def button_down(id)
      @controller.down(id)
    end

    def button_up(id)
      @controller.up(id)
    end

    def update
      @player.update
    end

    def draw
      @player.segments.each do |segment|
        draw_rect *segment.rect(@scale)
      end
    end
  end
end
