package TestFu;
use 5.012;
use warnings;
use FindBin qw($RealBin);
use File::Spec::Functions;
use Carp qw(confess);
use Data::Dumper;
use Term::ANSIColor qw(:constants);
use IPC::Run qw( run timeout );
use Test::More;
require Exporter;

$TestFu::VERSION = '0.0.1';


our @ISA = qw(Exporter);
our @EXPORT = qw(has_perl run_bin tot countseqs);
our @EXPORT_OK = qw(munge);  # symbols to export on request

my $bins  = catfile($RealBin, "..", "bin/");


sub has_perl {
    # Return non zero if perl does not work
    my $cmd = "$^X --version";
    my @lines = ();
    my $status;
    eval {
      @lines = `$cmd`;
      $status = $?;
    };
    
    if ($@) {
        say STDERR "Eval failed: $@\n";
        return 0;
    } elsif ($status != 0) {
        say STDERR "Exit status: $status\n";
        return 0;
    } else {
        # OK
        return 1
    }
}

sub run_bin {
    my ($prog, @args) = @_;
    my $script = catfile($bins, $prog);
    if (! -e "$script") {
        return (1, "NOT FOUND $script", "");
    }
    unshift(@args, $script);
    unshift(@args, $^X);
    my $in = '';
    my $out = '1';
    my $err = '1';
    my $ok = 0;
 
    if (run \@args, \$in, \$out, \$err, timeout( 60 )) {
        chomp($out);
        chomp($err);
        return (0, $out, $err);
    } else {
        say " ER Cmd    : ", join(" ",@args);
        say " ER Output : $out";
        say " ER Error  : $err";
        return (1, $out, $err);
    }
}

sub countseqs {
    my ($prog, @args) = @_;
    my ($status, $out, $err) = run_bin($prog, @args);
    # Split newline OS agnostic
    if ($status != 0) {
        say STDERR "[countseqs err] $out $err";
        return -1;
    }

    my @output = split(/\n/, $out);
    my $sum = 0;
    for my $line (@output) {
        
        if (substr($line, 0, 1) eq '>' or substr($line, 0, 1) eq '@') {
            $sum += 1;
        }
    }
    return $sum;
}

sub tot {
    my ($prog, @args) = @_;
    my ($status, $out, $err) = run_bin($prog, @args);
    my @output = split(/\n/, $out);
    my $sum = 0;
    for my $line (@output) {
        chomp($line);
        my ($id, $n) = split(/\t/, $line);
        $sum += $n;
    }
    return $sum;
}

1;