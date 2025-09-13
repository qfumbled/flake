// widget/bar/index.tsx
import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"

export default function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
  let win: Astal.Window

  return (
    <window
      $={(self) => (win = self)}
      visible
      namespace="Bar"
      name={`bar-${gdkmonitor.connector}`}
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      application={app}
      heightRequest={35}
    >
      <centerbox>
        <box $type="start" orientation={Gtk.Orientation.HORIZONTAL} spacing={0}>
          {/* left widgets go here */}
        </box>
        <box $type="end" orientation={Gtk.Orientation.HORIZONTAL} spacing={0}>
          {/* right widgets go here */}
        </box>
      </centerbox>
    </window>
  )
}
