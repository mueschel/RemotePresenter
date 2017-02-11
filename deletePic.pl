#!/usr/bin/perl
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 
use CGI;
print "Content-type: text/html\n\n";

my $cgi = new CGI();


my $room = $cgi->param("room");
if (!($room =~ /^[a-zA-Z0-9]+$/) || !(-d "store/$room")) {
  print "Invalid room";
  return 1;
}

 
my $s = $cgi->param("img");
my @r = split('\*',$s);

foreach my $t (@r) {
  if(($t =~ /[\"\$\(\)\/]/ || !(-e "store/$room/$t")) && ($t =~ /.png$/i || $t =~ /.jpg$/i)) {
    print "Invalid selection $t";
    #return 1;
  }
  else {
  system("rm store/$room/$t store/$room/thumb/$t");
}
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

1;
