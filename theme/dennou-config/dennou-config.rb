@x_large_script_font_size = @x_large_font_size / 2
@large_script_font_size = @large_font_size / 2
@script_font_size = @normal_font_size / 2

@space = screen_y(2)

@margin_left = screen_x(3)
@margin_right = screen_x(3)
@margin_top = screen_y(3)
@margin_bottom = screen_y(3)

@table_frame_color = "#55003dff0eff"
@table_fill_color = "#fcfae2"

@table_padding_left = screen_x(5) * 0
@table_padding_right = screen_x(5) * 0
@table_padding_top = screen_y(2) * 0
@table_padding_bottom = screen_y(2) * 0

@table_head_frame_color = "#55003dff0eff"
@table_body_frame_color = "#55003dff0eff"
@table_head_fill_color = "#eeedcd"
@table_body_fill_color = nil

@table_cell_padding_left = screen_x(2)
@table_cell_padding_right = screen_x(2)
@table_cell_padding_top = screen_y(0.5)
@table_cell_padding_bottom = screen_y(0.5)

@table_header_padding_left = screen_x(2) * 0
@table_header_padding_right = screen_x(2) * 0
@table_header_padding_top = screen_y(0.5)
@table_header_padding_bottom = screen_y(0.5)

@table_caption_space = screen_y(2)
@table_caption_color = "black"


@image_with_frame = nil
@image_caption_space = screen_y(1)
@image_caption_color = "black"
@image_frame_color = "black"
@image_frame_shadow_color = "gray"
@image_frame_padding = screen_size(1)
@image_frame_shadow_width = 4
@image_frame_shadow_offset = 2


@font_family = nil
@monospace_font_family = nil

@font_family = find_font_family("Rabbit")
@monospace_font_family = find_font_family("Rabbit Monospace")

if windows?
  @font_family ||= find_font_family("MS PGothic")
  @monospace_font_family ||= find_font_family("MS Gothic")
elsif quartz?
  @font_family ||= find_font_family("Hiragino Kaku Gothic Pro")
  @monospace_font_family ||= find_font_family("Osaka-Mono")
end

@font_family ||= find_font_family("Sans")
@monospace_font_family ||= find_font_family("Monospace")
