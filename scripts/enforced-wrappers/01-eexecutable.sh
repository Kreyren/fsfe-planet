#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

###! Wrapper function 'Enforced executable' used to output true boolean if COMMAND is executable else it outputs false. Intended to be used as a part of conditionals
###! SYNOPSIS: eexecutable [COMMAND]
eexecutable() {
	eexecutable_command="$1"

	if command -v "$eexecutable_command" 1>/dev/null; then
		return 0
	elif ! command -v "$eexecutable_command" 1>/dev/null; then
		return 1
	else
		case "${SCRIPT_LANG:-"$LANG"}" in
			en-*|*)
				die unexpected_eexecutable "Wrapper function '${FUNCNAME:-"$funcname"}' was captured in unexpected trap while checking whether command '$eexecutable_command' is executable"
		esac
	fi
}