use strict;
use warnings;
use Proch::N50;
use FASTX::Reader;
use Test::More;
use FindBin qw($RealBin);

my $v = $FASTX::Reader::VERSION;
my ($v1, $v2, $v3) = split /\./, $v;

my $file = "$RealBin/../data/small_test.fa";
my $bins  = "$RealBin/../bin/";
SKIP: {
	my $grep = `$bins/fu-grep ACACACA $file`;
    ok($? == 0, "[fu-grep] Program executed with status 0: $?");

    my $uniq = `$bins/fu-uniq $file`;
    ok($? == 0, "[fu-uniq] Program executed with status 0: $?");

    my $sort = `$bins/fu-sort $file`;
    ok($? == 0, "[fu-sort] Program executed with status 0: $?");

    my $rename = `$bins/fu-rename $file`;
    ok($? == 0, "[fu-rename] Program executed with status 0: $?");

    my $rename = `$bins/fu-extract $file`;
    ok($? == 0, "[fu-extract] Program executed with status 0: $?");
}

done_testing();
