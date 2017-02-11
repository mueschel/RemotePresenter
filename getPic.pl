#!/usr/bin/perl
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 
use CGI;
print "Content-type: text/html\n\n";


my $cgi = new CGI();


my $room = $cgi->param('room');
if (!($room =~ /^[a-zA-Z0-9]+$/) || !(-d "store/$room")) {
  print "Invalid room";
  return 1;
}

my $old = $cgi->param('old');
my $timer = 0;
my $f;
do {
  open FILE, "<", "store/$room/currentstate";
  my @data = <FILE>;
  close FILE;
  $f = $data[0];
  chomp($f);
  sleep(1) if($f eq $old);
  }while($timer++ < 40 && $f eq $old);

print $f;
