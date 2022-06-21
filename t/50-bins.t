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
sub execute {
    my ($prog, @args) = @_;
    my $cmd = "perl $bins/$prog";
    for my $arg (@args) {
        $cmd .= " \"$arg\" ";
    }
    my $output = `$cmd`;
    return ($?, $output)
}
SKIP: {
    my $status;
    my $output;
	($status, $output) = execute("fu-grep", "ACACACA", $file); #`$bins/fu-grep ACACACA $file`;
    ok($status == 0, "[fu-grep] Program executed with status 0: $status");

    ($status, $output) = execute("fu-uniq", $file);
    ok($status == 0, "[fu-uniq] Program executed with status 0: $status");

    ($status, $output) = execute("fu-sort", $file);
    ok($status == 0, "[fu-sort] Program executed with status 0: $status");

    ($status, $output) = execute("fu-rename", $file);
    ok($status == 0, "[fu-rename] Program executed with status 0: $status");

    ($status, $output) = execute("fu-extract",  $file);
    ok($status == 0, "[fu-extract] Program executed with status 0: $status");
}

done_testing();
