import {Astal, Gdk, Gtk} from "astal/gtk4"
import Notifd from "gi://AstalNotifd"
import Notification from "./Notification"
import {type Subscribable} from "astal/binding"
import {bind, GLib, Variable} from "astal"

const TIMEOUT_DELAY = 5_000

class NotifiationMap implements Subscribable {
    private map: Map<number, Gtk.Widget> = new Map()

    private var: Variable<Array<Gtk.Widget>> = Variable([])

    private notifiy() {
        this.var.set([...this.map.values()].reverse())
    }

    constructor() {
        const notifd = Notifd.get_default()

        // notifd.ignoreTimeout = true

        notifd.connect("notified", (_, id) => {
            let hideTimeout: GLib.Source | null = null

            if (notifd.dontDisturb) {
                return
            }

            this.set(id, Notification({
                notification: notifd.get_notification(id)!,

                onHoverLost: () => {
                    hideTimeout = setTimeout(() => {
                        this.delete(id)
                        hideTimeout?.destroy()
                        hideTimeout = null
                    }, TIMEOUT_DELAY)
                },
                onHover() {
                    hideTimeout?.destroy()
                    hideTimeout = null
                },

                setup: () => {
                    hideTimeout = setTimeout(() => {
                        this.delete(id)
                        hideTimeout?.destroy()
                        hideTimeout = null
                    }, TIMEOUT_DELAY)
                },
                useHistoryCss: false
            }))
        })

        notifd.connect("resolved", (_, id) => {
            this.delete(id)
        })
    }

    private set(key: number, value: Gtk.Widget) {
        this.map.set(key, value)
        this.notifiy()
    }

    private delete(key: number) {
        this.map.delete(key)
        this.notifiy()
    }

    get() {
        return this.var.get()
    }

    subscribe(callback: (list: Array<Gtk.Widget>) => void) {
        return this.var.subscribe(callback)
    }
}

function NotificationPopups(monitor: number) {
    const notifs = new NotifiationMap()

    return <window
        visible={bind(notifs).as((values) => {
            return values.length !== 0
        })}
        cssClasses={["notifications"]}
        namespace={"notification"}
        monitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={BOTTOM | RIGHT}>
        <box
            vertical={true}>
            {bind(notifs)}
        </box>
    </window>
}

export default NotificationPopups
