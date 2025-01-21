import { Gtk } from "astal/gtk4"
import FlowBox from "../../../astalify/FlowBox"
import NetworkButton from "../items/Network"
import BluetoothButton from "../items/Bluetooth"
import DNDButton from "../items/DND"
import MicrophoneButton from "../items/Microphone"
import BrightnessSlider from "../items/BrightnessSlider"
import VolumeSlider from "../items/VolumeSlider"
import Icons from "../../../lib/icons"
import PowerMenuService from "../../../service/PowerMenu"

function Header() {
    return (
        <box
            halign={END}
            hexpand
            cssClasses={["header"]}
        >
            <button
                iconName={Icons.powermenu.sleep}
                cssClasses={["hbutton"]}
                onClicked={() => {
                    PowerMenuService.action("sleep")
                }}
            />
            <button
                iconName={Icons.powermenu.logout}
                cssClasses={["hbutton"]}
                onClicked={() => {
                    PowerMenuService.action("logout")
                }}
            />
            <button
                iconName={Icons.powermenu.shutdown}
                cssClasses={["hbutton"]}
                onClicked={() => {
                    PowerMenuService.action("shutdown")
                }}
            />
        </box>
    )
}

function QSMain() {
    const fb = <FlowBox
        name={"main"}
        homogenous
        selectionMode={Gtk.SelectionMode.NONE}
        minChildrenPerLine={2}
        maxChildrenPerLine={2}
        setup={self => self.set_can_focus(false)}
    >
        {NetworkButton()}
        {BluetoothButton()}
        <MicrophoneButton />
        <DNDButton />
    </FlowBox>

    return (
        <box
            name={"main"}
            cssClasses={["main"]}
            vertical
        >
            <Header />
            {fb}
            <box
                cssClasses={["sliders"]}
                vertical
                canFocus={false}
            >
                <VolumeSlider />
                <BrightnessSlider />
            </box>
        </box>
    )
}

export default QSMain
