```yaml
style/preset_color_schemes/+:
  # color_scheme下颜色支持透明度设定，格式0xaabbggrr
  # *标记的是新增参数
  color_schema_name_in_yaml:			配色节点
    author: "author info"
    name: "color scheme name"           # weasel输入法设定窗口中可以显示名字

    back_color: 0xeceeee                #候选窗背景底色        
    border_color: 0xe0e0e0              #候选窗边框颜色
    shadow_color: 0x00000000            #*候选窗投影颜色,默认透明
    text_color: 0x000000                #键入码字颜色

    candidate_back_color: 0xeceeee      #*非高亮候选背景色，默认透明
    candidate_shadow_color: 0x00000000  #*非高亮候选阴影色，默认透明
    candidate_text_color: 0x000000      #非高亮候选文字颜色
    label_color: 0x000000               #非高亮候选序号颜色
    comment_text_color: 0x000000        #非高亮候选注释颜色

    hilited_back_color: 0xd4d4d4        #高亮（选中）键入码背景颜色
    hilited_shadow_color: 0x00000000    #*高亮（选中）键入码阴影颜色，默认透明
    hilited_text_color: 0x000000        #高亮（选中）键入码文字颜色

    hilited_candidate_back_color: 0xfa3a0a      #高亮（选中）候选背景颜色
    hilited_candidate_shadow_color: 0x20000000  #*高亮（选中）候选阴影颜色，默认透明
    hilited_candidate_text_color: 0xffffff      #高亮（选中）候选文字颜色
    hilited_label_color: 0xffffff               #高亮（选中）候选序号文字颜色
    hilited_comment_text_color: 0xeeeeee        #高亮（选中）候选注释文字颜色
    hilite_mark_color: 0x00000000				#*高亮标记颜色，默认透明。在alpha 非0的情况下：当style/mark_text为空则显示仿Windows11 高亮选中效果，如果style/mark_text为非空字符则为字符颜色

#####################################################################################################
  # 字体设置
  # color_font 为true时支持自定义字体回退顺序，支持字重设置，支持回退范围设定
  # 支持字重设置（不限大小写，具体字体为准）:THIN, EXTRA_LIGHT, ULTRA_LIGHT, LIGHT, SEMI_LIGHT, NORMAL, REGULAR, MEDIUM, DEMI_BOLD, SEMI_BOLD, BOLD, EXTRA_BOLD, ULTRA_BOLD, BLACK, HEAVY, EXTRA_BLACK, ULTRA_BLACK
  # color_font: true 时支持斜体字设定，italic, oblique
  # 主字体,回退字体1,回退字体2,回退字体3    ......
  # 主字体格式     fontName:fontWeight:fontStyle      #fontWeight可以是上面的各种字重，fontStyle 可以italic/oblique
  # 回退字体格式可以是以下的三种状态：
  #
  #  fontName                                     # fallback 字体fontName, fallback 范围 0到10FFFF
  #  fontName:first_code_point                    # fallback 字体fontName, fallback 范围 first_code_point到10FFFF
  #  fontName:first_code_point:last_code_point    # fallback 字体fontName, fallback 范围 first_code_point到last_code_point

style:
  capture_type: none			#*提交前截图类型，none, highlighted, candidates
  color_font: true              #*在Windows 8.1以上系统上使用directwrite彩色字体，支持彩色Emoji。如系统版本低于8.1则自动false
  color_scheme: lost_temple     #主题色
  color_scheme_dark: lost_temple	#*windows 10后系统，深色主题
  comment_font_face: "Segoe UI, Segoe UI Emoji:1f000:1f09f, Noto Color Emoji SVG:80, Microsoft Yahei, 全宋体-1, 全宋体-2, 全宋体-3, 全宋体-F, 全宋体-X, 全宋体(调和), 全宋体(等宽)"     #*注释字体
  comment_font_point: 12            #*注释字号，小于等于候选字号
  display_tray_icon: false          #显示托盘图标
  font_face: "Segoe UI, Segoe UI Emoji:1f000:1f09f, Noto Color Emoji SVG:80, Microsoft Yahei, 全宋体-1, 全宋体-2, 全宋体-3, 全宋体-F, 全宋体-X, 全宋体(调和), 全宋体(等宽)"     #候选字体
  font_point: 20                    #候选字号
  fullscreen: false                 #全屏
  horizontal: true                  #水平布局，false时竖直布局
  inline_preedit: false             #嵌入式面编码输入
  label_font_face: "Segoe UI, Segoe UI Emoji:1f000:1f09f, Noto Color Emoji SVG:80, Microsoft Yahei, 全宋体-1, 全宋体-2, 全宋体-3, 全宋体-F, 全宋体-X, 全宋体(调和), 全宋体(等宽)"       #*序号字体
  label_font_point: 20                      #*序号字号，小于等于候选字号
  label_format: "%s."               #编号规则
  mark_text: ""						#高亮标记符号
  layout:
    align_type: bottom              #*文字偏置，主要影响label和comment居上/居中/居下布置，尤其是label和comment字体比候选字小的时候，bottom/center/top, 
    border_width: 3             #边框宽度 , 同border
    candidate_spacing: 10       #相邻候选间距
    corner_radius: 15           #候选框窗口圆角
    hilite_padding: 10          #背景与文字偏离值，当设置为0时背景矩形和文字同大小
    hilite_spacing: 10          #候选内label、text、comment之间的相互间距
    margin_x: 15                #其绝对值为 候选窗口border离候选文字边沿x距离
    margin_y: 15                #其绝对值为 候选窗口border离候选文字边沿y距离，# 如margin_x或margin_y任一为负数，则隐藏候选窗口，不隐藏方案选单、中英切换、半角全角切换、简繁切换、错误提示
    min_height: 0               #最小候选窗口高度
    min_width: 50               #最小候选窗口宽度
    round_corner: 0             #候选、编码背景色块圆角
    shadow_offset_x: 3          #*阴影x偏置，正向右负向左
    shadow_offset_y: 3          #*阴影y偏置，正向下负向上;如果shadow_offset_x或shadow_offset_y任意一个不为零，投影阴影，否则圆周阴影
    shadow_radius: 3            #*阴影模糊半径，如为0则全局关闭阴影， 当shadow_offset_x 和shadow_offset_y 都为0时圆周阴影，影响阴影大小
    spacing: 20                 #输入码与候选之间的间距
  preedit_type: composition     #preedit类型，composition, preview, preview_all, preview_all为新增选项，配合隐藏窗口使用效果尤佳

```
