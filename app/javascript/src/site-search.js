window.addEventListener("turbo:load", function() {
  $input = $("[data-behavior='autocomplete']")

  var options = {

    getValue: "name",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "cases",
        header: "<strong>Cases:</strong>",
      },
      {
        listLocation: "locations",
        header: "<strong>Locations</strong>",
      }
    ],
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url
        $input.val("")
        window.location = (url)
      }
    }
  }

  $input.easyAutocomplete(options)
});
