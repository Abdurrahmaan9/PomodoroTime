let NotificationHook = {
   mounted() {
     // Requesting notification permission when the LiveView mounts
     if (Notification.permission === "default") {
       Notification.requestPermission().then(permission => {
         console.log("Notification permission:", permission)
       })
     }

     // Listening for notification events from the server
     this.handleEvent("notify", ({ session_type, message }) => {
       if (Notification.permission === "granted") {
         new Notification(`${session_type} Session`, {
           body: message,
           icon: "/images/icons/icons8-notification-50.png"
         })
      }
     })
   }
}
export default NotificationHook;