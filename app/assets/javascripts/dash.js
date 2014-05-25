var dispHandle = function(id){
obj = document.getElementById(id);
if (obj.style.display == "none"){
obj.style.display = "block";
 document.getElementById("box").style.display = "none";
}
else{
obj.style.display = "none";
 document.getElementById("box").style.display = "block";
}
return false;
}