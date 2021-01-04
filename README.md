# IndividualFileRelease

The shell script allows you to create an individual file release in case you
have no command line access to your webspace. It replaces the file releases
that were previously done for Semantic MediaWiki 2.4.x to 2.5.x.

By default, the individual file release will bundle the following files and extensions:
- MediaWiki core
- Vector skin
- Semantic extensions:
  - Semantic MediaWiki
  - Semantic Result Formats
  - Semantic Extra Special Properties
  - Semantic Compound Queries

## Usage

1. Copy the following file to you local computer: ["IndividualFileRelease.sh"](https://raw.githubusercontent.com/SemanticMediaWiki/IndividualFileRelease/master/IndividualFileRelease.sh)
1. Change permissions of the file with `chmod 700 IndividualFileRelease.sh`
1. Run the script with `./IndividualFileRelease.sh`
1. Move the resulting files to your webspace (Note: Adapt your wiki's "LocalSettings.php" file)
1. Follow the [installation of Semantic MediaWiki (without shell access)](https://www.semantic-mediawiki.org/wiki/Help:Installation_without_shell_access) for the rest of the setup and enjoy!

#### Windows users

Windows users may want to change the `installdirectory` line in "IndividualFileRelease.sh" to something like `installdirectory=/d/temp` (equivalent to D:\Temp).

## Note

When creating a file release make sure that the versions in the respective platform environments match. The most important version matching is PHP. This helps avoid issues arising from version mismatches, and addresses dependencies of MediaWiki or Semantic MediaWiki being pulled which are not compatible on diverget setups.
