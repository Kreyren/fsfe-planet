#!/bin/sh
# shellcheck shell=sh # Written to comply with IEEE Std 1003.1-2017

#@ Created by Jacob Hrbek <kreyren@rixotstudio.cz> verified using a GPG identifier assigned to the mentioned e-mail according to the keyserver <hkp://zkaan2xfbuxia2wpf7ofnkbz6r5zdbbvxbunvp5g2iebopbfc4iqmbad.onion> under the GPLv3 license <https://www.gnu.org/licenses/gpl-3.0.en.html> in 21/01/2021-EU 20:50:26 CET

###! This file is designed to provide the enforced functions for the environment from which this script has been executed

set -e

# File hierarchy
	PROJECT_DIR="${PROJECT_DIR:-"$PWD"}"
	ENFORCED_DIR="$PROJECT_DIR/scripts/enforced-wrappers"

# Wrapper sourcing
	# shellcheck source=enforced-wrappers/01-eexecutable.sh
	. "$ENFORCED_DIR/01-eexecutable.sh"

	# shellcheck source=enforced-wrappers/00-die.sh
	. "$ENFORCED_DIR/00-die.sh"

	# shellcheck source=enforced-wrappers/01-echmod.sh
	. "$ENFORCED_DIR/01-echmod.sh"

	# shellcheck source=enforced-wrappers/01-edownload.sh
	. "$ENFORCED_DIR/01-edownload.sh"

	# shellcheck source=enforced-wrappers/01-emkdir.sh
	. "$ENFORCED_DIR/01-emkdir.sh"

	# shellcheck source=enforced-wrappers/01-eprintf.sh
	. "$ENFORCED_DIR/01-eprintf.sh"