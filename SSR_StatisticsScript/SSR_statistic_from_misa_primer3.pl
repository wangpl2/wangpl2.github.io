#!/usr/bin/perl
#InputFile:misa_primer3.out
#OutputFile:SSR_statics.txt # SSR number of each chromosome and motif number of chromsome
#run command: perl SSR_statistic_from_misa_primer3.pl < misa_primer2.out > SSR_statics.txt
while(<>){
	chomp;
	if(/ID/){
		next;
	}else{
		@componentsPerLine = split;
		$key = $componentsPerLine[0].":".$componentsPerLine[2];
		$chromosomeMotifNum{$key}++;
		$SSRNumOnPerChromosome{$componentsPerLine[0]}++;
	}
}

foreach my $key (sort keys %SSRNumOnPerChromosome){
	print "$key => $SSRNumOnPerChromosome{$key}\n";
}
print "===========================\n";
foreach my $key (sort keys %chromosomeMotifNum){
	print "$key => $chromosomeMotifNum{$key}\n";
	#print "-------------\n";
}