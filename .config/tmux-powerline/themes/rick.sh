# Default Theme

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

MY_BG_COLOR="#101110"
MY_FG_COLOR="#B7BDB5"
KONG_ACTIVE_BG="#6B9E8A"
KONG_ACTIVE_FG="#000F06"
KONG_SEPARATOR_FG="#7DAF7D"

TMUX_POWERLINE_SEG_PWD_MAX_LEN="20"

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$MY_BG_COLOR}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$MY_FG_COLOR}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# See man tmux.conf for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveinences

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_CURRENT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[fg=$KONG_ACTIVE_FG,bg=$KONG_ACTIVE_BG,bold,noitalics,nounderscore]" \
        " #I) #W " \
		"#[fg=$KONG_ACTIVE_BG,bg=$MY_BG_COLOR,nobold,noitalics,nounderscore]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_STYLE ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_FORMAT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[fg=$MY_FG_COLOR,bg=$MY_BG_COLOR,nobold,noitalics,nounderscore]" \
        "  #I) #W "
	)
fi
#
## Format: segment_name background_color foreground_color [non_default_separator] [separator_background_color] [separator_foreground_color] [spacing_disable] [separator_disable]
##
## non_default_separator - specify an alternative character for this segment's separator
## separator_background_color - specify a unique background color for the separator
## separator_foreground_color - specify a unique foreground color for the separator
## spacing_disable - remove space on left, right or both sides of the segment:
##
##   "left_disable" - disable space on the left
##   "right_disable" - disable space on the right
##   "both_disable" - disable spaces on both sides
##   * - any other character/string produces no change to default behavior (eg "none", "X", etc.)
##
## separator_disable - disables drawing a separator on this segment, very useful for segments
## with dynamic background colours (eg tmux_mem_cpu_load)
##
##   "separator_disable" - disables the separator
##   * - any other character/string produces no change to default behavior
##
## Example segment with separator disabled and right space character disabled:
## "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} 33 0 right_disable separator_disable"
##
## Note that although redundant the non_default_separator, separator_background_color and
## separator_foreground_color options must still be specified so that appropriate index
## of options to support the spacing_disable and separator_disable features can be used
#
#if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
#	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
#		#"tmux_session_info $MY_BG_COLOR $MY_FG_COLOR" \
#		#"time 12 0 " \
#		#"pwd 12 0" \
#		#"vcs_branch 12 0" \
#		#"hostname 33 0" \
#		#"ifstat 30 255" \
#		#"vcs_branch 29 88" \
#		#"ifstat_sys 30 255" \
#		#"lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
#		#"wan_ip 24 255" \
#		#"vcs_compare 60 255" \
#		#"vcs_staged 64 255" \
#		#"vcs_modified 9 255" \
#		#"vcs_others 245 0" \
#	)
#fi
#
if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
        "pitch_status $MY_BG_COLOR $MY_FG_COLOR" \
        #"hostname $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color $KONG_SEPARATOR_FG"
        #"vcs_branch $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color $KONG_SEPARATOR_FG" \
		"pwd $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color $KONG_SEPARATOR_FG" \
	    #"date_day $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color $KONG_SEPARATOR_FG" \
		"date $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color $KONG_SEPARATOR_FG" \
		"time $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color $KONG_SEPARATOR_FG both_disable separator_disable" \
        #"battery $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
        #"weather $MY_BG_COLOR $MY_FG_COLOR ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		#"earthquake 3 0" \
		#"macos_notification_count 29 255" \
		#"mailcount 9 255" \
		#"now_playing 234 37" \
		#"cpu 240 136" \
		#"load 237 167" \
		#"tmux_mem_cpu_load 234 136" \
		#"battery $MY_BG_COLOR $MY_FG_COLOR" \
		#"weather 37 255" \
		#"rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}" \
		#"xkb_layout 125 117" \
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
	)
fi
