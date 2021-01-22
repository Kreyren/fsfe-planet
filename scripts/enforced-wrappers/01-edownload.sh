#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

# DNM(Krey): Implement eexecutable

###! Wrapper function 'Enforced Download' designed to download content of URL to DESTINATION
###! SYNOPSIS: edownload [URL] [DESTINATION]
edownload() { funcname="edownload"
	inputURL="$1"
	inputDest="$2"

	# Process inputURL
	case "$inputURL" in
		"https://"*|"http://"*)
			if eexecutable "curl"; then
				curl -so "$inputDest" "$inputURL" || die curl-fail ""
			fi
		;;
		*)
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*)
					die syntax-err "Argument '$inputURL' is not recognized by the function ${FUNCNAME:-"$funcname"}"
			esac
	esac

	unset funcname
}