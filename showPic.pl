#!/usr/bin/perl
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 
use CGI;
print "Content-type: text/html\n\n";

my $cgi = new CGI();


my $room = $cgi->param("room");
if (!($room =~ /^[a-zA-Z0-9]+$/) || !(-d "store/$room")) {
  print "Invalid room";
  exit 1;
}

 
my $t = $cgi->param("img");
if(!($t =~  /^[a-zA-Z0-9\.\-_]+$/) || $t =~ /[\"\$\(\)\/]/ || !(-e "store/$room/$t")) {
  print "Invalid selection";
  exit 1;
}

my $tmp = $cgi->param("posx").','.$cgi->param("posy");
if(!($tmp =~ /^-?[0-9]+,-?[0-9]+$/)) {
  print "Invalid Position";
  exit 1;
  }
$t .= ','.$tmp;

system("echo $t>store/$room/currentstate");

1;
