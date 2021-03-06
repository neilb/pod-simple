# This -*- perl -*- script writes the Makefile for Pod::Simple
#
# Time-stamp: "2004-05-24 00:21:20 ADT"
#
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
#

require 5;

use strict;
use ExtUtils::MakeMaker;

my $mm_ver = $ExtUtils::MakeMaker::VERSION;
if ($mm_ver =~ /_/) {
    $mm_ver = eval $mm_ver;
    die $@ if $@;
}

WriteMakefile(
  NAME		=> 'Pod::Simple',
  VERSION_FROM	=> 'lib/Pod/Simple.pm',
  ABSTRACT_FROM	=> 'lib/Pod/Simple.pod',
  PREREQ_PM	  	=> {
   'Text::Wrap' => '98.112902',
   'Pod::Escapes' => '1.04',

   # RT#29439
   'Test'         => '1.25',

   # And finally, things I don't have any particular version in mind for:
   map {; $_ => 0 } qw[
    File::Spec File::Basename Cwd Config Carp overload Symbol strict
    integer File::Find Test::More
   ]
  },

  ($mm_ver >= 6.48
     ? (MIN_PERL_VERSION => 5.006)
     : ()
  ),

  INSTALLDIRS => $] >= 5.009003 && $] <= 5.011000 ? 'perl' : 'site',

  LICENSE => 'perl',
  AUTHOR  => 'Allison Randal <allison@perl.org>', 
  META_MERGE => {
    "meta-spec" => { version => 2 },
    resources => {
      homepage   => 'http://search.cpan.org/dist/Pod-Simple/',
      license    => 'http://dev.perl.org/licenses/',
      repository => {
        url  => 'git://github.com/perl-pod/pod-simple.git',
        web  => 'https://github.com/perl-pod/pod-simple',
        type => 'git',
      },
      bugtracker => {
        web    => 'https://github.com/perl-pod/pod-simple/issues',
        mailto => 'bug-pod-simple@rt.cpan.org',
      },
    },
  },

);

package MY;

sub libscan
{ # Determine things that should *not* be installed
    my($self, $path) = @_;
    return '' if $path =~ m/~/;
    $path;
}

__END__
