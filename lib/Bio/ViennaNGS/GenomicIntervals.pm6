# -*-CPerl-*-
# Last changed Time-stamp: <2019-02-12 18:20:33 mtw>

subset StrPlusOrMinus of Str where {
  .chars == 1 and m/^ \+|\-|\. $/
    or warn 'subtype StrPlusOrMinus must be one of \'+\',\'-\',\'.\''
  };

class Bio::ViennaNGS::FeatureInterval{
  has Str $.chromosome is rw is required;
  has Int $.start is rw is required where {$^num >= 0};
  has Int $.end is rw is required where {$^num >= 0};
  has Int $.length is rw;

  method compute_length {
    return ($!end-$!start);
  }

  submethod TWEAK (){
    $!length = self.compute_length();
  }
}
class Bio::ViennaNGS::MinimalFeature is Bio::ViennaNGS::FeatureInterval {
  has StrPlusOrMinus $.strand is rw is default('.');
}

class Bio::ViennaNGS::Feature is Bio::ViennaNGS::MinimalFeature {
  has Str $.name is rw is required;
  has Int $.score is rw is default(0);
}
