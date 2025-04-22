import { GLib } from "astal"
import { Gtk } from "astal/gtk4"
import Notifd from "gi://AstalNotifd"
import Pango from "gi://Pango?version=1.0";
import Icons from "../../lib/icons";

const time = (time: number, format = "%H:%M") => GLib.DateTime
    .new_from_unix_local(time)
    .format(format)!

const urgency = (n: Notifd.Notification) => {
    const { LOW, NORMAL, CRITICAL } = Notifd.Urgency
    switch (n.urgency) {
        case LOW: return "low"
        case CRITICAL: return "critical"
        case NORMAL:
        default: return "normal"
    }
}

type Props = {
    setup(self: Gtk.Box): void
    onHoverLost(self: Gtk.Box): void
    onHover(self: Gtk.Box): void
    notification: Notifd.Notification
    useHistoryCss: boolean
}

export default function Notification(props: Props) {
    const { notification: n, onHoverLost, onHover, setup } = props
    const { START, END } = Gtk.Align

    return <box
        vertical
        cssClasses={["notification"]}
        setup={setup}
        onHoverEnter={onHover}
        onHoverLeave={onHoverLost}
        widthRequest={400}
    >
        <box cssClasses={["header"]}>
            <image cssClasses={["info"]} iconName={Icons.ui.info} />
            <label
                cssClasses={["appname"]}
                halign={START}
                ellipsize={Pango.EllipsizeMode.END}
                label={n.appName || "Unknown"} />
            <label
                cssClasses={["time"]}
                hexpand
                halign={END}
                label={time(n.time)} />
            <button
                cssClasses={["close"]}
                onClicked={() => n.dismiss()}
                label="" />
        </box>
        <box vertical cssClasses={["content"]}>
            <label
                cssClasses={["summary"]}
                halign={START}
                xalign={0}
                wrap
                maxWidthChars={30}
                label={n.summary}
            />
            {n.body && <label
                cssClasses={["body"]}
                halign={START}
                xalign={0}
                wrap
                maxWidthChars={30}
                label={n.body}
            />}
        </box>
        {/* 
        {n.get_actions().length > 0 && <box vertical cssClasses={["actions"]}>
            {n.get_actions().map(({ label, id }) => (
                <button
                    cssClasses={["action"]}
                    hexpand={true}
                    onClicked={() => n.invoke(id)}
                    label={label} />
            ))}
        </box>}
        */}
    </box>
}
