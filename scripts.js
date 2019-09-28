
var currentPic = ' ';
var currentRoom = ' ';

function getData(command,dId,callback) {
  
  var xmlhttp = null;
  var cb = null;
  xmlhttp=new XMLHttpRequest();
  cb = callback;
  var destId = dId;
  var cmd = command;
  
  xmlhttp.onreadystatechange = function() {
    if(xmlhttp.readyState == 4) {
      if(document.getElementById(destId)){
        document.getElementById(destId).innerHTML  = xmlhttp.responseText;  
        }
      if(cb) {
        cb(xmlhttp.responseText);
        }
      }
    }

  xmlhttp.open("GET",command,1);
  xmlhttp.send(null);
  }  


function updatefiles() {
  getData("getfiles.pl?room="+currentRoom,"files");
  }

function present(f) {
  if(f) {
    getData("showPic.pl?img="+f.getAttribute('data-file')+"&room="+currentRoom+'&posx=-1&posy=-1'); 
    }
  else {
    alert("Select a file to show!");
    }
  }
  
function presentNext(d) {
  if(d==40 || d==34) d=1;
  else if(d==38 || d==33) d=-1;
  else if(d==107 || d==171) {
    document.getElementById("content").classList.toggle("zoomed");
    return;
    }
  else return true;
  current = currentPic.split(',',1);
  for(i=0;i<document.getElementById('filecontainer').children.length;i++){
    if (document.getElementById('filecontainer').children[i].children[1].getAttribute('data-file') == current[0]) {
      break;
      }
    }  
  f = '';
  if(document.getElementById('filecontainer').children[i+d]) {
    f = document.getElementById('filecontainer').children[i+d].children[1].getAttribute('data-file');
    }
  if(f != "") {
    getData("showPic.pl?img="+f+"&room="+currentRoom+'&posx=-1&posy=-1');
    }  
  }

function deletePic(f) {

  g = '';
  x = document.getElementById('filelist');
  for (var i = 0; i < x.options.length; i++) {
   if(x.options[i].selected){
      g= g + '*' + x.options[i].value;
    }
  } 
  if(g != "") {
    if(confirm('Really delete selected files?'))
      getData("deletePic.pl?img="+g+"&room="+currentRoom);
    }
  else {
    alert("Select a file to delete!");
    }
  }

function pointer(e) {
  var t = document.getElementById("screen");
  
  var nat_aspect = t.naturalWidth / t.naturalHeight;
  var obj_aspect = t.width / t.height;
  
  var x;
  var y;
  if ( obj_aspect > nat_aspect ) { // we are limited in y
    var real_width = t.height * nat_aspect;
    var x_offset   = (t.width - real_width)/2;
    x = Math.round((e.pageX - t.offsetLeft - x_offset)/real_width*100);
    y = Math.round((e.pageY - t.offsetTop)/t.height*100);  
  } else { // we are limited in x
    var real_height = t.width / nat_aspect;
    var y_offset   = (t.height - real_height)/2;
    x = Math.round((e.pageX - t.offsetLeft)/t.width*100);
    y = Math.round((e.pageY - t.offsetTop - y_offset)/real_height*100);  
  }
  var i = currentPic.split(",");
//   alert("x: "+x+" y: "+y+"\nnat_aspect = "+nat_aspect+" obj_aspect = "+obj_aspect);
  getData("showPic.pl?img="+i[0]+"&room="+currentRoom+'&posx='+x+'&posy='+y);
  }

function updatepresentation(t) {
  currentRoom = document.getElementById("showroom").getAttribute("room");
  t = t.trim();
  if(currentPic != t) {
    var s = document.getElementById("screen");
    
    
    currentPic = t;
    var i = t.split(",");
    if(s) {
      var nat_aspect = s.naturalWidth / s.naturalHeight;
      var obj_aspect = s.width / s.height;
      
      
      if ( obj_aspect > nat_aspect ) { // we are limited in y
        var real_width = s.height * nat_aspect;
        var x_offset   = (s.width - real_width)/2;
//         x = Math.round((e.pageX - t.offsetLeft - x_offset)/real_width*100);
//         y = Math.round((e.pageY - t.offsetTop)/t.height*100);  
        x = i[1]*real_width/100-30 + s.offsetLeft + x_offset;
        y = i[2]*s.height/100-10 + s.offsetTop;
      } else { // we are limited in x
        var real_height = s.width / nat_aspect;
        var y_offset   = (s.height - real_height)/2;
//         x = Math.round((e.pageX - t.offsetLeft)/t.width*100);
//         y = Math.round((e.pageY - t.offsetTop - y_offset)/real_height*100);  
        x = i[1]*s.width/100-30 + s.offsetLeft;
        y = i[2]*real_height/100-10 + s.offsetTop + y_offset;
      }
      
      }
    else { x=0;y=0; }  
    document.getElementById("content").innerHTML = '<img id="screen" onClick="pointer(event);" src="store/'+currentRoom+'/'+i[0]+'"><div id="pointer" style="left:'+x+'px;top:'+y+'px;">&nbsp;</div>';

    }
  setTimeout('getData("getPic.pl?old='+t+'&room='+currentRoom+'",null,updatepresentation)',1000);  
  }


setTimeout('updatefiles();',500);
setTimeout('updatepresentation(" ");',200);
