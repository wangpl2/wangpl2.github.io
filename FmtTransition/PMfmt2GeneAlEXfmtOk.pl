#!/usr/bin/perl
$MarkerNub = 0;
$SampleNub = 0;
open my $input_hf, "< NewlySSRDateRename.txt" || die "Can not open the file: NewlySSRDateRename.txt!";
while(my $in = <$input_hf>){
	++$SampleNub;
	chomp $in;
	if ($in =~ /SAMPLE/){
		@title = split /\s+/,$in;
		shift @title;
		foreach my $e (@title){
			push @line2,$e;
			++$MarkerNub;
		}
		#$MarkerNub = $n;
	unshift @line2,"CODE";
	foreach my $o (@line2){
		if ($o =~ m/CODE/){
			#print "$o\t";
			push @line2good,"$o\t\t";
		}else{
		#print "$o\t\t";
		push @line2good,"$o\t\t";
		}
	}
	#print "\n";
	}else{
		$in =~ s#\Q/\E#	#g;
		$in =~ s#\Q?\E#0#g;
		$in =~ s#^(\w+\d+-\d{1,2})#$1	Pop1 #g;
		#print "$in\n";
		#print "$in\n";
		push @content,"$in\t";
		}
}
$SampleNub = $SampleNub -1;
print "$MarkerNub\t$SampleNub\t1\t$SampleNub\n\n";
print "@line2good\n";

foreach my $outline (@content){
	print "$outline\n";
}
