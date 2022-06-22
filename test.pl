my @output = `perl --version`;
print @output[1];
my $perlversion;
for my $line (@output) {
    print "-";
    chomp($line);
    print ">>> $line\n";
    if ($line =~/perl/i) {
        print 'OPK' ;
        $perlversion = $line;
        last;
    }
}
print $perlversion, "\n";