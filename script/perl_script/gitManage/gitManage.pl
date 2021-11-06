#!/usr/bin/perl -w
use strict;
use warnings;
use Cwd;

my $dispatch_table = 
{   ADD     => \&git_add,
    PUSH    => \&git_push,
    STATUS  => \&git_status,
    PULL    => \&git_pull,
    COMMIT  => \&git_commit,
};

sub read_config {
    my ($filename, $actions) = @_;
    git_command();
    $filename = "$ENV{HOME}/script/perl_script/gitManage/$filename";
    open (SF, "<", $filename) or return; #Failure
    while (my $line = <SF>) {
        chomp($line);
        my($directive, $rest) = split /\s+/, $line, 2;
        if (exists $actions -> {$directive}) {
            $actions->{$directive}->($rest);
        } else {
            die "Unrecognized directive $directive on line $. of $filename; aborting";
        }
    }
    return 1;#Success
}


sub git_status {
    my ($dir) = @_;
    my $command = "git status";
    git_command($dir,$command);
}
sub git_add {
    my ($dir) = @_;
    my $command = "git add -A";
    git_command($dir,$command);
}
sub git_push {
    my ($dir) = @_;
    my $command = "git push origin main"; 
    git_command($dir,$command);
}
sub git_pull {
    my ($dir) = @_;
    my $command = "git pull origin main"; 
    git_command($dir,$command);
}
sub git_commit {
    my ($dir) = @_;
    my $command = 'git commit -m "autocommit"'; 
    git_command($dir,$command);
}
sub git_command{
    my ($dir,$command) = @_;
    $dir = "$ENV{HOME}/script/perl_script/gitManage/$dir";
    open SF, $dir or return;
    while (my$line = <SF>) {
        chomp($line);
        my $path = "$ENV{HOME}/$line";
        print($path);
        chdir($path);
        system "$command";
    }
}
#program start
my ($filename) = $ARGV[0];
read_config($filename, $dispatch_table);
