#!/usr/bin/perl
use warnings;
use Cwd;
use Ignore;
my $dir=getcwd;
my $rule = '.man';
my $name=".man";
my $rule1='\*.swp';
my $name1="*.swp";
ignore($dir, $rule, $name);
ignore($dir, $rule1, $name1);

