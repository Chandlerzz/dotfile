package Walk;

use 5.032001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Walk ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
    file_dir_walk	
);

our $VERSION = '0.01';
sub file_dir_walk {
    my ($top, $filefunc, $dirfunc) = @_;
    my $DIR;

    if (-d $top) {
        my $file;
        unless (opendir $DIR, $top) {
            warn "Couldn't open directory $top: $!; skipping.\n";
            return;
        }
        
        my @results;
        while ($file = readdir $DIR) {
            next if $file eq '.' || $file eq '..';
            push @results, file_dir_walk("$top/$file",$filefunc, $dirfunc);
        }
        return $dirfunc->($top, @results);
    } else {
        return $filefunc->($top);
    }
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Walk - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Walk;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Walk, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

chandler xu, E<lt>chandlerxu@localdomainE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2021 by chandler xu

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.32.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
