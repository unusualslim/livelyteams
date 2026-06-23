import TomSelect from "tom-select";

function initTomSelects() {
  // Single selects
  document.querySelectorAll("select.tom-select-single:not(.tomselected)").forEach(el => {
    new TomSelect(el, { allowEmptyOption: true });
  });

  // Multi selects
  document.querySelectorAll("select.tom-select-multi:not(.tomselected)").forEach(el => {
    new TomSelect(el, { plugins: ["remove_button"] });
  });
}

document.addEventListener("turbo:load", initTomSelects);
document.addEventListener("DOMContentLoaded", initTomSelects);
