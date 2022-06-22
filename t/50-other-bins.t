use strict;
use warnings;
use Test::More;
use FindBin qw($RealBin);
use File::Spec::Functions;


my $file = catfile($RealBin, "..", "data", "small_test.fa"); # "$RealBin/../data/small_test.fa";
my $bins  = catfile($RealBin, "..", "bin/");

sub execute {
    my ($prog, @args) = @_;
    my $script = catfile($bins, $prog);
    my $cmd = "perl \"$script\"";
    my $output;
    my $status;
    for my $arg (@args) {
        $cmd .= " \"$arg\" ";
    }
    
    $output = `$cmd`;
    $status = $?;
    return ($status, $output, $cmd);
    
}

sub testbin {
    my ($prog, @args) = @_;
    my ($status, $output, $cmd) = execute($prog, @args); 
    ok($status == 0, "[$prog] Program executed as: \n`$cmd`\n  with status 0: got $status");
}
SKIP: {
    my $grepBin = catfile($bins, "fu-grep");
    skip "Skipping binary tests: $grepBin not found" unless (-e "$grepBin");
    skip "Input file not found: $file" unless (-e "$file");
    my $status;
    my $output;
	testbin("fu-grep", "ACACACA", $file); #`$bins/fu-grep ACACACA $file`;
    
    testbin("fu-uniq", $file);
    
    testbin("fu-sort", $file);
    
    testbin("fu-rename", $file);
    
    testbin("fu-extract",  $file);
    
}
done_testing();
