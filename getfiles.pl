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

my $cmd = "cd store;cd $room; ls -1 -v";
my @files = qx($cmd);
my $i = 0;

print "<div id=\"filecontainer\">";
foreach my $f (@files) {
  chomp($f);
  next if $f eq "currentstate";
  next if $f eq "thumb";
  print '<div>'.$f.'<br><img src="store/'.$room.'/thumb/'.$f.'"  onClick="present(this)"  data-file="'.$f.'" data-id="'.$i.'">
  <button type="button" onClick="window.open(\'store/'.$room.'/'.$f.'\')">View</button>
</div>';
  $i++;
  }
print "</div>";
print "<hr><select multiple=\"multiple\" id=\"filelist\" >\n";
foreach my $f (@files) {
  chomp($f);
  next if $f eq "currentstate";
  next if $f eq "thumb";
  print "<option value='$f'>$f</option>\n";
  } 
print "</select>";
