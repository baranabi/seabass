use strict;
use warnings;

# this script is used to rename the resource servers
# in the seabass.sh script, when we use docker-compose scale to generate resource containers
# the resource names in iRODS are generated from the container's CID. 
# So this script renames the resources into names that are human readable, and numbered. 
# the image named seabass_irs_n will have a resource name SBRS_n in iRODS. 


# number of resources provided as argument (see seabass.sh for usage example)
my $RESOURCES = $ARGV[0];

#first we wait for the resource servers to get ready. 
my $upcount = 0;
print "\nwaiting for resources to get ready...";
while ($upcount - 1 < $RESOURCES  ) {
  
  sleep 1;
  my $rstring = `docker exec -i icom ilsresc 2>/dev/null`;
  my @uparray = split("\n",$rstring);
  $upcount = scalar @uparray;
  print ".";
}
print "\n";


# open the csv of our formatted docker ps output. 
open (IN, "psparsed.csv");

while(<IN>) {
  chomp $_;
  my @rowvals = split(",", $_);
  
  # format of a row in this csv is 
  # <container type>,<container ID>,<container name>
  
  # we only want to deal with resource servers. 
  if ($rowvals[0] =~ /irs/)
  {
   # if we are here it means the current row is a resource server.
   # using the CID and the container name, we will rename resource using iadmin modresc.

    my $oldname = $rowvals[1] . 'Resource';
    my $rsno    = (split("_",$rowvals[2]))[2];
    my $newname = 'SBRS_'.$rsno;

    print "renaming $oldname to $newname\n\n"; 
    `echo y | docker exec -i icom  iadmin modresc $oldname name $newname`;
}
}

close IN;
exit;

