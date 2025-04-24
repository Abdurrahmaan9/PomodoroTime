let ThemeHook = {
   mounted() {
     const theme = localStorage.getItem("theme");
     if (theme) {
       this.pushEvent("set_theme", { theme });
     }
   }
 };
 export default ThemeHook;
 