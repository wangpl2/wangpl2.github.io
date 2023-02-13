#!/usr/bin/perl
#This perl script was used to tran the format of data in GeneAlex software into the format of PowerMarker v 3.25.


@coreGeneAlexfmt = glob 'core.*.txt';
#print "@coreGeneAlexfmt";
foreach my $afile (@coreGeneAlexfmt){
	#print "$afile\n";
	$afile =~ m/core.out(?<ratio>\d.\d+).txt/;
		
	my @dataline = ();
	
	open my $corefile_hf,"< $afile"||die"can not open core.out file $!";
	
	LINE:while(my $line = <$corefile_hf>){
		   my @mkline = ();
		   my $hitline = "";
		   
		   chomp $line;
			    if ($line =~ m/-/){			
				    #print $line;
					my @mm = split /\s+/,$line;
					my $nmm = @mm;
					@MkData = @mm[0,2..$nmm];#split /\s+/,$line;
				    $IndName = shift @MkData;
				    #print "$IndName";
				    push @mkline,$IndName;
					
					
				WORD:for ($i = 0; $i < $#MkData - 1; $i += 2){
					     $MkData[$i] =~ s/\b0\b/?/;
						 $MkData[$i+1] =~ s/\b0\b/?/;
					    $Amk = $MkData[$i]."/".$MkData[$i + 1];
					    #print "$Amk";
					     push @mkline,$Amk;
				        #push @mkline,"\n";
			         }
			        $hitline = join "\t",@mkline;
					push @dataline, $hitline;
			        
			    }elsif ($line =~ m/^SAMPLE/){
					my @h = split /\s+/,$line;
					my $hn = @h;
					my @ht = @h[0,2..$hn - 1];
				    $header = join "\t",@ht;
				    #print "$header\n";
			    }
		
			#$n = @mkline;
			#print "@dataline\n";
			#push @dataline, $hitline;
			#$x = @dataline;
	    }
	    close $corefile_hf;
	
	open my $coreout_hf,"> Core$+{ratio}outPm_fmt.txt"||die "Can not output the files:$!";
	print $coreout_hf "$header\n";
	foreach my $kk (@dataline){
		print $coreout_hf "$kk\n";
	}
	close $coreout_hf;
}