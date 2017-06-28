use LWP::UserAgent;
use HTTP::Request::Common qw(POST);

$| = 1;

$gene = "Gapdh";

$ua = LWP::UserAgent->new;

print "Searching Gene db for $gene...\n";
$arg1 = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/";
$req = new HTTP::Request GET => $arg1 . "esearch.fcgi?db=gene&term=" . $gene . "+mus+musculus&sort=relevance";
$response = $ua->request($req);
$results = $response->content;
if ($results =~ /Id>(\d+)</) { $geneid = $1;
print "success.. found gene ID $geneid\n";

print "Retrieving UniSTS marker IDs for $gene.. \n";
$req = new HTTP::Request GET => $arg1 . "efetch.fcgi?db=gene&id=$geneid";
$response = $ua->request($req);
$results = $response->content;
if ($results =~ /Entrezgene/) {
while ($results =~ /UniSTS",\s+tag\sid\s(\d+)/g) {
push @markers,$1;
}
$longest = 0;
foreach $marker (@markers)
{
	sleep  2;
	print "Retrieving primers for UniSTS ID $marker...\n";
	$req = new HTTP::Request GET => "http://www.ncbi.nlm.nih.gov/genome/sts/sts.cgi?uid=$marker";
	$response = $ua->request($req);
	$results = $response->content;
	if ($results =~ /Forward\sprimer:<\/td><td\s+class="TEXT"><b><TT>([ACTG]+)</) { if (length($1)>$longest) {$longest=length($1);}
	push @fwds, $1;	}
	if ($results =~ /Reverse\sprimer:<\/td><td\s+class="TEXT"><b><TT>([ACTG]+)</) {if (length($1)>$longest) {$longest=length($1);}
	push @revs, $1;	}
	if ($results =~ /class="TEXT">(\d+)\s\(bp\), <I>Mus musculus<\/I>/) {
	push @lengths, $1; } else { push @lengths, -1;}
	if ($results =~ /Mus musculus.{1,200}Warning/s) {
	$lengths[-1] *= -1; }
}
print "\nDone.. displaying primers and amplicon lengths\n\n";
$header = "UniSTS    %-" . $longest . "s    %-".$longest."s    LENGTH\n";
printf $header,"FORWARD","REVERSE";
foreach $marker (@markers)
{
$record = "%-6s    %-". $longest . "s    %-".$longest."s    %6s\n";
printf $record,$marker,shift @fwds,shift @revs,shift @lengths;
}

} else {
print "Failure fetching marker IDs for $geneid\n"; 
}
}
else {
print "Failure finding gene ID for $gene\n"
}

