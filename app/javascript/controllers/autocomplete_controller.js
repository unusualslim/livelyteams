import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };
  static targets = ["input", "suggestions"];

  connect() {
    console.log("AutocompleteController connected!");
    console.log("URL value:", this.urlValue);
    console.log("Input target:", this.inputTarget);
    console.log("Suggestions target:", this.suggestionsTarget);
  }

  search(event) {
    console.log("Search triggered! Query:", this.inputTarget.value);
    const query = this.inputTarget.value;
    if (query.length < 2) {
      this.suggestionsTarget.innerHTML = ""; // Clear suggestions for short queries
      this.suggestionsTarget.style.display = "none";
      return;
    }

    fetch(`${this.urlValue}?q=${query}`)
      .then((response) => response.json())
      .then((data) => {
        console.log("Suggestions data received:", data);
        this.renderSuggestions(data);
      });
  }

  renderSuggestions(data) {
    console.log("Rendering suggestions:", data);
    this.suggestionsTarget.innerHTML = ""; // Clear previous suggestions
    const cases = data.cases || [];
    const locations = data.locations || [];

    if (cases.length === 0 && locations.length === 0) {
      this.suggestionsTarget.style.display = "none";
      return;
    }

    const suggestions = [];

    if (cases.length > 0) {
      suggestions.push("<strong>Cases:</strong>");
      cases.forEach((item) => {
        suggestions.push(
          `<li data-url="${item.url}" class="suggestion-item">${item.name}</li>`
        );
      });
    }

    if (locations.length > 0) {
      suggestions.push("<strong>Locations:</strong>");
      locations.forEach((item) => {
        suggestions.push(
          `<li data-url="${item.url}" class="suggestion-item">${item.name}</li>`
        );
      });
    }

    this.suggestionsTarget.innerHTML = suggestions.join("");
    this.suggestionsTarget.style.display = "block";
  }

  select(event) {
    const url = event.target.dataset.url;
    console.log("Suggestion selected:", url);
    if (url) {
      window.location = url; // Redirect to the selected item's URL
    }
  }
}