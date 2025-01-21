import Notifd from "gi://AstalNotifd?version=0.1"
import Button from "../Button"
import Icons from "../../../lib/icons"
import { bind } from "astal"

function DNDButton() {
    const notifications = Notifd.get_default()
    return (
        <Button
            name={"dnd"}
            label={bind(notifications, "dontDisturb").as(dnd => dnd ? "Silent" : "Noisy")}
            iconName={bind(notifications, "dontDisturb").as(dnd => Icons.notifications[dnd ? "silent" : "noisy"])}
            connection={[bind(notifications, "dontDisturb"), () => notifications.dontDisturb]}
            onPrimaryClick={() => {
                notifications.dontDisturb = !notifications.dontDisturb
            }}
        />
    )
}

export default DNDButton
