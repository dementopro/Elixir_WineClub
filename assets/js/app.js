// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
// SCOTT comment 
// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
//SCOTT START
//import Alpine from "alpinejs";
// scott import Alpine from "alpinejs"
//import Alpine from "alpinejs"
//import "alpinejs"
// SCOTT END

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

// comment by scott let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// coommnet scott let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
//SCOTT NEW ALPINEa
// SCOTT indow.Alpine = Alpine;
// scott Alpine.start();
let hooks = {};
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: hooks,
  dom: {
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) {
        window.Alpine.clone(from, to);
      }
    },
  },
});
// ENDALPINE
// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

var productDropdown = document.getElementById("wines");

productDropdown.addEventListener('click', removeClass);

var setVisibleList = 1;

function removeClass() {
  var hiddenClassElement = document.querySelector('[aria-labelledby="wine-product"]');
  setVisibleList *= -1;
  setVisibleList == -1 ? hiddenClassElement.classList.remove("hidden") : hiddenClassElement.classList.add("hidden");
}

//TODO: Dropdown mobile menu
const btn = document.querySelector('button.menu-button');
const menu = document.querySelector('.mobile-menu');

btn.addEventListener('click', () => {
  menu.classList.toggle('hidden');
});


//IMPLEMENT: DROPDOWN WINE_MOBILE
var user_menu = document.getElementById("wine_mobile");

user_menu.addEventListener('click', mobilewinedropdown);

var setVisibleList = 1;

function mobilewinedropdown() {
  var hiddenClassElement = document.querySelector('[aria-labelledby="mobile_drop"]');
  setVisibleList *= -1;
  setVisibleList == -1 ? hiddenClassElement.classList.remove("hidden") : hiddenClassElement.classList.add("hidden");
}



