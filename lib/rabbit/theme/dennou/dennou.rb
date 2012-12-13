# -*- coding: utf-8 -*-
#--------------------------------------
# font size setup
#--------------------------------------
@xxx_large_font_size = screen_size(8 * Pango::SCALE)
@xx_large_font_size  = screen_size(4.5 * Pango::SCALE)
@x_large_font_size   = screen_size(4 * Pango::SCALE)
@large_font_size     = screen_size(3.8 * Pango::SCALE)
@normal_font_size    = screen_size(3 * Pango::SCALE)
@small_font_size     = screen_size(2.8 * Pango::SCALE)
@x_small_font_size   = screen_size(2.5 * Pango::SCALE)
@xx_small_font_size  = screen_size(1.5 * Pango::SCALE)
@xxx_small_font_size = screen_size(1.0 * Pango::SCALE)
# script font size
@script_font_size         = @xxx_small_font_size
@large_script_font_size   = @xx_small_font_size
@x_large_script_font_size = @xsmall_font_size
#--------------------------------------
@title_slide_title_font_size = @xxx_large_font_size
#--------------------------------------
# font family setup
#--------------------------------------
@default_font   ||= "Sans"
@bold_font      ||= "Sans"
@monospace_font ||= "Monospace"
@font_family = find_font_family(@default_font)
@monospace_font_family = find_font_family(@monospace_font)
@bold_font_family = find_font_family(@bold_font)
#--------------------------------------
# add image path
#--------------------------------------
add_image_path("dennou-images")
add_image_path("ruby-images")
add_image_path("rabbit-images")
#-------------------------
# forground color
#-------------------------
@slide_headline_hide = true
@default_headline_line_width = 0
#--------------------------------------
# set color of description term underline
#--------------------------------------
@description_term_line_color = "#ff9900"
#--------------------------------------
# set image caption size
#--------------------------------------
# @image_frame_width = 0.0
@image_caption_font_size = @xxx_small_font_size
#----------------------------------------
# set slide number at top-right
#----------------------------------------
@slide_number_props = {
  "size" => @xx_small_font_size * 0.8,
  "font_family" => @bold_font
}
@slide_number_position = :top
@slide_number_color = "#fff"
#--------------------------------------
# set preformatted text area
#--------------------------------------
@preformatted_frame_color = "#5500ff"
@preformatted_frame_width = 0.5
@preformatted_fill_color  = "#ffffff"
@preformatted_shadow_color = nil
@centering_preformatted_block = true
#----------------------------------------
# set itemmark color
#----------------------------------------
@default_item1_mark_color = "#050077"
@default_item2_mark_color = "#000000"
@default_item3_mark_color = "#034f00"
@default_enum_item1_mark_color = "#000000"
@default_enum_item2_mark_color = "#034f00"
@default_item1_mark_type = "rectangle"
@default_item2_mark_type = "circle"
@default_item3_mark_type = "circle"
@default_enum_item1_mark_type = "circle"
@default_enum_item2_mark_type = "circle"
#--------------------------------------
# use default theme
#--------------------------------------
include_theme("default")
@title_shadow_color = "#c09090cc"
include_theme("title-shadow")
include_theme("image-timer")
#----------------------------------------
# change reference text style
#----------------------------------------
match("**", ReferText) do |texts|
  texts.prop_set("underline", "none")
  texts.prop_set("foreground", "blue")
end
#----------------------------------------
# title slide
#----------------------------------------
@title_left  ||= "vgrad_left.png"
@title_right ||= "vgrad_right.png"
@title_logo  ||= "GFD-logo.png"
match(TitleSlide) do |slides|
  slides.vertical_centering = true
  slides.margin_left = @margin_left
  slides.margin_right = @margin_right
  slides.margin_top = @margin_top
  slides.margin_bottom = @margin_bottom
end
# --- grad
loader_left = ImageLoader.new(find_file(@title_left))
loader_right = ImageLoader.new(find_file(@title_right))
title_sidebar = Proc.new do |slide, canvas, x, y, w, h, simulation|
  unless simulation
    sidebar_width = canvas.width * 0.1
    loader_left.resize(sidebar_width, canvas.height)
    sidebar_height = canvas.height - loader_left.height
    loader_left.draw(canvas, 0, sidebar_height)
    loader_right.resize(sidebar_width, canvas.height)
    loader_right.draw(canvas, (canvas.width - sidebar_width), sidebar_height)
  end
  [x, y, w, h]
end
# --- set logo
loader = ImageLoader.new(find_file(@title_logo))
title_logo = Proc.new do |slide, canvas, x, y, w, h, simulation|
  unless simulation
    logo_width = canvas.width * 0.2
    logo_height = logo_width
    loader.resize(logo_width, logo_height)
    draw_x = canvas.width - logo_width
    draw_y = canvas.height - logo_height
    loader.draw(canvas, draw_x, draw_y)
  end
  [x, y, w, h]
end
# --- draw sidebar and logo
match(TitleSlide) do |slides|
  name1 = "title-slide"
  slides.delete_post_draw_proc_by_name(name1)
  slides.add_pre_draw_proc(name1, &title_sidebar)
  name2 = "title-logo"
  slides.delete_pre_draw_proc_by_name(name2)
  slides.add_pre_draw_proc(name2, &title_logo)
end
# --- add sidebar margin
match(TitleSlide, "*") do |elems|
  elems.horizontal_centering = true
  elems.margin_left = canvas.width * 0.1
  elems.margin_right = canvas.width * 0.1
end
#----------------------------------------
# slide centering?
#----------------------------------------
@slide_centering = true
slide_body = [Slide, Body]
match(*slide_body) do |bodies|
  bodies.vertical_centering = @slide_centering
end
#----------------------------------------
# default slide
#----------------------------------------
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
#----------------------------------------
# text properity
#----------------------------------------
match(Slide, HeadLine) do |heads|
  heads.prop_set("size", @x_large_font_size)
  heads.prop_set("foreground", "#FFF")
  heads.prop_set("weight", "bold")
end
#----------------------------------------
# TAKAHASHI method !!
#----------------------------------------
@lightning_talk_proc_name = "lightning-dennou"
@lightning_talk_as_large_as_possible = true
include_theme("lightning-talk-toolkit")
match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk?
      slide.headline.margin_left = @margin_left
      slide.lightning_talk
    end
  end
end
include_theme("per-slide-background-image")
