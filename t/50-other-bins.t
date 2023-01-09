use strict;
use warnings;
use Test::More;
use FindBin qw($RealBin);
use File::Spec::Functions;
use lib $RealBin;
use TestFu;

my $file = catfile($RealBin, "..", "data", "small_test.fa"); # "$RealBin/../data/small_test.fa";
my $bins  = catfile($RealBin, "..", "bin/");

sub test_bin {
    my ($prog, @args) = @_;
    my ($status, $out, $err) = run_bin($prog, @args);
    ok($status == 0, "[$prog] ran successfully with @args");
}


SKIP: {
    my $hashBin = catfile($bins, "fu-hash");

    skip "Directory not found" unless (-d "$bins");
    skip "Skipping binary tests: $hashBin not found" unless (-e "$hashBin");
    skip "Input file not found: $file" unless (-e "$file");
    skip "Failed calling \$^X externally (maybe is perl.exe?)" if (not has_perl());


    test_bin("fu-hash", $file);

	test_bin("fu-grep", "ACACACA", $file); 
    
    test_bin("fu-uniq", $file);
    
    test_bin("fu-sort", $file);
    
    test_bin("fu-rename", $file);
    
    test_bin("fu-extract",  $file);
    
}
done_testing();
