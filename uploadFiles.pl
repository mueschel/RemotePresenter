#!/usr/bin/perl
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 
use CGI;
use warnings;

my $cgi = new CGI();
print "Content-type: text/html\n\n";


my $upfile = $cgi->param('upfile');

my $room = $cgi->param('room');
if (!($room =~ /^[a-zA-Z0-9]+$/) || !(-d "store/$room")) {
  print "Invalid room $room";
  return 1;
}


my $basename = GetBasename($upfile);
$basename =~ s-/--;
$basename =~ s-\s--;

unless($basename =~ /^[a-zA-Z0-9\.\-_]+$/) {
  print("Filename contains invalid characters. Only a-z A-Z 0-9 . _ - are allowed.");
  exit(-1);
  }

my $fh = $cgi->upload('upfile'); 


if (! open(OUTFILE, ">store/$room/$basename") ) {
  print "Can't open outfile for writing - $!";
  exit(-1);
}

my $nBytes = 0;
my $totBytes = 0;
my $buffer = "";
while ( $nBytes = read($upfile, $buffer, 1024) ) {
  print OUTFILE $buffer;
  $totBytes += $nBytes;
}
close(OUTFILE);

if($basename =~ /\.pdf$/i) {
  my $b = $basename;
  $b =~ s/.pdf//i;
  system("cd store/$room;../../convert.sh \"$basename\" \"$b\"");
  system("rm \"store/$room/$basename\"");
  system("cd store/$room;mogrify -path thumb -thumbnail 200x200 $b*.png");
  }
else {
  system("cd store/$room;mogrify -path thumb -thumbnail 200x200 $basename");
  }



sub GetBasename {
  my $fullname = shift;

  my(@parts);
  # check which way our slashes go.
  if ( $fullname =~ /(\\)/ ) {
    @parts = split(/\\/, $fullname);
  } else {
    @parts = split(/\//, $fullname);
  }

  return(pop(@parts));
}


print <<REDOC;
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="refresh"   content="0; url=showroom.pl?$room">
</head>
<body>
</body>
</html>
REDOC
