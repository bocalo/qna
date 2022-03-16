// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "jquery";
import "@nathanvda/cocoon";
//const GistClient = require("gist-client");
//const gistClient = new GistClient();
import "bootstrap";
import "./answer";
import "./question";
import "./votes";
import createConsumer from "../channels/consumer";
//import createConsumer from "@rails/actioncable";

// window.App = window.App || {};
// window.App.cable = createConsumer();

window.jQuery = $;
window.$ = $;
//window.gistClient = new gistClient();

Rails.start();
Turbolinks.start();
ActiveStorage.start();
