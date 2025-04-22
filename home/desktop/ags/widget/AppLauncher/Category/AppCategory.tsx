import { bind, Variable } from "astal";
import Apps from "gi://AstalApps?version=0.1";
import AppItem from "../AppItem";
import Category from "./Category";
import { Gdk } from "astal/gtk4";

function AppCategory(query: Variable<string>) {
    const apps = new Apps.Apps()
    const appList = bind(query).as(q => q !== "" && /^[a-zA-Z0-9]+$/.test(q[0]) ? apps.fuzzy_query(q)
        .sort((a, b) => apps.fuzzy_score(q, b) - apps.fuzzy_score(q, a))
        .slice(0, 5) : [])

    return <Category
        name={"Applications"}
        action={() => appList.get()[0].launch()}
        hotkey={(key) => {
            const index = key - Gdk.KEY_1
            if (0 <= index && index <= appList.get().length)
                appList.get()[index].launch()
        }}
        child={bind(appList).as((list) => list.map((app, i) => <AppItem app={app} index={i + 1} />))}
    />
}

export default AppCategory
