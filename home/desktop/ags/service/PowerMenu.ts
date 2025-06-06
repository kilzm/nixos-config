import { exec, GObject, property, register } from "astal";
import { toggleWindow } from "../lib/utils";

export type PowerMenuAction = "shutdown" | "reboot" | "logout" | "sleep"

export const powerMenuActions: PowerMenuAction[] = [
    "shutdown",
    "reboot",
    "logout",
    "sleep",
]

@register()
class _PowerMenuService extends GObject.Object {
    @property(String)
    declare title: string

    @property(String)
    declare cmd: string

    action(action: PowerMenuAction, verify: boolean = true) {
        [this.cmd, this.title] = {
            shutdown: ["shutdown now", "Shutdown"],
            reboot: ["systemctl reboot", "Reboot"],
            logout: ["pkill Hyprland", "Logout"],
            sleep: ["systemctl suspend", "Sleep"],
        }[action]

        this.notify("cmd")
        this.notify("title")
        toggleWindow("powermenu")
        if (verify)
            toggleWindow("verification")
        else
            exec(this.cmd)
    }

    exec() {
        exec(this.cmd)
    }
}

const PowerMenuService = new _PowerMenuService()
export default PowerMenuService
