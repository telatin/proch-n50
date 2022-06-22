use strict;
use warnings;
use Test::More;
use FindBin qw($RealBin);
use File::Spec::Functions;


my $file = catfile($RealBin, "..", "data", "small_test.fa"); # "$RealBin/../data/small_test.fa";
my $bins  = catfile($RealBin, "..", "bin/");


SKIP: {
    my $n50bin = catfile($bins, "n50");
    skip "Skipping binary tests: $n50bin not found" unless (-e "$n50bin");
    skip "Input file not found: $file" unless (-e "$file");
    
    my $cmd = qq(perl "$n50bin" "$file");
    my $output = `$cmd`;
    chomp($output);
    ok($? == 0, "Exit status OK for n50: $?");
    ok($output == 65, "N50 calculated for $file as 65: $output");
}

done_testing();
