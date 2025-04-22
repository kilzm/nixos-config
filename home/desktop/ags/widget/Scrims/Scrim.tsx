import { App, Astal, hook } from "astal/gtk4"
import { activePopupWindows, toggleWindow } from "../../lib/utils"

type ScrimProps = {
    cssClasses?: string[]
}

function Scrim({ cssClasses = [] }: ScrimProps) {
    return (
        <window
            visible={true}
            name={`scrim`}
            namespace={`scrim`}
            layer={Astal.Layer.OVERLAY}
            exclusivity={EXCLUSIVE}
            anchor={TOP | BOTTOM | LEFT | RIGHT}
            keymode={Astal.Keymode.NONE}
            application={App}
            cssClasses={cssClasses}
            setup={(self) => {
                hook(self, self, "notify::visible", () => {
                    if (!self.visible) {
                        activePopupWindows().forEach((popup) => {
                            toggleWindow(popup.name)
                        })
                    }
                })
            }}
            onButtonPressed={(self) => {
                self.set_visible(false)
            }}
        />
    )
}

export default Scrim
