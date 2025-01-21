import Network from "gi://AstalNetwork?version=0.1"
import QSPage from "../Page"
import { bind, execAsync } from "astal"
import Icons from "../../../lib/icons"
import NetworkButton from "../items/Network"

function NetworkPage() {
    const network = Network.get_default()
    const { wifi, client } = network

    return (
        <QSPage
            label={"Network"}
            refresh={() => wifi.scan()}
            button={NetworkButton(true)}
        >
            <box
                vertical
                cssClasses={["scrollable"]}
            >
                <box vertical>
                    {bind(wifi, "accessPoints").as(points => 
                        points.map(ap => (
                            <button
                                cssClasses={["item"]}
                                onClicked={() => {
                                    execAsync(`nmcli device wifi connect ${ap.bssid}`)
                                }}
                            >
                                <box>
                                    <image iconName={ap.iconName} />
                                    <label label={ap.ssid || "unknown"} />
                                    <image
                                        visible={bind(wifi, "activeAccessPoint").as(aap => ap === aap)}
                                        iconName={Icons.ui.tick}
                                        hexpand
                                        halign={END}
                                    />
                                </box>
                            </button>
                        ))
                    )}
                </box>
            </box>
        </QSPage>
    )
}

export default NetworkPage
