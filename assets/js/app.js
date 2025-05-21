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

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import NotificationHook from "./notifications"
// import { getStoredTheme, setTheme } from "./theme"

// window.addEventListener("DOMContentLoaded", () => {
//   const theme = getStoredTheme() || "light";
//   setTheme(theme);
// });

document.addEventListener('click', function(event) {
  const toggle = document.getElementById('hamburger');
  const dropdown = document.getElementById('menu-dropdown');
  const checkbox = document.getElementById('menu-toggle');

  const clickedInside = toggle.contains(event.target) || dropdown.contains(event.target);

  if (!clickedInside) {
  checkbox.checked = false;
  }
});

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {

  // params: {
  //   _theme: getStoredTheme() || "light"
  // },
  
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: {
    NotificationHook,
    // Add the handleEvent for "theme-changed"
    // ThemeChange: {
    //   mounted() {
    //     this.handleEvent("theme-changed", ({ theme }) => {
    //       setTheme(theme);
    //     });
    //   }
    // }
    // Add any other hooks here
  }
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

