import { App, Gdk, Gtk, hook } from "astal/gtk4"
import PopupWindow from "../Popup/PopupWindow"
import { toggleWindow } from "../../lib/utils"
import { bind, Variable } from "astal"
import Apps from "gi://AstalApps?version=0.1"
import Icons from "../../lib/icons"
import AppItem from "./AppItem"

function AppLauncher() {
    const apps = new Apps.Apps()
    const query = Variable("")

    const list = bind(query).as((query) =>
        query.length === 0
            ? []
            : apps.fuzzy_query(query)
                .sort((a, b) => apps.fuzzy_score(query, b) - apps.fuzzy_score(query, a))
                .slice(0, 8)
    )

    const entry = <entry
        canFocus
        placeholderText={"Search"}
        primaryIconName={Icons.ui.search}
        onNotifyText={(self) => {
            query.set(self.text)
        }}
        onActivate={() => {
            list.get()[0]?.launch()
            toggleWindow("applauncher")
        }}
    />

    const appitems = <box vertical>
        {bind(list).as(list => list.map(app => <AppItem app={app} />))}
    </box>

    return (
        <PopupWindow
            name={"applauncher"}
            namespace={"applauncher"}
            cssClasses={["applauncher"]}
            application={App}
            anchor={TOP}
            setup={(self) => {
                hook(self, self, "notify::visible", () => {
                    (entry as Gtk.Entry).set_text("")
                })
            }}
            onKeyPressed={(self, kv) => {
                if (kv == Gdk.KEY_Escape)
                    toggleWindow("applauncher")
            }}
            onDestroy={() => query.drop()}
        >
            <box vertical>
                <box vertical cssClasses={["applauncher"]}>
                    {entry}
                    {appitems}
                </box>
            </box>
        </PopupWindow>
    )
}

export default AppLauncher
