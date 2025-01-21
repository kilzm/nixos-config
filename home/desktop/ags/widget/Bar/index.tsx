import { App } from "astal/gtk4"
import Clock from "./Clock"
import Workspaces from "./Workspaces"
import AppLauncher from "./AppLauncher"
import SysTray from "./SysTray"
import Media from "./Media"
import PowerMenu from "./PowerMenu"
import Weather from "./Weather"
import Indicators from "./Indicators"
import Battery from "./Battery"

function Expander() {
    return <box hexpand />
}

export default function Bar(monitor: number) {
    return <window
        visible
        namespace={"bar"}
        cssClasses={["bar"]}
        monitor={monitor}
        exclusivity={EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <centerbox
            cssClasses={["bar"]}>
            <box
                hexpand>
                <AppLauncher />
                <Workspaces />
            </box>
            <box
                halign={CENTER}>
                <Clock />
            </box>
            <box
                hexpand>
                <Expander />
                <Media />
                <SysTray />
                <Weather />
                <Indicators />
                <Battery />
                <PowerMenu />
            </box>
        </centerbox>
    </window>
}
