#!/usr/bin/perl -w

# $Id$
# (C) 2003 Ole Tange http://ole.tange.dk under GPL
# 
# Programmet tager stikordsfilerne fra hver af bøgerne og
# samler dem til en liste. Listen splittes op i forbogstaver
# og gemmes som enkeltfiler kaldet idx-[a-z].html
#
# Programmet skal køres fra det subdir der skal være udgangs-
# punkt til sidst.
#
# Brug:
#   stikord.pl <fil1.html> [fil2.html [fil3.html]]
# Eksempel:
#   stikord.pl admin/bog/stikord.html unix/bog/stikord.html
#   stikord.pl */bog/stikord.html

use HTML::TreeBuilder;
#use Data::Dumper;

my $html_start="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/html40/loose.dtd\">
<html><head><title>Stikord - Friheden Til At Vælge</title>
<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=iso-8859-1\">
<meta name=\"robots\" content=\"noindex\"><!-- indekser ikke denne side, men følg links -->
</head><body>
";
my $html_end="</body></html>";

my $t_file1 = shift;
my $base=$t_file1; $base=~s:(^.*/)[^/]+:$1:;

my $tree1 = HTML::TreeBuilder->new_from_file($t_file1);
new_base_href($tree1,$base);

for $t_file2 (@ARGV) {
    my $base=$t_file2; $base=~s:(^.*/)[^/]+:$1:;
    my $tree2 = HTML::TreeBuilder->new_from_file($t_file2);
    new_base_href($tree2,$base);
    merge($tree1,$tree2);
    #$tree2->delete;
}
print_as_files($tree1);
#$debug and do {
#    open (FIL,">/tmp/dump.html");
#    print FIL $tree1->as_HTML;
#};
$tree1->delete;

sub print_as_files {
    my($tree)=@_;    
    my $arr=$tree->{_body}{_content}[1]{_content};
    
    for (@$arr) {
	my $overskrift=lc(overskrift($_));
	$overskrift=~s/\.//;
	if ($overskrift) {
		open (FIL, ">idx-${overskrift}.html") || die;
		print FIL $html_start;
		print FIL $_->as_HTML;
		print FIL $html_end;
		close FIL;
	}
    }
}

sub merge {
    my($tree1,$tree2)=@_;
    my $node;
    $index1=$tree1->{_body}{_content}[1];
    $index2=$tree2->{_body}{_content}[1];
    $bogstav1=1;
    $bogstav2=1;
    $overskrift1=overskrift($index1->{_content}[$bogstav1]);
    $overskrift2=overskrift($index2->{_content}[$bogstav2]);
    while($overskrift1 and $overskrift2) {
	if($overskrift1 eq $overskrift2) {
	    # o1 og o2 er samme bogstav: kombiner dem
	    my($p1,$p2)=($index1->{_content}[$bogstav1]{_content}[1],
			     $index2->{_content}[$bogstav2]{_content}[1]);
	    my @tmp=@{$p2->content}; # Stupid, but needed pga. push_content-sideeffects
	    for (@tmp) { $p1->push_content($_); }
	    # sorter
	    #  Gruppér ord med underord til sortering
	    my ($groups);
	    my $i=-1;
	    for($p1->content_list) {
		if (is_primary_word($_)) { $i++; }
		push @{$groups->[$i]}, $_;
	    }    
	    #  sorter grupper
	    #$debug and do { 
	    #	print map { "//". "${$_}[0]->{_content}[0]" } @{$groups} ;
	    #	print "\n";
	    #};
	    @{$groups} = sort { 
		    my ($la,$lb)=(lc(${$a}[0]->{_content}[0]),
				  lc(${$b}[0]->{_content}[0]));
		    $la cmp $lb;
		} @{$groups};
	    #  Ungroup 
	    my @unpack=();
	    for (@$groups) { push @unpack, @$_; }
	    @{$p1->content_array_ref}=@unpack;
	    # next o1 
	    $bogstav1++; $overskrift1=overskrift($index1->{_content}[$bogstav1]);
	    # next o2
	    $bogstav2++; $overskrift2=overskrift($index2->{_content}[$bogstav2]);
	} elsif ($overskrift1 gt $overskrift2) {
	    # o2 eksisterer ikke i o1: indsæt o2
	    my $clone=$index2->content->[$bogstav2]->clone;
	    $index1->splice_content($bogstav1,0,$clone);
	    # next o2;
	    $bogstav2++; $overskrift2=overskrift($index2->{_content}[$bogstav2]);
	    # o1 er blevet længere
	    $bogstav1++;
	    $overskrift1=overskrift($index1->{_content}[$bogstav1]);
	} elsif ($overskrift1 lt $overskrift2) {
	    # o1 eksisterer ikke i o2: indsæt o1 (er allerede indsat)
	    # next o1;
	    $bogstav1++; $overskrift1=overskrift($index1->{_content}[$bogstav1]);
	} else {
	    die;
	}
    }
    while($overskrift2 and not $overskrift1) {
	    # o2 eksisterer ikke i o1: indsæt o2
	    my $arr=$index2->{_content}[$bogstav2];
	    splice(@{$index1->{_content}},$bogstav1,0,$arr);
	    # next o2;
	    $bogstav2++; $overskrift2=overskrift($index2->{_content}[$bogstav2]);
	    # o1 er blevet længere
	    $bogstav1++;
	    $overskrift1=overskrift($index1->{_content}[$bogstav1]);
    }
}

sub overskrift {
    my $node=shift;
    my $overskrift;
    if ($node) {
	$overskrift=$node->look_down("_tag" => "a")->as_text;
	if(defined($overskrift) and $overskrift eq "Symboler") { $overskrift=".".$overskrift }
    } else {
	# Man kan ikke tage overskriften paa ingenting.
	$overskrift=undef;
    }
    return $overskrift;
}

sub is_primary_word {
    my $ref=shift;
    return not ref $ref->content->[0];
}

sub new_base_href {
    my $tree = shift;
    my $base = shift;
    my @dummy = $tree->look_down ("_tag" => "a", 
			   sub { 
			       my $href= $_[0]->attr('href');
			       if(defined $href) { $_[0]->attr('href',$base.$href)}
			   }
			   );
}
