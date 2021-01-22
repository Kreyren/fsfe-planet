#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

###! Wrapper function 'Enforced Make Directory' used to create a directory in DESTINATION
###! SYNOPSIS: emkdir [DESTINATION]
command -v emkdir || emkdir() {
	emkdir_dest="$1"

	if eexecutable ${MKDIR:-"mkdir"}; then
		# Create the new directory using `mkdir` command
		${MKDIR:-"mkdir"} "$emkdir_dest" || {
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*)
					die emkdir-fail "Wrapper function '${FUNCNAME:-"$funcname"}' was unable to create a new directory in '$emkdir_dest'"
			esac
		}
	else
		case "${SCRIPT_LANG:-"$LANG"}" in
			en-*|*)
				die emkdir-unexpected "Wrapper function '${FUNCNAME:-"$funcname"}' was unable to find command capable of creating a new directory in this environment"
		esac
	fi
}