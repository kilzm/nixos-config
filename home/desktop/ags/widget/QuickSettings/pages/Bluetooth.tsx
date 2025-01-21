import QSPage from "../Page"
import { bind, execAsync, timeout } from "astal"
import Icons from "../../../lib/icons"
import Bluetooth from "gi://AstalBluetooth?version=0.1"
import BluetoothButton from "../items/Bluetooth"

type DeviceItemProps = {
    device: Bluetooth.Device
}


function BluetoothPage() {
    const bluetooth = Bluetooth.get_default()

    function DeviceItem({ device }: DeviceItemProps) {
        return (
            <button
                cssClasses={["item"]}
                onClicked={() => {
                    if (!bluetooth.isPowered)
                        bluetooth.toggle()
                    timeout(100, () => device.connect_device(() => {}))
                }}
            >
                <box>
                    <image iconName={`${device.icon}-symbolic`} />
                    <label label={device.name} />
                    <image
                        visible={bind(device, "connected")}
                        iconName={Icons.ui.tick}
                        hexpand
                        halign={END}
                    />
                </box>
            </button>
        )
    }

    return (
        <QSPage
            label={"Bluetooth"}
            button={BluetoothButton(true)}
        >
            <box
                vertical
                cssClasses={["scrollable"]}
            >
                <box vertical>
                    {bind(bluetooth, "devices").as(devices => 
                        devices.map(device => <DeviceItem device={device} />)
                    )}
                </box>
            </box>
        </QSPage>
    )
}

export default BluetoothPage
