#!/opt/bin/perl5

# read text from stdin, filter all foreing stuff
# break it into words and buil a words hash


# Versions.
#  

# Feb 27, 1999 Added re-coding logic, together with option '-code'
# checking

# Mar 1, 1999 Added coding from table with broken hard g. As on Wien
# page Ukraiins'ka Ideya.

# Apr 19, 1999 
# "¢ " - used instead of apostophe at Tele Sluzhba Novyn in koi8
# http://www.1plus1.net/slots/tch/online
# new code added "-code tsn"


$HASH="udict_hash.tbl";
$TMP="udict";
$iam=$0;


$arg = shift;
undef $CODE;
( $arg =~ /^-/ ) && do {
    if ( $arg eq "-code") {
	$CODE = shift;
    }
};
&do_words; 
exit;

######################################## 
## end of main program



sub do_words () {
#    my $INFILE = pop;
    $new_words="";
    &read_hash ($HASH);
#    print "hash read";
    my $WordsFile = &words_split;
    &UpdateHash ($WordsFile);
#    print "writing hash $HASH";
    &write_hash ($HASH);
    print "New words added: $#new_words \n", join(' ',@new_words), "\n";
    system ("rm $WordsFile");
}
exit;

# read words from file and update hash
sub UpdateHash () {
    my $WordsFile = pop;
    open WORDS, $WordsFile or
	die " Can not open file $WordsFile for reading";
    while ( $word = <WORDS>) {
	chop $word;
	$word =~ s/\'+$//g;  ### some cleanup
	$word =~ s/^\'+//g;
	$word =~ s/-{2,}//g; ## trailing/leading dash, multi dashes	
	$word =~ s/\-+$//g;
	$word =~ s/^\-+//g;
	$word =~ s/_+//g;
	$word =~ s/^-$//g;
	$word =~ s/^\'$//g;
	($word ne "") && do {
	    if ( @Words {$word} eq "" ) {
		@Words {$word} = 1;
		$new_words[$#new_words++]=$word;
	    }
	    else {
		 @Words{$word}++ ;
	    }
	}
    }
    close WORDS;
}

# read text from std in and write split words into file
# return filename
sub words_split () {
    my $words_to_split = "/tmp/words.".$$;
    open WORDS_TO_SPLIT, "> $words_to_split" or
	die "Can not create tmp file  $words_to_split";
    while (<>) {
	### delete all html comments - a lot of russian words!!!
	$_ =~ s/\<\!\-\-.*\-\-\>//g;
	$_ =~ tr /iI/¦¶/; # english to ukr
	$_ =~ tr [\140] [\047];  # backquote to quote 
	                         # some use backquote as apostrofe
	$_ =~ tr [\134] [\047];  # some guys use somthing strange as a quote

	( defined $CODE ) && do 
	{
	    ## broken koi8 ± from Ukraiinska Ideya
	    ## http://www.wu-wien.ac.at/groups/ukraine_hp/idea/
	    ## has wrong hard 'g'

	    ( $CODE =~ /wien-koi8/ ) && do {
		$_ =~ tr [²±] [½­];
	    };

	    # "¢ " - used instead of apostophe at Tele Sluzhba Novyn in koi8
	    ( $CODE =~ /tsn/ ) && do {
	    	$_ =~ s/¢ /\'/g;	
		# they use double quote as apostrophe
		$_ =~ tr [\042] [\047];
	    };
	    
	    ( $CODE =~ /1251/ ) && do {
		$_ =~ tr 
		    [éöóêåíãøùçõ´¿ôèâàïğîëäæºÿ÷ñì³òüáşÉÖÓÊÅÍÃØÙÇÕ¥¯ÔÈÂÀÏĞÎËÄÆªß×ÑÌ²ÒÜÁŞ] 
		    [ÊÃÕËÅÎÇÛİÚÈ­§ÆÉ×ÁĞÒÏÌÄÖ¤ÑŞÓÍ¦ÔØÂÀêãõëåîçûıúè½·æé÷áğòïìäö´ñşóí¶ôøâà];
	    };	    
	};
	$_ =~ s/[\000-\046\050-\054\056-\243\245\250-\254\256-\263\265\270-\274\276\277\331\334\337\371\374\377]/\012/g; # all but koi-u to NL
	$_ =~ tr [êãõëåîçûıúè½·æé÷áğòïìäö´ñşóí¶ôøâà] 
	         [ÊÃÕËÅÎÇÛİÚÈ­§ÆÉ×ÁĞÒÏÌÄÖ¤ÑŞÓÍ¦ÔØÂÀ];  ## all smalls
	print WORDS_TO_SPLIT;
    }
    close WORDS_TO_SPLIT;
    return $words_to_split;
}

#
# read in hash table
sub read_hash () {
    my $HASH = pop;
    my $word, $number;
    die "Can not open file $HASH for reading"
	unless open HASH, $HASH;
    while (<HASH>) {
	($word, $number) = split (' ', $_);
	@Words{$word} = $number;
    }
    close HASH;
}

#
# write out hash table
sub write_hash () {
    my $HASH = pop;
    my $HASH_P = $HASH."prev";
    my $word, $number;
    my $tmphash = "/tmp/hash".$$;
    open TMP, ">$tmphash" or 
	die " Can create temp file";
    for $word (%Words) {
# 	$word =~ s/\'+$//g;  ### some cleanup
# 	$word =~ s/^\'+//g;
# 	$word =~ s/-{2,}//g; ## trailing/leading dash, multi dashes	
# 	$word =~ s/\-+$//g;
# 	$word =~ s/^\-+//g;
# 	$word =~ s/_+//g;
# 	$word =~ s/^-$//g;
# 	$word =~ s/^\'$//g;
	( $Words{$word} ne "" ) && do {
	    printf TMP  "%s\t%s\n", $word, $Words{$word};
	}
    }
    close $tmphash;
    system "mv $HASH $HASH_P";
    system "mv $tmphash $HASH";
}












