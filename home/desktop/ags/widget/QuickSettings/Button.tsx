import { Subscribable } from "astal/binding"
import { Gdk, Gtk, hook, Widget } from "astal/gtk4"
import Icons from "../../lib/icons"
import Pango from "gi://Pango?version=1.0"
import { qspage } from "."

type QSButtonProps = Widget.ButtonProps & {
    menuName?: string
    iconName: Widget.ImageProps["iconName"]
    label?: Widget.LabelProps["label"]
    connection?: [Subscribable<unknown>, () => boolean]
    cssClasses?: string[]
    wide?: boolean
    onPrimaryClick?: (self: Gtk.Widget) => void
}

function QSButton({
    iconName,
    label,
    menuName,
    connection,
    cssClasses,
    wide = false,
    onPrimaryClick,
    ...props
}: QSButtonProps) {
    return (
        <button
            cssClasses={cssClasses}
            onButtonPressed={(self, state) => {
                if (onPrimaryClick && state.get_button() == Gdk.BUTTON_PRIMARY) {
                    onPrimaryClick(self)
                } else if (menuName && state.get_button() == Gdk.BUTTON_SECONDARY) {
                    qspage.set(menuName)
                }
            }}
            setup={self => {
                self.add_css_class("qsbutton")
                if (connection) {
                    let [service, condition] = connection
                    if (condition())
                        self.add_css_class("active")
                    hook(self, service, () => {
                        if (condition())
                            self.add_css_class("active")
                        else
                            self.remove_css_class("active")
                    })
                }
            }}
            {...props}
        >
            <box
                hexpand
            >
                <image iconName={iconName} />
                {label && <label
                    label={label}
                    halign={START}
                    hexpand
                    maxWidthChars={wide ? 25 : 8}
                    ellipsize={Pango.EllipsizeMode.END}
                />}
                {!wide && menuName && <box hexpand={false} halign={END}>
                    <image halign={END} iconName={Icons.ui.right} />
                </box>}
            </box>
        </button>
    )
}

export default QSButton
