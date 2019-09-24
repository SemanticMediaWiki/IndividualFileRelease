#!/bin/sh

# This shell script allows you to create an individual file release in case you have no command
# line access to your webspace.

# Variables - recommended setup - may be updated to your needs before running the script
installdirectory=/var/tmp
softwaredirectory=mediawiki
mediawiki=REL1_31
semanticmediawiki=^3.1
semanticresultformats=^3.1
semanticcompoundqueries=^2.1
semanticextraspecialproperties=^2.0

# Commands
echo
echo "Creating an individual file release"
echo
echo "Cloning and checking out ${mediawiki} MediaWiki:"
echo
cd ${installdirectory}
git clone https://gerrit.wikimedia.org/r/p/mediawiki/core.git ${softwaredirectory} --branch ${mediawiki} --depth 20
cd ${softwaredirectory}
git checkout origin/${mediawiki}
echo "Done."
echo
echo "Creating 'composer.local.json' file:"
cat <<EOF >composer.local.json
{
	"require": {
		"mediawiki/semantic-compound-queries": "${semanticcompoundqueries}",
		"mediawiki/semantic-extra-special-properties": "${semanticextraspecialproperties}",
		"mediawiki/semantic-media-wiki": "${semanticmediawiki}",
		"mediawiki/semantic-result-formats": "${semanticresultformats}"
	},
	"config": {
		"preferred-install": "source",
		"optimize-autoloader": true
	}
}
EOF
echo "Done."
echo
echo "Installing MediaWiki dependencies as well as predefined"
echo "semantic extensions including its required dependencies:"
echo
composer update --no-dev --prefer-source
echo "Done."
echo
echo "Cloning and checking out Vector skin:"
cd skins
git clone https://gerrit.wikimedia.org/r/p/mediawiki/skins/Vector.git
cd Vector
git checkout origin/${mediawiki}
echo "Done."
echo
echo "Removing '.git' directories of MediaWiki and Vector:"
rm -r -f .git/
cd ../..
rm -r -f .git/
echo "Done."
echo
echo "The file release may now be moved to your webspace."
