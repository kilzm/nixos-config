import { App } from "astal/gtk4"
import Icons from "../../lib/icons"
import { toggleWindow } from "../../lib/utils"

function AppLauncher() {
    return (
        <button
            cssClasses={["applauncher"]}
            onClicked={() => toggleWindow("applauncher")}
        >
            <box>
                <image cssClasses={["nix-icon"]} iconName={Icons.nix.flake} />
                <label label={"Applications"} />
            </box>
        </button>
    )
}

export default AppLauncher
