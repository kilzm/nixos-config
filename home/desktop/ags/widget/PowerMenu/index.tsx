import { ButtonProps } from "astal/gtk4/widget";
import PopupWindow from "../Popup/PopupWindow";
import { App, Gdk } from "astal/gtk4";
import { capitalize, toggleWindow } from "../../lib/utils";
import Icons from "../../lib/icons";
import PowerMenuService, { PowerMenuAction } from "../../service/PowerMenu";
import Verification from "./Verification";

type PowerMenuButtonProps = {
    action: PowerMenuAction
    iconName: string
} & ButtonProps

function PowerMenuButton({ action, iconName }: PowerMenuButtonProps) {
    return (
        <button
            cssClasses={["powermenu-button"]}
            onClicked={() => PowerMenuService.action(action)}>
            <box>
                <image iconName={iconName} />
                <label label={capitalize(action)} />
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
            onKeyPressed={(self, kv) => {
                if (kv == Gdk.KEY_Escape)
                    toggleWindow(self.name)
            }}
        >
            <box vertical cssClasses={["powermenu"]}>
                <box>
                    <PowerMenuButton
                        action={"shutdown"}
                        iconName={Icons.powermenu.shutdown}
                    />
                    <PowerMenuButton
                        action={"reboot"}
                        iconName={Icons.powermenu.reboot}
                    />
                </box>
                <box>
                    <PowerMenuButton
                        action={"logout"}
                        iconName={Icons.powermenu.logout}
                    />
                    <PowerMenuButton
                        action={"sleep"}
                        iconName={Icons.powermenu.sleep}
                    />
                </box>
            </box>
        </PopupWindow>
    )
}

export default PowerMenu
