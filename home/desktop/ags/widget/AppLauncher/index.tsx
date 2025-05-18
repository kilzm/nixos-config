import { App, Gdk, Gtk, hook } from "astal/gtk4"
import PopupWindow from "../Popup/PopupWindow"
import { toggleWindow } from "../../lib/utils"
import { bind, Variable } from "astal"
import Icons from "../../lib/icons"
import AppCategory from "./Category/AppCategory"
import CalculatorCategory from "./Category/CalculatorCategory"
import Category from "./Category/Category"
import GoogleCategory from "./Category/GoogleCategory"
import ShellCategory from "./Category/ShellCategory"
import HelpCategory from "./Category/HelpCategory"
import FavoritesCategory from "./Category/FavoritesCategory"

function AppLauncher() {
    const query = Variable("")

    const empty = <box/>
    const help = HelpCategory()
    const apps = AppCategory(query)
    const calculator = CalculatorCategory(query)
    const google = GoogleCategory(query)
    const shell = ShellCategory(query)
    const favorites = FavoritesCategory()

    const active = Variable<Gtk.Widget>(favorites)
    const icon = Variable(Icons.ui.starred)

    query.subscribe(q => {
        if (q === "") {
            active.set(favorites)
            icon.set(Icons.ui.starred)
            return
        }
        switch (q[0]) {
            case '?':
                active.set(help)
                icon.set(Icons.ui.info)
                break
            case '>':
                active.set(shell)
                icon.set(Icons.ui.terminal)
                break
            case '=':
                active.set(calculator)
                icon.set(Icons.ui.calculator)
                break
            case '.':
                active.set(google)
                icon.set(Icons.ui.zen)
                break
            default:
                if (/^[a-zA-Z0-9]$/.test(q[0])) {
                    active.set(apps)
                    icon.set(Icons.ui.apps)
                }
        }
    })

    const stack = (
        <stack
            cssClasses={["content"]}
            visibleChild={active()}
            transitionDuration={200}
            transitionType={Gtk.StackTransitionType.SLIDE_DOWN}
            vhomogeneous={false}
        >
            {empty}
            {help}
            {apps}
            {calculator}
            {google}
            {shell}
            {favorites}
        </stack>
    )

    const entry = <entry
        cssClasses={["query"]}
        placeholderText={"Type something..."}
        primaryIconName={Icons.ui.search}
        secondaryIconName={bind(icon)}
        onNotifyText={(self) => {
            query.set(self.text)
        }}
        onActivate={() => {
            (active.get() as Category).action()
            toggleWindow("applauncher")
        }}
    />

    return (
        <PopupWindow
            name={"applauncher"}
            namespace={"applauncher"}
            cssClasses={["applauncher"]}
            application={App}
            anchor={TOP}
            heightRequest={550}
            setup={(self) => {
                hook(self, self, "notify::visible", () => {
                    (entry as Gtk.Entry).set_text("")
                    entry.grab_focus()
                })
            }}
            onKeyPressed={(_, kv, kc, state) => {
                if (kv == Gdk.KEY_Escape)
                    toggleWindow("applauncher")
                if (state && Gdk.KEY_Alt_L) {
                    (active.get() as Category).hotkey(kv)
                    toggleWindow("applauncher")
                }
            }}
            onDestroy={() => query.drop()}
        >
            <box vertical>
                <box vertical cssClasses={["applauncher"]}>
                    {entry}
                    {stack}
                </box>
            </box>
        </PopupWindow>
    )
}

export default AppLauncher
