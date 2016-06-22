
var doDash = function(){
var width = window.innerWidth
|| document.documentElement.clientWidth
|| document.body.clientWidth;
var height = window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;

  if(document.getElementById("box").style.display == "block"){
      document.getElementById("dash").style.display = "block";
      document.getElementById("box").style.display = "none";
  }else{
    document.getElementById("box").style.display = "block";
    document.getElementById("dash").style.display = "none";
  }
}
