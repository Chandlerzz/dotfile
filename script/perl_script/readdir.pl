use warnings;
use strict;
use URI;
our @arrOfAbsoluteUrl = ();
sub bookUrls{
	my@dir=();
	my($dir)=@_;
	my $newDir = $dir;
	opendir (DIR, $dir) or die "can't open the directory!";
	@dir = readdir DIR;
	foreach my $file (@dir) {
	my $isDir = 0;
	$isDir = -d "$dir/$file";
	if ($isDir == 1){
		if($file eq "."||$file eq ".."){
#		print "$file","\n";

}
		else{
	 	$newDir = "$dir/$file";
#		print $file,"\n";
		bookUrls($newDir);
}
}
	else{
		if ($file =~ /.*pdf$/) {
		push @arrOfAbsoluteUrl,"$dir/$file";
#		print $file,"\n";
}
}
}
	return @arrOfAbsoluteUrl;
}
my $dir = "/mnt/c/Users/xuzz/Desktop/ebook";

@arrOfAbsoluteUrl = bookUrls($dir);
#print @arrOfAbsoluteUrl;
foreach my $url (@arrOfAbsoluteUrl){
	my $uri = URI ->new($url);
	my $path = $uri->path;
	(my $str = $path) =~ s/\/mnt\/c\/Users\/xuzz\/Desktop\/ebook/root\@xuxiyao.com:\/usr\/share\/nginx\/html\/book/g;
	system "scp $path $str";
	sleep(10);
	print $path,"\n";
	print $str ,"\n";	
} 
