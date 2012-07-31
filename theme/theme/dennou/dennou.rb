#--------------------------------------
# Configuration
#--------------------------------------
## font size setup
# けっこう適当. 
# Science なプレゼン用に default よりかなり小さめ.
@xxx_large_font_size = screen_size(8 * Pango::SCALE)
@xx_large_font_size = screen_size(4.5 * Pango::SCALE)
@x_large_font_size = screen_size(4 * Pango::SCALE)
@large_font_size = screen_size(3.8 * Pango::SCALE)
@normal_font_size = screen_size(3 * Pango::SCALE)
@small_font_size = screen_size(2.8 * Pango::SCALE)
@x_small_font_size = screen_size(2.5 * Pango::SCALE)
@xx_small_font_size = screen_size(1.5 * Pango::SCALE)
# script font size
@script_font_size = @xx_small_font_size
@large_script_font_size = @x_small_font_size
@x_large_script_font_size = @small_font_size

## font family setup
# fc-list で出てくる名前を指定する.
##
@default_font = "Sans"
@bold_font = "Sans"
@monospace_font = "Ricty"

@font_family = find_font_family(@default_font)
@monospace_font_family = find_font_family(@monospace_font)
@bold_font_family = find_font_family(@bold_font)
## background color
@default_foreground = "#000"
@default_background = "#FFF"
# スライド番号
@not_use_slide_number = false
@slide_number_props = {
  "size" => @x_small_font_size,
  "font_family" => @bold_font
}
@slide_number_color = "#000"
# 箇条書きの色・マーク...とりあえず保留.
# @default_item1_mark_color = "#050077"
# @default_item2_mark_color = "#000"
# @default_item3_mark_color = "#034f00"
# @default_enum_item1_mark_color = "#000"
# @default_enum_item2_mark_color = "#034f00"
# @default_item1_mark_type = "rectangle"
# @default_item2_mark_type = "circle"
# @default_item3_mark_type = "circle"
# @default_enum_item1_mark_type = "circle"
# @default_enum_item2_mark_type = "circle"

# 整形済み
@preformatted_frame_color = "#50f"
@preformatted_frame_width = 0.5
@preformatted_fill_color  = "#fff"
@preformatted_shadow_color = nil
@centring_preformatted_block = false

#--------------------------------------
# Main setting
#--------------------------------------
# fg & bg color
set_foreground(@default_foreground)
set_background(@default_background)
include_theme("table")
include_theme("dennou-image")
include_theme("dennou-title-text")
include_theme("dennou-text")
include_theme("dennou-title-slide")
@title_shadow_color = "#c09090cc"
include_theme("title-shadow")
include_theme("dennou-slide")
include_theme("dennou-foot-text")
# @image_slide_number_show_text = true
#include_theme("dennou-image-slide-number")
include_theme("default-item-mark")
include_theme("default-description")
include_theme("dennou-preformatted")
include_theme("dennou-block-quote")

# # 高橋メソッド
@lightning_talk_proc_name = "lightning-dennou"
@lightning_talk_as_large_as_possible = true
include_theme("lightning-talk-toolkit")

match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk?
      slide.lightning_talk
    end
  end
end
