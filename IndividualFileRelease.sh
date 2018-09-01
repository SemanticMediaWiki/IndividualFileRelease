#!/bin/sh

# This shell script allows you to create an individual file release in case you have no command
# line access to your webspace.

# Variables - to be updated to your needs before running the script
installdirectory=/var/tmp
softwaredirectory=mediawiki
mediawiki=REL1_27
semanticmediawiki=^2.5
semanticresultformats=^2.5
semanticcompoundqueries=^1.1
semanticextraspecialproperties=^1.5

# Commands
echo
echo "Creating individual file release for you."
echo
echo "Cloning in and checking out MediaWiki:"
cd ${installdirectory}
git clone https://gerrit.wikimedia.org/r/p/mediawiki/core.git ${softwaredirectory}
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
echo "Installing MediaWiki dependencies as well as semantic extensions including dependencies:"
composer update --no-dev --prefer-source
echo "Done."
echo
echo "Cloning in and checking out Vector:"
cd skins
git clone https://gerrit.wikimedia.org/r/p/mediawiki/skins/Vector.git
cd Vector
git checkout origin/${mediawiki}
echo "Done."
echo
echo "Removing '.git' directories of MediaWiki and Vector:"
rm -r .git/
cd ../..
rm -r .git/
echo "Done."
echo
echo "The file release may now be moved to your webspace."
