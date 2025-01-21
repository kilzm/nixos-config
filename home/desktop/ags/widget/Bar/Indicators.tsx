import Bluetooth from "gi://AstalBluetooth?version=0.1";
import Icons from "../../lib/icons";
import { bind, Variable } from "astal";
import { toggleWindow } from "../../lib/utils";
import Network from "gi://AstalNetwork?version=0.1";
import Notifd from "gi://AstalNotifd?version=0.1";
import Wp from "gi://AstalWp?version=0.1";

function NetworkIndicator() {
    const network = Network.get_default()

    if (!network)
        return <label />
    if (!network.wifi)
        return <image iconName={bind(network.wired, "iconName")} />
    if (!network.wired)
        return <image iconName={bind(network.wifi, "iconName")} />

	const primary = bind(network, "primary");
	const wifiIcon = bind(network.wifi, "iconName");
	const wiredIcon = bind(network.wired, "iconName");

	const icon = Variable.derive(
		[primary, wifiIcon, wiredIcon],
		(primary, iconWifi, iconWired) => {
			if (primary == Network.Primary.WIFI) {
				return iconWifi;
			} else {
				return iconWired;
			}
		},
	)

	return (
		<image
			tooltipText={bind(network.wifi, "ssid").as(String)}
			iconName={bind(icon)}
		/>
	);
    
}

function BluetoothIndicator() {
    const bluetooth = Bluetooth.get_default()
    return (
        <image
            visible={bind(bluetooth, "isPowered")}
            iconName={bind(bluetooth, "isPowered").as(p => Icons.bluetooth[p ? "enabled" : "disabled"])}
        />
    )
}

function MicrophoneIndicator() {
    const mic = Wp.get_default()?.audio.defaultMicrophone!
    return (
        <image
            visible={bind(mic, "mute").as(m => m)}
            iconName={bind(mic, "mute").as(m => Icons.audio.mic[m ? "muted" : "high"])}
        />
    )

}

function AudioIndicator() {
    const speaker = Wp.get_default()?.defaultSpeaker!
    return (
        <image iconName={bind(speaker, "volumeIcon")} />
    )
}

function DNDIndicator() {
    const notifications = Notifd.get_default()
    return (
        <image
            visible={bind(notifications, "dontDisturb").as(d => d)}
            iconName={bind(notifications, "dontDisturb").as(d => Icons.notifications[d ? "silent" : "noisy"])}
        />
    )
}

function Indicators() {
    return (
        <button
            cssClasses={["indicators"]}
            onClicked={() => toggleWindow("quicksettings")}
        >
            <box>
                <NetworkIndicator />
                <BluetoothIndicator />
                <DNDIndicator />
                <MicrophoneIndicator />
                <AudioIndicator />
            </box>
        </button>
    )
}

export default Indicators
