import { bind } from "astal"
import { App, hook } from "astal/gtk4"
import Tray from "gi://AstalTray?version=0.1"

function SysTray() {
    const tray = Tray.get_default()

    return (
        <box>
            {bind(tray, "items").as((items) => {
                return items
                    .filter((item) => !(item?.title || "").match("spotify|blueman"))
                    .map((item) => {
                        App.add_icons(item.get_icon_theme_path())

                        return (
                            <menubutton
                                tooltipMarkup={bind(item, "tooltip_markup")}
                                menuModel={bind(item, "menu_model")}
                                setup={self => hook(self, item, "notify::action-group", () => self.insert_action_group("dbusmenu", item.action_group))}
                            >
                                <image gicon={bind(item, "gicon")} />
                            </menubutton>
                        )
                    })
            })}
        </box>
    )
}

export default SysTray
