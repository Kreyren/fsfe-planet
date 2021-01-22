#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

###! Wrapper function 'Enforced change file mode' used to change file attributes
###! SYNOPSIS: echmod [{+,-}{wrx}] [PATHNAME]
command -v echmod || echmod() { funcname="echmod"
	echmod_mode="$1"
	echmod_pathname="$2"

	if eexecutable ${CHMOD:-"chmod"}; then
		${CHMOD:-"chmod"} "$echmod_mode" "$echmod_pathname" || {
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*)
					die echmod-fail "Wrapper function '${FUNCNAME:-"$funcname"}' was unable to set mode '$echmod_mode' to pathname '$echmod_pathname"
			esac
		}
	else
		case "${SCRIPT_LANG:-"$LANG"}" in
			en-*|*)
				die echmod-fatal-fail "Wrapper function '${FUNCNAME:-"$funcname"}' was unable to find command capable of changing pathname mods"
		esac
	fi

	unset funcname echmod_mode echmod_pathname
}