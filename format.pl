use lib "mt-sukeroku2";
use Text::Sukeroku::Agemaki;
use IO::Handle;
STDOUT->autoflush(1);

my $fname =$ARGV[0];
my $fh = open FILE, "< $fname";

my $agemaki = Text::Sukeroku::Agemaki->new();

sub trim {
	my $val = shift;
	$val =~ s/^\s*(.*?)\s*$/$1/;
	return $val;
}

open(IN, "< $fname");
my $flag_sep=0;
my $flag_in = 0;
my $text="";
my $flag_hatena=0;
while ( $line = <IN> ) {
	if( $flag_in ){
		if( trim($line) eq "-----" ) { #end
			my $obj = $agemaki->create('hatena', $text);
			my $dst = $obj->formatText();
			print($dst);
			print("\n");
			print($line);
			$text="";
			$flag_in = 0;
			$flag_hatena=0;
		} else {
			$text .= $line;
		}
	}else{
		if(($flag_sep && $line eq "BODY:\n") && $flag_hatena){
			$flag_in = 1;
		}
		print($line);
	}
	#
	$flag_sep=(trim($line) eq "-----");
	$flag_hatena |= (trim($line) eq "CONVERT BREAKS: sukeroku2_hatena");
}
close(IN)
