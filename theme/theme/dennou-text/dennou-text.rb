include_theme("default-text")

match(Slide, "**") do |elems|
  elems.prop_set("weight", "normal")
end

match(Slide, HeadLine) do |heads|
  heads.prop_set("size", @x_large_font_size)
  heads.prop_set("foreground", "#FFF")
  if @bold_font_family
    set_font_family(heads, @bold_font_family)
  else
    heads.prop_set("weight", "bold")
  end
end

match("**", PreformattedText) do |texts|
  texts.prop_set("size", @normal_font_size)
  set_font_family(texts, @monospace_font_family)
end

match("**", Keyword) do |texts|
  set_font_family(texts, @monospace_font_family)
end

match("**", Comment) do |texts|
  set_font_family(texts, @monospace_font_family)
end

slide_body = [Slide, Body]

item_list_item = [ItemList, ItemListItem]

@default_item1_mark_color ||= "#050077"
@default_item2_mark_color ||= "#000"
@default_item3_mark_color ||= "#034f00"
@default_enum_item1_mark_color ||= "#000"
@default_enum_item2_mark_color ||= "#034f00"
@default_item1_mark_type ||= "rectangle"
@default_item2_mark_type ||= "circle"
@default_item3_mark_type ||= "circle"
@default_enum_item1_mark_type ||= "circle"
@default_enum_item2_mark_type ||= "circle"


match(*(slide_body + (item_list_item * 1))) do
#  prop_set("foreground", @default_item1_mark_color)
end

match(*(slide_body + (item_list_item * 2))) do
  prop_set("size", @small_font_size)
#  prop_set("foreground", @default_item2_mark_color)
end

match(*(slide_body + (item_list_item * 3))) do
  prop_set("size", @x_small_font_size)
#  prop_set("foreground", @default_item3_mark_color)
end

enum_list_item = [EnumList, EnumListItem]

match(*(slide_body + (enum_list_item * 1))) do
#  prop_set("foreground", @default_item1_mark_color)
end

match(*(slide_body + (enum_list_item * 2))) do
  prop_set("size", @small_font_size)
#  prop_set("foreground", @default_item2_mark_color)
end

match(*(slide_body + (enum_list_item * 3))) do
  prop_set("size", @x_small_font_size)
#  prop_set("foreground", @default_item3_mark_color)
end

match(*(slide_body + enum_list_item + item_list_item)) do
  prop_set("size", @small_font_size)
#  prop_set("foreground", @default_enum_item1_mark_color)
end

match(*(slide_body + enum_list_item + (item_list_item * 2))) do
  prop_set("size", @x_small_font_size)
#  prop_set("foreground", @default_enum_item2_mark_color)
end



match("**", Subscript) do |texts|
  texts.prop_set("size", @script_font_size)
  texts.prop_set("rise", -(@script_font_size * 2 / 3.0).to_i)
end

match("**", Superscript) do |texts|
  texts.prop_set("size", @script_font_size)
  texts.prop_set("rise", (@script_font_size * 5 / 3.0).to_i)
end

match("**", HeadLine, "**", Subscript) do |texts|
  texts.prop_set("size", @large_script_font_size)
  texts.prop_set("rise", -(@large_script_font_size * 2 / 3.0).to_i)
end

match("**", HeadLine, "**", Superscript) do |texts|
  texts.prop_set("size", @large_script_font_size)
  texts.prop_set("rise", (@large_script_font_size * 5 / 3.0).to_i)
end

match("**", Title, "**", Subscript) do |texts|
  texts.prop_set("size", @x_large_script_font_size)
  texts.prop_set("rise", -(@x_large_script_font_size * 2 / 3.0).to_i)
end

match("**", Title, "**", Superscript) do |texts|
  texts.prop_set("size", @x_large_script_font_size)
  texts.prop_set("rise", (@x_large_script_font_size * 5 / 3.0).to_i)
end

