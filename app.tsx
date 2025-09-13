// app.tsx
import app from "ags/gtk4/app"
import style from "./style.scss"
import NotificationPopups from "./widget/comp/notification/NotificationPopups"
import Bar from "./widget/bar/index"  // default import

app.start({
  css: style,
  gtkTheme: "adw-gtk3-dark",
  main() {
    // Show notification popups
    NotificationPopups()

    // Create a bottom bar for each monitor
    app.get_monitors().forEach((monitor) => {
      Bar({ gdkmonitor: monitor }) 
    })
  },
})
