use inc::Module::Install;

name 'cppref';

abstract_from 'cppref';
author_from 'cppref';
license_from 'cppref';
perl_version_from 'cppref';
version_from 'cppref';

readme_from 'cppref';
distribution_type 'script';

no_index 'orig';

requires_external_bin 'w3m';
configure_requires 'Module::Install::ReadmeFromPod';
configure_requires 'File::Slurp';
requires 'File::ShareDir';

install_script 'cppref';
mkdir 'doc';
install_share 'doc';

auto_include;
auto_install;

WriteAll;

do 'tidy.pl';
