import { App, Astal, Gtk, hook, Widget } from "astal/gtk4"
import { scrimWindowNames } from "../../lib/variables"
import { activePopupWindows } from "../../lib/utils"

type PopupWindowProps = {
} & Widget.WindowProps

function PopupWindow({
    application = App,
    layer = Astal.Layer.OVERLAY,
    keymode = EXCLUSIVE,
    visible = false,
    child,
    setup,
    cssClasses = [],
    ...props
}: PopupWindowProps) {
    return (
        <window
            cssClasses={cssClasses}
            application={application}
            layer={layer}
            keymode={keymode}
            visible={visible}
            {...props}
            setup={(self) => {
                self.add_css_class("popup")
                scrimWindowNames.set([...scrimWindowNames.get(), self.get_name()])
                hook(self, self, "notify::visible", () => {
                    if (activePopupWindows().length === 0) {
                        const scrimWindow = App.get_window("scrim")
                            scrimWindow?.set_visible(false)
                    }
                })
                if (setup)
                    setup(self)
            }}
        >
            {child}
        </window>
    )
}

export default PopupWindow
