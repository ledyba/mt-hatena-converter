package Text::Sukeroku::Agemaki;
##----------------------------------------------------------------------
## ?ե????ޥåȥե????ȥ? Agemaki
##----------------------------------------------------------------------
use Text::Sukeroku::BaseFormat;
use Text::Sukeroku::YukiWiki;
use Text::Sukeroku::PukiWiki;
use Text::Sukeroku::HatenaDiary;

use strict;
use Carp qw(croak);

##----------------------------------------------------------------------
## ???󥹥ȥ饯??
##----------------------------------------------------------------------
sub new{
  my $class  = shift;
  my $param  = shift if (@_);
  $param->{dummy}   = '';
  bless $param,$class;
}
##----------------------------------------------------------------------
## ?ե????ȥ??᥽?å?
##----------------------------------------------------------------------
sub create{
  my $self   = shift;
  my $format = shift  || croak ('format is not exist!! AGEMAKI');
  my $source = shift  || croak ('source is not exist!! AGEMAKI');
  my $obj;
  if($format =~ /yukiwiki/i){
    $obj = Text::Sukeroku::YukiWiki->new($source);
  }
  elsif($format =~ /pukiwiki/i){
    $obj = Text::Sukeroku::PukiWiki->new($source);
  }
  elsif($format =~ /hatena/i){
    $obj = Text::Sukeroku::HatenaDiary->new($source);
  }
  return $obj;
}
1;
