use inc::Module::Install;

name 'cppref';
all_from 'cppref';
readme_from 'cppref';

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
