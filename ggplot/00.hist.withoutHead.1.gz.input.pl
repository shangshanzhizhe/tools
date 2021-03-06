#! /usr/bin/perl
use strict;
use warnings;

my $list=shift;
my $name=shift;
die "$0 histList Row(V1, V2 ,V3 ...)\n" unless $name;
open(OUT,"> $list.$name.Rscript");
print OUT "pdf(file=\"$list.$name.pdf\")\n";
print OUT "library(\"ggplot2\")\n";

print OUT "
a <- read.table(gzfile(\"$list\"),head=F)\n
ggplot(a,aes(x=a\$$name))+geom_histogram(binwidth=0.01)+xlab(\"$list\")+ylab(\"frequence\")\n
#+xlim(0,1)
#ggplot(a,aes(x=a\$$name))+geom_histogram(binwidth=50)+xlab(\"$list\")+ylab(\"frequence\")\n
";

print OUT "dev.off()\n";
close OUT;
`/ifshk4/BC_PUB/biosoft/PIPE_RD/Package/R-3.1.1/bin/Rscript $list.$name.Rscript`;
`rm $list.$name.Rscript`;
