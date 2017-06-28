use LWP::UserAgent;
use HTTP::Request::Common qw(POST);

$| = 1;

$marker = 144706;
print "UniSTS ID: $marker\n";

$ua = LWP::UserAgent->new;

$req = new HTTP::Request GET => "http://www.ncbi.nlm.nih.gov/genome/sts/sts.cgi?uid=$marker";
$response = $ua->request($req);
$results = $response->content;

if ($results =~ /a name = taxid\d+><i>Mus musculus.{1,8000}Genomic RefSeqs.{1,100}nucleotide\/(\d+)">(.{1,40})<\/a.{23}(\d+).{4}(\d+)/s) {
print "Map: $1 from $3 to $4\nGrabbing amplicon...\n";

$arg1 = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/";

$req = new HTTP::Request GET => $arg1 . "efetch.fcgi?db=nuccore&id=$2&strand=1&seq_start=$3&seq_stop=$4&rettype=fasta&retmode=text";
$response = $ua->request($req);
$results = $response->content;

if ($results =~ /sequence(.*)/s){
	$dirty = $1;
	$dirty =~ s/[^ACTG]//g;
	print $dirty . "\n";
}

} else {
print "Failure finding genomic ePCR results";
}
