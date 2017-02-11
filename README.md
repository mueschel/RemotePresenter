Remote Presenter
=========
A simple and tiny tool to quickly show some slides to others over the internet. There is no software needed on the client side, just a web browser. Everybody who has the webpage loaded in their browser can see the same image, can upload new files and select files to show to all other users.


Rationale
---------
The tool was invented to simplify some common issues experienced in everyday office life:
 * Two people on the phone discussing some slides. First slides need to be sent by mail, which sometimes takes longer than expected. During discussion both parties have to constantly update each other which slide they are currently viewing.
 * Round-table discussion meeting. Everybody wants to show 1-2 slides and give a short statement. Usually, either the cable to the projector is handed around from notebook to notebook, wasting a lot of time for configuration. Or the files are passed around on USB sticks to the meeting leader who has to open everything on his device.
 * Screen sharing during remote conferences. Many tools don't make it easy enough to share a certain portion of the screen or produce a horrible image quality.

All this can be replaced by an online tool, all meeting members have access to. Slides are uploaded beforehand or during the meeting by the participants and shown when needed. Everybody sees the same high-quality version of the information. To show slides on the projector, just open the web page using this tool on the main computer and sit back and relax.


Users Guide
-----------
 * The menu hides on the left side of the screen - move your pointer there or click close to the boarder of the window
 * File upload: First select a file (jpg, png, gif or pdf only), then click upload. Converting PDFs might take a moment.
 * Click on an image in the toolbar on the left to show it to all connected viewers
 * "View" - the selected image is shown in a new browser window, the public view is not changed
 * "Delete" - delete the selected files from the list above
 * Click anywhere in the image to set a red pointer for everybody to see
 * Images can be changed by using the arrow keys or Page Up/Down



Administrators Guide
--------------------
 * Most important things first: Security: 
  * DO NOT expose an installation of this tool to the world - use at your own risk and in trusted environment only.
  * This tool allows users to upload files to your server. You must secure access to the upload feature and the whole tool by using some kind of authentification.
  * The user submits file names to the server, e.g. to select which file is being shown. There are checks for the sanity of supplied file names which should prevent most attacks on the server, but is in now way secure.
 * Requirements: A web server (e.g. Apache) running Perl and an installation of ImageMagick to resize images and convert uploaded PDF files.
 * To create new rooms, just create a new subdirectory under 'store'. In this subdirectory, create a directory called 'thumb'. Make sure, both files are writeable by the web server.

License
-------
This tool is available under cc-by-nc-sa 3.0
https://creativecommons.org/licenses/by-nc-sa/3.0/
The code is distributed as-is without any guarantee whatsoever.