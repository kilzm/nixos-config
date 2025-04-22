import { ButtonProps } from "astal/gtk4/widget";
import PopupWindow from "../Popup/PopupWindow";
import { App, Gdk } from "astal/gtk4";
import { capitalize, toggleWindow } from "../../lib/utils";
import Icons from "../../lib/icons";
import PowerMenuService, { PowerMenuAction, powerMenuActions } from "../../service/PowerMenu";
import Verification from "./Verification";

type PowerMenuButtonProps = {
    action: PowerMenuAction
    index: number
    iconName: string
} & ButtonProps

function PowerMenuButton({ action, index, iconName }: PowerMenuButtonProps) {
    return (
        <button
            cssClasses={["powermenu-button"]}
            onClicked={() => PowerMenuService.action(action)}>
            <box>
                <image iconName={iconName} />
                <label cssClasses={["title"]} label={capitalize(action)} />
                <label cssClasses={["hotkey"]} label={`${index}`} halign={END} hexpand/>
            </box>
        </button>
    )
}

function PowerMenu() {
    Verification()
    return (
        <PopupWindow
            application={App}
            name={"powermenu"}
            namespace={"powermenu"}
            cssClasses={["powermenu"]}
            onKeyPressed={(self, kv, kc, state) => {
                if (kv == Gdk.KEY_Escape) {
                    toggleWindow(self.name)
                    return
                }
                const i = kv - Gdk.KEY_1
                if (0 <= i && i < 4)
                    PowerMenuService.action(powerMenuActions[i], (state & Gdk.KEY_Alt_L) == 0)
            }}
        >
            <box vertical cssClasses={["powermenu"]}>
                <box>
                    <PowerMenuButton
                        index={1}
                        action={"shutdown"}
                        iconName={Icons.powermenu.shutdown}
                    />
                    <PowerMenuButton
                        index={2}
                        action={"reboot"}
                        iconName={Icons.powermenu.reboot}
                    />
                </box>
                <box>
                    <PowerMenuButton
                        index={3}
                        action={"logout"}
                        iconName={Icons.powermenu.logout}
                    />
                    <PowerMenuButton
                        index={4}
                        action={"sleep"}
                        iconName={Icons.powermenu.sleep}
                    />
                </box>
            </box>
        </PopupWindow>
    )
}

export default PowerMenu
