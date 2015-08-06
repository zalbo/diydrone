var numImgs = $(".thumb").length;
var showMin = 0 ;
var showMax = 5 ;

$(".thumb").hide().slice(showMin , showMax).show();


$( "#next" ).click(function() {
  console.log(showMin, showMax)
  var showMin = showMin + 1
  var showMax = showMax + 1
  $(".thumb").hide().slice(showMin , showMax).show();
});
