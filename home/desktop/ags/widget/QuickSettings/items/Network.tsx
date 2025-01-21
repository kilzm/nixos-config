import Network from "gi://AstalNetwork?version=0.1"
import Button from "../Button"
import { bind, Variable } from "astal"

function NetworkButton(wide: boolean = false) {
    const { wifi } = Network.get_default()
    
    const label = Variable.derive(
        [bind(wifi, "activeConnection"), bind(wifi, "ssid")],
        (connection, ssid) => {
            if (connection) {
                return ssid
            } else
                return "Not Connected"
        },
    )

    return (
        <Button
            name={"network"}
            menuName={"network"}
            iconName={bind(wifi, "iconName")}
            label={label()}
            connection={[bind(wifi, "enabled"), () => wifi.enabled]}
            wide={wide}
            onPrimaryClick={() => {
                if (wifi.enabled) {
                    wifi.enabled = false
                } else {
                    wifi.enabled = true
                    wifi.scan()
                }
            }}
        />
    )
}

export default NetworkButton
