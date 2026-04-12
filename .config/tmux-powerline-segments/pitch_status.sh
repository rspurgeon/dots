# shellcheck shell=bash

run_segment() {
	if ! command -v pitch >/dev/null 2>&1; then
		return 0
	fi

	local pitch_root

	pitch_root="${PITCH_ROOT:-/home/rspurgeon/dev/rspurgeon/pitch}"

	PITCH_STATUS_RIGHT_FORMAT="tmux" \
	PITCH_STATUS_RIGHT_RUNNING_COLOR="#7DAF7D" \
	PITCH_STATUS_RIGHT_IDLE_COLOR="#61AFEF" \
	PITCH_STATUS_RIGHT_QUESTION_COLOR="#E5C07B" \
	PITCH_STATUS_RIGHT_ERROR_COLOR="#E06C75" \
	PITCH_STATUS_RIGHT_GROUP_DIVIDER_COLOR="#B7BDB5" \
	PITCH_ROOT="$pitch_root" pitch status-right \
		2>/dev/null
}
