import { bind } from "astal";
import { favoriteApps } from "../../../lib/variables";
import Category from "./Category";
import Apps from "gi://AstalApps?version=0.1";
import { toggleWindow } from "../../../lib/utils";

function FavoritesCategory() {
    const apps = new Apps.Apps()
    const favorites = <box vertical>
        <box cssClasses={["favorites"]}>
            {bind(favoriteApps).as(favorites => favorites.map(name => {
                const app = apps.exact_query(name).at(0)!
                return <button
                    hexpand
                    iconName={app.iconName}
                    onClicked={() => {
                        app.launch()
                        toggleWindow("applauncher")
                    }}
                    tooltipText={app.name}
                />
            }
            ))}
        </box>
    </box>

    return <Category
        name={"Favorites"}
        action={() => { }}
        child={favorites}
    />
}

export default FavoritesCategory
