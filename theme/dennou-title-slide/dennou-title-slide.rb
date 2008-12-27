## IMAGE PATH の追加
add_image_path("dennou-images")
@title_left ||= "vgrad_left.png"
@title_right ||= "vgrad_right.png"
@title_logo ||= "GFD-logo.png"


match(TitleSlide) do |slides|
  slides.vertical_centering = true
  slides.margin_left = @margin_left
  slides.margin_right = @margin_right
  slides.margin_top = @margin_top
  slides.margin_bottom = @margin_bottom
end

match(TitleSlide, Author) do |authors|
  authors.margin_top = @space * 2
  authors.margin_bottom = @space * 2
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

match(TitleSlide) do |slides|
  name1 = "title-slide"
  slides.delete_post_draw_proc_by_name(name1)
  slides.add_pre_draw_proc(name1, &title_sidebar)
  name2 = "title-logo"
  slides.delete_pre_draw_proc_by_name(name2)
  slides.add_pre_draw_proc(name2, &title_logo)
end

