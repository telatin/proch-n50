use strict;
use warnings;
use Test::More;
use FindBin qw($RealBin);
use File::Spec::Functions;
 

my $file = catfile($RealBin, "..", "data", "small_test.fa"); # "$RealBin/../data/small_test.fa";
my $bins  = catfile($RealBin, "..", "bin/");

ok(-d "$bins", "Binary directory found at <$bins>");
my $n50 = catfile($bins, "n50");
ok(-e "$n50", "N50 utility found at <$n50>");
my $grep = catfile($bins, "fu-grep");
ok(-e "$grep", "fu-grep utility found at <$grep>");


my @output = `$^X --version`;

my $perlversion;
for my $line (@output) {
    chomp($line);
    if ($line =~/perl/i) {
        $perlversion = substr($line, 0, 50);
        last;
    }
}
print $perlversion, "\n";
ok(defined($perlversion), "Detected interpreter: $perlversion");

my $n50_run = `$^X "$n50" "$file"`;

# This is not a test but a diagnostic for the logs of CI where --verbose is not enabled
ok(length($n50_run) >= 0, "Run util (exit: $?): <$n50_run> ");
done_testing();
