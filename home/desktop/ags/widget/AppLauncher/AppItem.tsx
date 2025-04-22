import { ButtonProps } from "astal/gtk4/widget";
import Apps from "gi://AstalApps?version=0.1";
import { toggleWindow } from "../../lib/utils";
import Item from "./Item";

type AppItemProps = {
    app: Apps.Application,
    index: number,
} & ButtonProps

function AppItem({ app, index }: AppItemProps) {
    return <Item
        title={app.name}
        iconName={app.iconName}
        subtitle={app.description}
        index={index}
        onClicked={() => {
            app.launch()
            toggleWindow("applauncher")
        }}
    />
}

export default AppItem
