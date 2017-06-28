$fwd = "AAAGATGAGGGTGATTCGAGTG";
$rev = "AAGAATCTTGTCTCCCGTGG";
$source = "TCCCTGGTTAAGCAGTACAGCCCCAAAATGGTTAAGGTTGCAAGCTTGCTGGTGAAAAGGACCTCTCGAAGTGTTGGATACAGGCCAGACTTTGTTGGATTTGAAATTCCAGACAAGTTTGTTGTTTTTTAAAGATGAGGGTGATTCGAGTGGGCACCCGTAAGAGCCAGCTGGCTCGCATACAGACCGACACTGTGGTGGCGATGCTGAAAGCCTTGTACCCTGGCATACAGTTTGAAATCATTGCTATGTCCACCACGGGAGACAAGATTCTTGATACTGCACTCTCTAAGATTGGAG";

$source =~ s/[^actg]//gi;

$revfwd = reverse($fwd);

$compfwd = $fwd;
$compfwd =~ s/A/X/g;
$compfwd =~ s/T/A/g;
$compfwd =~ s/X/T/g;
$compfwd =~ s/C/X/g;
$compfwd =~ s/G/C/g;
$compfwd =~ s/X/G/g;

$revcompfwd = reverse($compfwd);

print "Forward 5': $fwd\n";
print "Forward 3': $revfwd\n";
print "Reverse 5': $compfwd\n";
print "Reverse 3': $revcompfwd\n\n";

if ($source =~ /($fwd)/i) { $pos1 = $-[0];
	print "FOUND using $fwd \(unmodified\) at position $pos1\n";
}
if ($source =~ /($revfwd)/i) { $pos1 = $-[0];
	print "FOUND using $revfwd \(reversed\) at position $pos1\n";
}
if ($source =~ /($compfwd)/i) { $pos1 = $-[0];
	print "FOUND using $compfwd \(complement\) at position $pos1\n";
}
if ($source =~ /($revcompfwd)/i) { $pos1 = $-[0];
	print "FOUND using $revcompfwd \(reverse complement\) at position $pos1\n";
}
print "\n";
$revrev = reverse($rev);

$comprev = $rev;
$comprev =~ s/A/X/g;
$comprev =~ s/T/A/g;
$comprev =~ s/X/T/g;
$comprev =~ s/C/X/g;
$comprev =~ s/G/C/g;
$comprev =~ s/X/G/g;

$revcomprev = reverse($comprev);

print "Forward 5': $rev\n";
print "Forward 3': $revrev\n";
print "Reverse 5': $comprev\n";
print "Reverse 3': $revcomprev\n\n";

if ($source =~ /($rev)/i) { $pos2 = $-[0];
	print "FOUND using $rev \(unmodified\) at position $pos2\n";
}
if ($source =~ /($revrev)/i) { $pos2 = $-[0];
	print "FOUND using $revrev \(reversed\) at position $pos2\n";
}
if ($source =~ /($comprev)/i) { $pos2 = $-[0];
	print "FOUND using $comprev \(complement\) at position $pos2\n";
}
if ($source =~ /($revcomprev)/i) { $pos2 = $-[0];
	print "FOUND using $revcomprev \(reverse complement\) at position $pos2\n";
}

if ($pos2 == 0) {
print "NOT FOUND\n"; }

$len = $pos2 - $pos1 + length($rev);

if ($pos1 * $pos2 != 0) {
print "\nAmplicon length: $len\n";
}