#!/usr/bin/perl
use CGI::Carp qw(warningsToBrowser fatalsToBrowser); 

print "Content-type: text/html\n\n";



print <<HDOC;
<!DOCTYPE html>
<html lang="en">
<head>
 <title>Remote Presenter</title>
 <link rel="stylesheet" type="text/css" href="style.css">
 <script src="scripts.js" type="text/javascript"></script>
 <meta  charset="UTF-8"/>
</head>
<body class="title">
<h1>Remote Presenter</h1>
<p>Please select a room to enter:
<p><select id="roomlist" size="20">
HDOC
my @files = qx(cd store; ls -1 -v );

foreach my $f (@files) {
  chomp($f);
  print "<option value='$f'>$f\n";
  } 

print <<HDOC;
</select><br>
<button type="button" onClick="window.location='showroom.pl?'+document.getElementById('roomlist').value">Enter Room</button>

<h2>Usage summary</h2>
<ul>
<li>The menu hides on the left side of the screen - move your pointer there or click close to the boarder of the window
<li>File upload: First select a file (jpg, png, gif or pdf only), then click upload. Converting PDFs might take a moment
<li>Click on an image to show to all connected viewers
<li>"View" - the selected image is shown in a new browser window, the public view is not changed
<li>"Delete" - delete the selected files from the list above
<li>Click anywhere in the image to set a red pointer for everybody to see
<li>Images can be changed by using the arrow keys
</body>
</html>
HDOC
