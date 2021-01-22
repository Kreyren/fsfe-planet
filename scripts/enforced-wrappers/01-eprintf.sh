#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

###! Wrapper function 'Enforced Print Formatted' used to output formatted message in terminal
###! SYNOPSIS: eprintf (FORMAT_STRING{a-zA-Z0-9%_-:}) [OUTPUT{a-zA-Z0-9}]
command -v eprintf 1>/dev/null || eprintf() { funcname="eprintf"
	eprintf_formatString="$1"
	eprintf_output="$2"

	# Check for available commands that can be used for output in terminal
	if eexecutable ${PRINTF:-"printf"}; then
		# Output using command 'printf'
		${PRINTF:-"printf"} "$eprintf_formatString" "$eprintf_output" || {
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*)
					die eprintf-fail "Command '${PRINTF:-"printf"}' failed to execute formatting string '$eprintf_formatString' with output '$eprintf_output'"
			esac
		}
	elif eexecutable ${ECHO:-"echo"}; then
		# Inform the user about unavailable 'printf'
		# FIXME(Krey): Implement translation layer from printf to echo
		case "${SCRIPT_LANG:-"$LANG"}" in
			en-*|*)
				ewarn "Wrapper function '${FUNCNAME:-"$funcname"}' was unable to find command 'printf' from this environment, falling back to alternative. This may break up the formatting!"
		esac

		# Output using command 'echo'
		${ECHO:-"echo"} "$eprintf_formatString" "$eprintf_output" || {
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*)
					die eprintf-fail "Command '${ECHO:-"echo"}' failed to execute formatting string '$eprintf_formatString' with output '$eprintf_output'"
			esac
		}
	else
		# Unexpected trap to conform mission critital environment
		case "${SCRIPT_LANG:-"$LANG"}" in
			en-*|*)
				die unexpected-eprint-fail "Wrapper function '${FUNCNAME:-"$funcname"}' "
		esac
	fi

	# Unset everything
	unset funcname eprintf_formatString eprintf_output
}