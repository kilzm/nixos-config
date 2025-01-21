import { bind } from "astal"
import Wp from "gi://AstalWp?version=0.1"

function VolumeSlider() {
    const speaker = Wp.get_default()?.defaultSpeaker!
    return (
        <box
            cssClasses={["volume-slider"]}
        >
            <image 
                cssClasses={["icon"]}
                iconName={bind(speaker, "volumeIcon")}
                hexpand={false}
                halign={START}
            />
            <slider
                drawValue={false}
                hexpand
                onChangeValue={(self) => {
                    speaker.volume = self.value
                    speaker.mute = false
                }}
                value={bind(speaker, "volume")}
            />
        </box>
    )
}

export default VolumeSlider
