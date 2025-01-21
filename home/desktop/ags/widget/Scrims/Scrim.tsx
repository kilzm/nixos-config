import { Variable } from "astal"
import { App, Astal, hook } from "astal/gtk4"
import { activePopupWindows } from "../../lib/utils"

type ScrimProps = {
    cssClasses?: string[]
}

function Scrim({ cssClasses = [] }: ScrimProps) {
    return (
        <window
            visible={false}
            name={`scrim`}
            namespace={`scrim`}
            layer={Astal.Layer.OVERLAY}
            exclusivity={EXCLUSIVE}
            anchor={TOP | BOTTOM | LEFT | RIGHT}
            keymode={Astal.Keymode.NONE}
            application={App}
            cssClasses={cssClasses}
            setup={(self) => {
                self.add_css_class("scrim")
                hook(self, self, "notify::visible", () => {
                    if (!self.visible) {
                        activePopupWindows().forEach((popup) => {
                            App.toggle_window(popup.name)
                        })
                    }
                })
            }}
        >
        </window>
    )
}

export default Scrim
