import { timeout, Variable } from "astal"
import { App, Astal, Gtk, hook } from "astal/gtk4"
import Brightness from "../../service/Brightness"
import Wp from "gi://AstalWp?version=0.1"
import Icons from "../../lib/icons"

function OnScreenProgress({ visible }: { visible: Variable<boolean> }) {
    const brightness = Brightness.get_default()
    const speaker = Wp.get_default()!.get_default_speaker()

    const iconName = Variable("")
    const value = Variable(0)

    let count = 0
    function show(v: number, icon: string) {
        visible.set(true)
        value.set(v)
        iconName.set(icon)
        count += 1
        timeout(2000, () => {
            count -= 1
            if (count === 0) visible.set(false)
        })
    }

    return (
        <revealer
            setup={self => {
                hook(self, brightness, "notify::screen", () => show(brightness.screen, Icons.ui.brightness))
                if (speaker) {
                    hook(self, speaker, "notify::volume", () => {
                        show(speaker.volume, speaker.mute ? Icons.audio.volume.muted : speaker.volumeIcon)
                    })
                    hook(self, speaker, "notify::mute", () => {
                        show(speaker.volume, speaker.mute ? Icons.audio.volume.muted : speaker.volumeIcon)
                    })
                }
            }}
            revealChild={true}
            transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
        >
            <box cssClasses={["osd"]}>
                <image iconName={iconName()} />
                <levelbar valign={CENTER} value={value()} />
                <label label={value(v => `${Math.floor(v * 100)}%`)} />
            </box>
        </revealer>
    )
}

function OSD(monitor: number) {
    const visible = Variable(false)
    visible.subscribe((v) => {
        const win = App.get_window("osd")
        if (win) {
            win?.set_visible(v)
        }
    })

    return (
        <window
            application={App}
            name={"osd"}
            namespace={"osd"}
            cssClasses={["osd"]}
            monitor={monitor}
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.ON_DEMAND}
            anchor={BOTTOM}
        >
            <OnScreenProgress visible={visible} />
        </window>
    )
}

export default OSD
