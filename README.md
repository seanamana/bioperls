A smattering of utilities I did mostly in Perl to do various genomics / bioinformatics tasks.

Perl - seqfind.pl - given a target sequence and two primer locations, checks that the sequence matches (including notification if you accidentally took the complement) and gives the positions, amplicon and length

Perl - markersearch.pl - searched NCBI Entrez database for sequence tagged sites (STS) for a given gene (defaults to Gapdh) and parses results to output candidate primer sets and associated amplicons for analysis

Perl - grabunistsamplicon.pl - similar, scraped NCBI nucleotide database for sequences specific to mice for a given sequence tagged site (used for testing genomic mouse DNA)

Sadly these are deprecated since the UniSTS database was merged with the Probe database in 2015, one year after I wrote these. But I think they could be adapted pretty easily to that database.

C# - MeltTempLookup - uses the IDT Oligo Analyzer API to get the melt temperature of a given sequence, which I used in a proprietary program to design primers and probes for SNPs