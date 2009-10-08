use inc::Module::Install;

name 'cppref';
all_from 'cppref';
readme_from 'cppref';

no_index 'orig';

configure_requires 'Module::Install::ReadmeFromPod';
configure_requires 'File::Slurp';
requires 'File::ShareDir';

install_script 'cppref';
install_share 'doc';

auto_include;
auto_install;

WriteAll;

do 'tidy.pl';
