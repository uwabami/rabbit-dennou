@title_slide_font_size = @normal_font_size
@title_slide_title_font_size = @xxx_large_font_size 
@title_slide_subtitle_font_size = @normal_font_size 
@title_slide_author_font_size = @x_large_font_size 
@title_slide_content_source_font_size = @x_small_font_size
@title_slide_institution_font_size = @x_small_font_size
@title_slide_place_font_size = @x_small_font_size
@title_slide_date_font_size = @x_small_font_size
@title_slide_note_font_size = @x_small_font_size

match(TitleSlide, "*") do |elems|
  elems.horizontal_centering = true
  elems.margin_left = canvas.width * 0.1
  elems.margin_right = canvas.width * 0.1
  elems.prop_set("size", @title_slide_font_size)
  set_font_family(elems)
end

match(TitleSlide, Title) do |titles|
  titles.prop_set("size", @title_slide_title_font_size)
  if @bold_font
    set_font_family(titles, @bold_font_family)
  else
    titles.prop_set("weight", "bold")
  end
end

match(TitleSlide, Subtitle) do |titles|
  titles.prop_set("size", @title_slide_subtitle_font_size)
  titles.margin_top = @space
end

match(TitleSlide, Author) do |titles|
  titles.prop_set("size", @title_slide_author_font_size)
#  titles.margin_bottom = @space * 0.01
end

match(TitleSlide, ContentSource) do |sources|
  sources.prop_set("size", @title_slide_content_source_font_size)
#  sources.margin_top = @space * 0.01
  sources.margin_bottom = @space
end

match(TitleSlide, Institution) do |institutions|
  institutions.prop_set("size", @title_slide_institution_font_size)
end

match(TitleSlide, Place) do |places|
  places.prop_set("size", @title_slide_place_font_size)
end

match(TitleSlide, Date) do |dates|
  dates.prop_set("size", @title_slide_date_font_size)
end

match(TitleSlide, "**", Note) do |texts|
  texts.prop_set("size", @title_slide_note_font_size)
end
