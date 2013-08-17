class Presentation
  class Slide

    # TODO: create different/customizable slide layouts

    attr_accessor :title, :subtitle, :code, :list, :code_offset_top

    def code_offset_top
      @code_offset_top ||= 0
    end

    def slide_padding
      (@window.width / 100) * 5
    end

    def create_text(text, font_family: 'Arial', font_size: 80, line_spacing: 10, max_width: nil, align: :center)
      max_width ||= @window.width - slide_padding
      Gosu::Image.from_text(@window, text, font_family, font_size, line_spacing, max_width, align)
    end

    def title_text
      @title_text ||= create_text @title, font_size: 80, align: :center
    end

    def subtitle_text
      @subtitle_text ||= create_text @subtitle, font_size: 50, align: :center
    end

    def code_text
      @code_text ||= create_text @code, font_family: 'Courier', font_size: 50, align: :left
    end

    def list_as_string
      return '' unless @list
      @list.map do |line|
        line = '• ' + line
      end.join("\n")
    end

    def list_text
      @list_text ||= create_text list_as_string, font_size: 50, align: :left
    end

    def scroll_up
      @code_offset_top ||= 0
      @code_offset_top -= 5
    end

    def scroll_down
      @code_offset_top ||= 0
      @code_offset_top += 5
    end

    def draw(window)
      @window = window
      if code or list
        draw_normal_screen
      else
        draw_title_screen
      end
    end

    def draw_title_screen
      left = slide_padding
      top = (@window.height / 100) * 30
      title_text.draw(left, top, 0, 1, 1, 0xffffffff)
      subtitle_text.draw(left, top + title_text.height, 0, 1, 1, 0xffffffff)
    end

    def draw_normal_screen
      left = slide_padding
      top = (@window.height / 100) * 5
      title_text.draw(left, top, 0, 1, 1, 0xffffffff)
      code_text.draw(left, top + title_text.height + code_offset_top, 0, 1, 1, 0xffffffff)
      list_text.draw(left, top + title_text.height, 0, 1, 1, 0xffffffff)
    end

  end
end