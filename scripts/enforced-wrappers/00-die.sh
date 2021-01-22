#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

###! Function to cleanly terminate and nicely murders the running process and output MESSAGE about it with specified ERROR_CODE
###! SYNOPSIS: die [ERROR_CODE] (message)
###! Error codes:
###! - true = Generic True
###! - false = Generic False
###! - syntax-err = Generic Syntax error
###! - insuffic-perm = Generic Permission error
###! - security = Trap for security related concerns
###! - fixme = Trap for unimplemented features
###! - unexpected = Generic unexpected trap
command -v die 1>/dev/null || die() { funcname="die"
	errCode="$1"
	message="$2"

	# Formatting strings
	DIE_FORMAT_STRING_TRUE="${DIE_FORMAT_STRING_TRUE:-"SUCCESS: %s\\n"}"
	DIE_FORMAT_STRING_FALSE="${DIE_FORMAT_STRING_FALSE:-"FATAL: %s\\n"}"
	DIE_FORMAT_STRING_SYNTAX_ERR="${DIE_FORMAT_STRING_SYNTAX_ERR:-"FATAL: %s\\n"}"
	DIE_FORMAT_STRING_INSUFFIC_PERM="${DIE_FORMAT_STRING_INSUFFIC_PERM:-"FATAL: %s\\n"}"
	DIE_FORMAT_STRING_FIXME="${DIE_FORMAT_STRING_INSUFFIC_FIXME:-"FIXME: %s\\n"}"
	DIE_FORMAT_STRING_SECURITY="${DIE_FORMAT_STRING_SECURITY:-"SECURITY: %s\\n"}"
	DIE_FORMAT_STRING_FIXME="${DIE_FORMAT_STRING_FIXME:-"FIXME: %s\\n"}"
	DIE_FORMAT_STRING_UNEXPECTED="${DIE_FORMAT_STRING_UNEXPECTED:-"UNEXPECTED: %s\\n"}"
	DIE_FORMAT_STRING_UNIMPLEMENTED="${DIE_FORMAT_STRING_UNIMPLEMENTED:-"FATAL: %s\\n"}"

	case "$errCode" in
		"true")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_TRUE" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 0
		;;
		"false")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_FALSE" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 1
		;;
		"syntax-err")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_SYNTAX_ERR" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 2
		;;
		"insuffic-perm")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_INSUFFIC_PERM" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 3
		;;
		"security")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_SECURITY" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 28
		;;
		"fixme")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_FIXME" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 36
		;;

		"unexpected")
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_UNEXPECTED" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 36
		;;
		*)
			case "${SCRIPT_LANG:-"$LANG"}" in
				en-*|*) eprintf "$DIE_FORMAT_STRING_UNIMPLEMENTED" "${message:-"Unimplemented argument '$errCode' has been parsed to the function '${FUNCNAME:-"$funcname"}' without a message"}"
			esac

			${EXIT:-"exit"} 128
	esac

	unset funcname
}