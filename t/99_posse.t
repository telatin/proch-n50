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

ok(defined $success, "Defined success");
ok($success!=0, "Defined success $success");
( $success, $errarray, $buffer, $outarray, $errbuff ) = run( 
                command => ["not_found"],
                timeout => 1 );
ok(($errarray and $errarray =~ /No such file or directory/i), "Not found");
ok((not defined $success), "Not defined success when failed ");
( $success, $errarray, $buffer, $outarray, $errbuff ) = run( 
                command => ["sleep", 5],
                timeout => 1 );

 

ok(($errarray and $errarray =~ /timeout/i), "Timeout works");
ok((not defined $success), "Not defined success when timedout ");
done_testing();
