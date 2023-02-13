#!/usr/bin/perl
while (<>){  #input file :NewlySSRDateRename.txt
	if (/SAMPLE/){
		s/^SAMPLE/ID/;
		@title = split;
		foreach my $e (@title){
			if ($e eq "ID"){
			push @chtitle, $e;
			}else{
				push @chtitle, ${e}.a;
				push @chtitle, ${e}.b;
			}
			#push @chtitle,"\n";
			#print "@chtitle\n";
		}
		$header = join "\t",@chtitle;
		print "@chtitle\n";
	}elsif(/\w+\d+-\d.*/){
		s#/#\t#g;
		s#\?#\t#g;
		print;
	}
}