import { Binding } from "astal"
import { qspage } from "."
import Icons from "../../lib/icons"
import ScrolledWindow from "../../astalify/ScrolledWindow"

type QSPageProps = {
    label: string
    button: JSX.Element
    child?: JSX.Element
    scanning?: Binding<boolean>
    refresh?: () => void
}

function QSPage({
    label,
    child,
    scanning,
    button,
    refresh = undefined,
}: QSPageProps) {
    return (
        <box
            name={label.toLowerCase()}
            cssClasses={["qspage", `${label.toLowerCase()}`]}
            vertical
        >
            <centerbox cssClasses={["header"]} hexpand>
                <button
                    hexpand={false}
                    halign={START}
                    cssClasses={["hbutton"]}
                    onClicked={() => qspage.set("main")}
                    iconName={Icons.ui.left}
                />
                <label
                    halign={CENTER}
                    hexpand
                    label={label}
                />
                {refresh && <button
                    halign={END}
                    cssClasses={["hbutton"]}
                    onClicked={refresh}
                    iconName={Icons.ui.refresh}
                />}
            </centerbox>
            <box cssClasses={["page-button"]}>
                {button}
            </box>
            <ScrolledWindow vexpand cssClasses={["content"]}>
                {child}
            </ScrolledWindow>
        </box>
    )
}

export default QSPage
