#!/usr/bin/perl
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 

print "Content-type: text/html\n\n";

use Data::Dumper;
use warnings;
use strict;
use utf8;
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

use URI::Escape qw(uri_unescape uri_escape);

my $room = $ENV{'QUERY_STRING'};
$room =~ s![\(\)/]+!!g;


print <<HDOC;
<!DOCTYPE html>
<html lang="en">
<head>
 <title>Remote Presenter</title>
 <link rel="stylesheet" type="text/css" href="style.css">
 <script src="scripts.js" type="text/javascript"></script>
 <meta  charset="UTF-8"/>
</head>
<body id="showroom" room="$room" onKeyup="presentNext(event.keyCode)">
HDOC
print <<HDOC;
<div id="content">Remote Presenter<br>&lt;-- Click to show or just watch!</div>
<div id="control">
Select a file and press upload.
<form method="post" action="uploadFiles.pl" enctype="multipart/form-data" >
<input type="hidden" name="room" value="$room">
<input type="file" name="upfile">
<input type="submit" name="button" value="Upload">
</form>
<hr>
<button type="button" onClick="updatefiles();">Update file list</button>
<div id="files"> &nbsp; </div>
<br><button type="button" onClick="deletePic(document.getElementById('filelist').value)">Delete</button>

<!--<button type="button" onClick="window.open('store/$room/'+document.getElementById('filelist').value)">Show 2 Me</button>
<button type="button" onClick="present(document.getElementById('filelist').value)">Show 2 All</button>
<button type="button" onClick="togglemulti()" title='Enable selecting several files for deletion'>MS</button>-->

</body></html>
HDOC
  
  
  
  
  

