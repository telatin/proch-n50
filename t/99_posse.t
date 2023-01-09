use 5.012;
use warnings;
use Test::More;
use FindBin qw($RealBin);
use File::Spec::Functions;
use Proch::Seqfu;
use lib $RealBin;
use TestFu;
use IPC::Cmd qw(run);
ok(has_perl(), "Perl found at $^X");

my( $success, $errarray, $buffer, $outarray, $errbuff ) = run( 
                command => ["ls"],
                timeout => 1 );

say "ls=$success|";
 
( $success, $errarray, $buffer, $outarray, $errbuff ) = run( 
                command => ["xls"],
                timeout => 1 );

say "xls=$success|";

( $success, $errarray, $buffer, $outarray, $errbuff ) = run( 
                command => ["sleep", 5],
                verbose => 1,
                timeout => 1 );

say "sleep=$success|";
done_testing();
