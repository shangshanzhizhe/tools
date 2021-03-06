#! /usr/bin/perl
use strict;
use warnings;

my $vcf=shift;
die"1.vcf.to.maf.chr.pl vcfFile\n"unless $vcf;
open(IN, "$vcf");
open(OUT,"> $vcf.maf");
while(<IN>){
    chomp;
    next if (/^#/);
    my @a=split(/\s+/);
    my $A1=0;    my $A2=0;
    for(my $i=9;$i<@a;$i++){
        if($a[$i] =~ /0\/0/){
            $A1 += 2;
        }elsif($a[$i] =~ /0\/1/){
            $A1++;
            $A2++;
        }elsif($a[$i] =~ /1\/1/){
            $A2 += 2;
        }
    }
    my @b=($A1,$A2);
    @b=sort{$a<=>$b} @b;
    #if($A1+$A2 != 40){
    #    print "$a[0]\t$a[1]\t$A1\t$A2\n";
    #}
    print OUT "$a[0]\t$a[1]\t$b[0]\t$b[1]\n";
}
close IN;
close OUT;
