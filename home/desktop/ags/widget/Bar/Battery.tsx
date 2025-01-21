import { bind, Variable } from "astal"
import { Gtk } from "astal/gtk4"
import AstalBattery from "gi://AstalBattery?version=0.1"

function Battery() {
    const battery = AstalBattery.get_default()

    const revealed = Variable(true)

    return (
        <button
            visible={bind(battery, "isPresent")}
            cssClasses={["battery"]}
            onClicked={() => revealed.set(!revealed.get())}
        >
            <box>
                <image iconName={bind(battery, "battery_icon_name")} />
                <revealer revealChild={bind(revealed)} focusable={false} transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}>
                    <label
                        label={bind(battery, "percentage").as(p => `${Math.floor(p * 100)}%`)}
                    />
                </revealer>
            </box>
        </button>
    )
}

export default Battery
