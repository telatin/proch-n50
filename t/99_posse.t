use 5.012;
use warnings;
use Test::More;
use FindBin qw($RealBin);
use File::Spec::Functions;
use Proch::Seqfu;
use lib $RealBin;
use TestFu;
ok(has_perl(), "Perl found at $^X");

 
done_testing();
