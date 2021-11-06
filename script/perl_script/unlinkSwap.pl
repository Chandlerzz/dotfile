#!/usr/bin/perl

use Walk;

sub filefunc{
    if ($_[0] =~ /\w*.swp/) {
        unlink $_[0];
    }
}
sub dirfunc{
    return;
}
file_dir_walk('.', \&filefunc, \&dirfunc)
