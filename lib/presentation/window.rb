class Presentation
  class Window < Gosu::Window

    def initialize(slide_deck)
      @slide_deck = slide_deck
      super(1200, 600, true) # TODO: set to fullscreen when Gosu fixes issue #157
    end

    def button_down(button)
      case button
      when Gosu::KbEscape then close
      when Gosu::KbRight, Gosu::KbSpace, Gosu::KbReturn
        @slide_deck.next_slide
      when Gosu::KbLeft
        @slide_deck.previous_slide
      else
        # @slide_deck.current_slide.button_down
      end
    end

    def update
      @slide_deck.current_slide.scroll_up if button_down? Gosu::KbDown
      @slide_deck.current_slide.scroll_down if button_down? Gosu::KbUp
    end
    
    def draw
      @slide_deck.current_slide.draw(self)
    end

  end
end