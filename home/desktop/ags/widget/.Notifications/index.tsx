import { GLib } from "astal";
import { Box } from "astal/gtk4/widget";
import { Gtk } from "astal/gtk4";
import Notifd from "gi://AstalNotifd?version=0.1";
import Pango from "gi://Pango?version=1.0";

const isIcon = (icon: string) => new Gtk.IconTheme().has_icon(icon)

const fileExists = (path: string) => GLib.file_test(path, GLib.FileTest.EXISTS)

const time = (time: number) => GLib.DateTime.new_from_unix_local(time).format("%H:%M")!

const urgency = (n: Notifd.Notification) => {
    const { LOW, NORMAL, CRITICAL } = Notifd.Urgency;

    switch (n.urgency) {
        case LOW: return "low";
        case CRITICAL: return "critical";
        case NORMAL:
        default: return "normal";
    }
}



function Notification({ n, showActions = true }: { n: Notifd.Notification, showActions?: boolean }) {
    return (
        <box
            name={n.id.toString()}
            cssClasses={["notification", urgency(n)]}
            hexpand={false}
            vexpand={false}
            widthRequest={300}
            heightRequest={100}
        >
            {false && <box vertical>
                <box cssClasses={["header"]}>
                    {(n.appIcon || n.desktopEntry) && (
                        <image
                            cssClasses={["app-icon"]}
                            visible={!!(n.appIcon || n.desktopEntry)}
                            iconName={n.appIcon || n.desktopEntry}
                        />
                    )}
                    <label
                        cssClasses={["app-name"]}
                        halign={Gtk.Align.START}
                        label={n.appName || "Unknown"}
                    />
                    <label
                        cssClasses={["time"]}
                        hexpand
                        halign={Gtk.Align.END}
                        label={time(n.time)}
                    />
                </box>
                <Gtk.Separator visible orientation={Gtk.Orientation.HORIZONTAL} />
                <box cssClasses={["content"]}>
                    {n.image && fileExists(n.image) && (
                        <box valign={Gtk.Align.START} cssClasses={["image"]}>
                            <image file={n.image} overflow={Gtk.Overflow.HIDDEN} />
                        </box>
                    )}
                    {n.image && isIcon(n.image) && (
                        <box cssClasses={["icon-image"]} valign={Gtk.Align.START}>
                            <image
                                iconName={n.image}
                                halign={Gtk.Align.CENTER}
                                valign={Gtk.Align.CENTER}
                            />
                        </box>
                    )}
                    <box hexpand vertical>
                        <label
                            ellipsize={Pango.EllipsizeMode.END}
                            maxWidthChars={30}
                            cssClasses={["summary"]}
                            halign={Gtk.Align.START}
                            xalign={0}
                            label={n.summary}
                        />
                        {n.body && (
                            <label
                                cssClasses={["body"]}
                                maxWidthChars={40}
                                halign={Gtk.Align.START}
                                xalign={0}
                                label={n.body}
                            />
                        )}
                    </box>
                </box>
                {false && showActions && n.get_actions().length > 0 && (
                    <box cssClasses={["actions"]}>
                        {n.get_actions().map(({ label, id }) => (
                            <button hexpand onClicked={() => n.invoke(id)}>
                                <label label={label} halign={Gtk.Align.CENTER} hexpand />
                            </button>
                        ))}
                    </box>
                )}
            </box>}
        </box>
    )
}

export default Notification
