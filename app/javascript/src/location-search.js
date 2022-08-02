/*$(document).on("keyup", "input[type=text]#order_location_id", function(){
   $.getJSON("/locations/search", {name: $(this).val()}).done(function(json){
      var locations = [];
      $.each(json.locations, function(location) {
         locations.push("<a href=\"#\" id="+ location.id +">" + location.name + "</a>");
      });
      $(".search").html(locations).show();
   });
});

$(document).on("click", ".search a", function(e) {
   e.preventDefault();
   // add hidden field with user name to form
});
*/
window.addEventListener("turbo:load", function() {
  $input = $("#case_location_search")

  var options = {

    getValue: "name",
    //getValue: function(element) {
    //  return element.name;
    //},
    url: function(phrase) {
      return "/locations/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "locations",
        header: "<strong>Assets</strong>",
      },
    ],
    list: {
      onSelectItemEvent: function() {
        var value = $("#case_location_search").getSelectedItemData().id
        $("#case_location_id").val(value).trigger("change");
        //console.log(id)
        //$input.val(element.id)
        //$input.val(id).trigger("change")
        //window.location = (id)
      }
    }
  }

  $input.easyAutocomplete(options)
});
