  document.addEventListener("turbo:load", functions($) {
    $(".table_search").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $(".searchable tr").filter(function() {
        $(this).toggle($(this).text()
        .toLowerCase().indexOf(value) > -1)
      });
    });
  });
