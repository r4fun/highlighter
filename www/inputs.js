$(document).on('shiny:sessioninitialized', function(event) {
  // product mapping
  document.getElementById("table").addEventListener('input', function (event) {

    var txt1 = document.querySelector('[aria-label="Filter Negative Reviews"]').value;
    Shiny.onInputChange('txt1', txt1);

    var txt2 = document.querySelector('[aria-label="Filter Positive Reviews"]').value;
    Shiny.onInputChange('txt2', txt2);

  });

});
