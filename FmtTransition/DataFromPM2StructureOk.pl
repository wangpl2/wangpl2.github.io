#!/usr/bin/perl
LINE:while(<>){
	@line1 = ();
	@line2 = ();
	@mkdt = ();
		chomp;
		next if /SAMPLE/;
		@mkdt = split;
		WORD:foreach (@mkdt){
			if (/(\w+\d{1,3}-\d+)/){
				push @line1, $1;
				push @line2, $1;
			}elsif (/\S+\/\S+/){
				@mkd = split /\//,$_;
				push @line1,$mkd[0];
				push @line2,$mkd[1];
			}
		}
		$lineup = join "	",@line1;
		$lineup =~ s#\?#-9#g;
		$linedown = join "	",@line2;
		$linedown =~ s#\?#-9#g;
		print "$lineup\n$linedown\n";
	}