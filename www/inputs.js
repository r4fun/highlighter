$(document).on('shiny:sessioninitialized', function(event) {
  // product mapping
  document.getElementById("table").addEventListener('input', function (event) {

    var txts = document.querySelectorAll('[aria-label*="Filter"]');
    var i;
    var keywords = {};
    for (i = 0; i < txts.length; i++) {

      var txt = txts[i].value;
      var fld = 'txt' + i;
      keywords[fld] = txt;
    }
    console.log(keywords);

    Shiny.setInputValue("filter_words", keywords);

  });

});
