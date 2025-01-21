import Hyprland from "gi://AstalHyprland?version=0.1";
import { range } from "../../lib/utils";
import { hook } from "astal/gtk4";

function Workspaces() {
    const hypr = Hyprland.get_default()

    return (
        <button
            cssClasses={["workspaces"]}
            onClicked={() => {
            }}
        >
            <box>
                {...range(8).map(i => {
                    return <label
                        setup={self => {
                            const update = () => {
                                if (hypr.get_focused_workspace().get_id() === i) {
                                    self.set_css_classes(["focused"])
                                } else {
                                    const ws = hypr.get_workspace(i)
                                    self.set_css_classes(ws && ws.get_clients().length > 0 ? ["used"] : ["unused"])
                                }
                            }
                            hook(self, hypr, "event", update)
                        }}
                    />
                })}
            </box>
        </button>
    )
}

export default Workspaces
