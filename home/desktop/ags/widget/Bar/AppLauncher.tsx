import { App } from "astal/gtk4"
import Icons from "../../lib/icons"

function AppLauncher() {
    return (
        <button
            cssClasses={["applauncher"]}
            onClicked={() => App.toggle_window("applauncher")}
        >
            <box>
                <image cssClasses={["nix-icon"]} iconName={Icons.nix.flake} />
                <label label={"Applications"} />
            </box>
        </button>
    )
}

export default AppLauncher
