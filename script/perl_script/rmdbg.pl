#!/usr/bin/perl

use Walk;
use Data::Dumper; 
use JSON;
$Data::Dumper::Terse = 1; 
$Data::Dumper::Useqq = 1; 

status2json();
softlink();
sub status2json{
    my @untracked =();
    my @modified = () ;
    my $filename = "/tmp/rmdbg/status.txt";
    my %statusMap =();
    open (SF, "<", $filename) or  die "111";#return; #Failure
    while (my $line = <SF>) {
        # 将路径存到path
        if ($line =~ /^\//){
            chomp($line);
            my $path = $line;
            $statusMap{'path'} = $line;
        }
        if ($line =~ /^\t/){
            chomp($line);
            $line =~ s/^\t//;
            my($key, $value) = split /:\s+/, $line, 2;
            if($value eq ""){
                $value = $key;
                $key = "untracked";
            }else{
            }
            if ($key eq "modified"){
                push(@modified,$value);    

            }elsif ($key eq "untracked"){
                push(@untracked,$value);    
            }else {
                
            }
        }
    }
    my $untrackedref = \@untracked;
    my $modifiedref = \@modified;
    $statusMap{'untracked'} = $untrackedref;
    $statusMap{'modified'} = $modifiedref;
    my $json = encode_json \%statusMap;
    open my $fh, ">", "/tmp/rmdbg/config.json";
        print $fh $json;
    close $fh;
}

sub softlink{
    my $tmppath = "/tmp/rmdbg/softlink/";
    my $cmd = "mkdir -p ".$tmppath;
    my $filename = "/tmp/rmdbg/config.json";
    my $json_text = do {
        open(my $json_fh, "<:encoding(UTF-8)", $filename)or die("Can't open \$filename\": $!\n");
            local $/;
            <$json_fh>
        };
    my $json = JSON->new;
    my $data = $json->decode($json_text);
    my $path = ${$data}{'path'};
    my $untracked = ${$data}{'untracked'};
    my $modified = ${$data}{'modified'};
    slink($untracked,$path);
    slink($modified,$path);
    
}
sub slink {
    my ($arrayref,$path) = @_;
    my $tmppath = "/tmp/rmdbg/softlink/";
    my $len = @$arrayref;
    for ($i = 0 ; $i  < $len ;  $i++) {
        my $relativePath = $arrayref->[$i];    
        my $absolutepath = $path."/".$relativePath;
        if (-d $absolutepath){
            file_dir_walk($absolutepath, \&filefunc, \&dirfunc)
        }
        else{
            filefunc($absolutepath);
        }
    }
}

sub filefunc{
    my $absolutepath = $_[0];
    my $tmppath = "/tmp/rmdbg/softlink/";
    my $name = extractName($absolutepath);
    my $tmpabsolutepath = $tmppath.$name;
    my $cmd = "ln -s ".$absolutepath." ".$tmpabsolutepath;
    system($cmd);
    my $cmd ="sed -n '/debugger\$/p' ".$tmpabsolutepath;
    my $output = `$cmd`;
    print $output;
    my $cmd ="sed -i  --follow-symlinks '/debugger\$/d' ".$tmpabsolutepath;
    system($cmd);
    my $cmd = "rm ".$tmpabsolutepath;
    system($cmd);
}
sub dirfunc{
    return;
}
sub extractName{
    my ($absolutepath) = @_;
    my $cmd="echo ".$absolutepath ."| awk -F '/' '{print \$NF}'";
    my $name = `$cmd`;
    return $name;
}
