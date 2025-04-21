// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "trix"
import "@rails/actiontext"
import "./src/jquery"
import "./src/easy-autocomplete"
import "./src/site-search"
import "./src/geeks_table_search"
import "./src/location-search"
import "./src/tinymce_init"

import { Application } from "@hotwired/stimulus";

const application = Application.start();
export { application };