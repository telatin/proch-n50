package Proch::Seqfu;
#ABSTRACT: Helper module to support Seqfu tools

use 5.014;
use warnings;
use Carp qw(confess);
use Data::Dumper;
use Term::ANSIColor qw(:constants);
require Exporter;

$Proch::SeqFu::VERSION = '1.5.0tou';
$Proch::SeqFu::fu_linesize = 0;
$Proch::SeqFu::fu_verbose  = 0;

our @ISA = qw(Exporter);
our @EXPORT = qw(rc fu_printfasta fu_printfastq verbose);
our @EXPORT_OK = qw(munge frobnicate $fu_linesize $fu_verbose);  # symbols to export on request

=head1 Proch::Seqfu

a legacy module for Seqfu utilities

=head2 fu_printfasta(name, comment, seq)

This function prints a sequence in fasta format

=cut

sub fu_printfasta {
    my ($name, $comment, $seq) = @_;
    my $print_comment = '';
    if (defined $comment) {
        $print_comment = ' ' . $comment;
    }

    say '>', $name, $print_comment;
    print split_string($seq);
}

=head2 fu_printfastq(name, comment, seq, qual)

This function prints a sequence in FASTQ format

=cut
sub fu_printfastq {
    my ($name, $comment, $seq, $qual) = @_;
    my $print_comment = '';
    if (defined $comment) {
        $print_comment = ' ' . $comment;
    }

    say '@', $name, $print_comment;
    print split_string($seq) , "+\n", split_string($qual);
}

=head2 verbose(msg)

Print a text if $fu_verbose is set to 1

=cut

# Print verbose info
sub verbose {
    if ($Proch::SeqFu::fu_verbose) {
        say STDERR " - ", $_[0];
    }
}

=head2 rc(dna)

Return the reverse complement of a string [degenerate base not supported]

=cut

sub rc {
    my   $sequence = reverse($_[0]);
    if (is_seq($sequence)) {
        $sequence =~tr/ACGTacgt/TGCAtgca/;
        return $sequence;
    }
}

=head2 is_seq(name, comment, seq)

Check if a string is a DNA sequence, including degenerate chars.

=cut

sub is_seq {
    my $string = $_[0];
    if ($string =~/[^ACGTRYSWKMBDHVN]/i) {
        return 0;
    } else {
        return 1;
    }
}

=head2 split_string(dna)

Add newlines using $Proch::SeqFu::fu_linesize as line width

=cut

sub split_string {
	my $input_string = $_[0];
	my $formatted = '';
	my $line_width = $Proch::SeqFu::fu_linesize; # change here
    return $input_string. "\n" unless ($line_width);
	for (my $i = 0; $i < length($input_string); $i += $line_width) {
		my $frag = substr($input_string, $i, $line_width);
		$formatted .= $frag."\n";
	}
	return $formatted;
}
1;

__END__

Nucleotide Code:  Base:
----------------  -----
A.................Adenine
C.................Cytosine
G.................Guanine
T (or U)..........Thymine (or Uracil)
R.................A or G
Y.................C or T
S.................G or C
W.................A or T
K.................G or T
M.................A or C
B.................C or G or T
D.................A or G or T
H.................A or C or T
V.................A or C or G
N.................any base
. or -............gap
