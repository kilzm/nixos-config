import { LabelProps } from "astal/gtk4/widget";
import Apps from "gi://AstalApps?version=0.1";
import Pango from "gi://Pango?version=1.0";
import { toggleWindow } from "../../lib/utils";

type AppItemProps = {
    app: Apps.Application,
} & LabelProps

function AppItem({ app }: AppItemProps) {
    return (
        <button
            cssClasses={["appbutton"]}
            onClicked={() => {
                app.launch()
                toggleWindow("applauncher")
            }}
        >
            <box>
                <box cssClasses={["icon"]}>
                    <image
                        iconName={app.get_icon_name()}
                    />
                </box>
                <box
                    valign={CENTER}
                    vertical
                >
                    <label
                        cssClasses={["name"]}
                        xalign={0}
                        label={app.get_name()}
                    />
                    {app.get_description() && <label
                        cssClasses={["description"]}
                        wrap
                        hexpand
                        maxWidthChars={30}
                        xalign={0}
                        ellipsize={Pango.EllipsizeMode.END}
                        label={app.get_description()}
                    />}
                </box>
            </box>
        </button>
    )
}

export default AppItem
