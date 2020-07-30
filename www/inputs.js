$(document).on('shiny:sessioninitialized', function(event) {
  // product mapping
  document.getElementById("table").addEventListener('input', function (event) {

    var txts = document.querySelectorAll('[aria-label*="Filter"]');
    var i;
    for (i = 0; i < txts.length; i++) {

      var txt = txts[i].value;
      var fld = 'txt' + i;
      console.log(txt);
      console.log(fld);
      Shiny.onInputChange(fld, txt);
    }

  });

});
