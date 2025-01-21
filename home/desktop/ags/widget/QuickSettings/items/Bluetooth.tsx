import Bluetooth from "gi://AstalBluetooth?version=0.1"
import Button from "../Button"
import { bind } from "astal"
import Icons from "../../../lib/icons"

function BluetoothButton(wide: boolean = false) {
    const bluetooth = Bluetooth.get_default()
    return (
        <Button
            name={"bluetooth"}
            menuName={"bluetooth"}
            iconName={bind(bluetooth, "isPowered").as(p => Icons.bluetooth[p ? "enabled" : "disabled"])}
            label={bind(bluetooth, "isConnected").as(connected => {
                if (!connected)
                    return "Bluetooth"
                const devices = bluetooth.get_devices()
                const connectedDevices = devices.filter(device => device.connected)
                return connectedDevices[0].name || "Bluetooth"
            })}
            connection={[bind(bluetooth, "isPowered"), () => bluetooth.isPowered]}
            wide={wide}
            onPrimaryClick={() => bluetooth.toggle()}
        />
    )
}

export default BluetoothButton
