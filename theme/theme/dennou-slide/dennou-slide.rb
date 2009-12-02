match(Slide) do
  margin_set(@margin_top, @margin_right, @margin_bottom, @margin_left)
end

add_image_path("dennou-images")
@slide_header ||= "hgrad_top.png"
@slide_footer ||= "hgrad_bottom.png"
@slide_banner ||= "GFD-banner.png"

loader_head = ImageLoader.new(find_file(@slide_header))
match("**", HeadLine) do |heads|
  heads.each do |head|
    head.add_pre_draw_proc("header_bg") do |canvas, x, y, w, h, simulation|
      unless simulation
        height = head.height + @margin_top + @margin_bottom
        loader_head.resize(canvas.width, height)
        loader_head.draw(canvas, x + w - loader_head.width, 0)
      end
      [x, y, w, h]
    end
    head.margin_bottom = @margin_bottom * 1.5
  end
end


@slide_number_props ||= {
  "size" => @x_small_font_size,
  "font_family" => @bold_font
}
@slide_number_color ||= "#000"
match(Slide) do |slides|
  break if @slide_number_uninstall
  unless @not_use_slide_number
    slides.add_post_draw_proc("slide_number") do |slide, canvas, x, y, w, h, simulation|
      unless simulation
        text = Text.new("#{canvas.current_index}/#{canvas.slide_size - 1}")
        text.font @slide_number_props
        text.align = Pango::Layout::ALIGN_RIGHT
        text.compile(canvas, x, y, w, h)
        layout = text.layout
        layout.set_width(w * Pango::SCALE)
        num_y = @margin_top
        canvas.draw_layout(text.layout, x, num_y, @slide_number_color)
      end
    [x, y, w, h]
    end
  end
end

loader_foot = ImageLoader.new(find_file(@slide_footer))
loader_banner = ImageLoader.new(find_file(@slide_banner))
match(Slide) do |slides|
  slides.each do |slide|
    slide.add_post_draw_proc("footer") do |canvas, x, y, w, h, simulation|
      unless simulation
        foot_height = canvas.height / 18.0 + screen_y(1)*0.2
        loader_foot.resize(canvas.width, foot_height)
        loader_foot.draw(canvas, 0, canvas.height - foot_height)
        banner_height = canvas.height / 18.0
        loader_banner.resize(nil, banner_height)
        banner_pos_x = canvas.width - loader_banner.width
        banner_pos_y = canvas.height - loader_banner.height
        loader_banner.draw(canvas, banner_pos_x, banner_pos_y)
      end
      [x, y, w, h]
    end
  end
end






