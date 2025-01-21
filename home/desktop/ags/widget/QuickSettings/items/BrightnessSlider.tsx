import { bind } from "astal"
import Wp from "gi://AstalWp?version=0.1"
import Icons from "../../../lib/icons"
import Brightness from "../../../service/Brightness"

function BrightnessSlider() {
    const brightness = Brightness.get_default()!
    return (
        <box
            cssClasses={["brightness-slider"]}
        >
            <image 
                cssClasses={["icon"]}
                iconName={Icons.ui.brightness}
                hexpand={false}
                halign={START}
            />
            <slider
                drawValue={false}
                hexpand
                onChangeValue={(self) => {
                    brightness.screen = self.value
                }}
                value={bind(brightness, "screen").as(b => b)}
            />
        </box>
    )
}

export default BrightnessSlider
