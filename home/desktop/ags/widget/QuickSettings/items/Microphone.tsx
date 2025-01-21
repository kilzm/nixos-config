import Wp from "gi://AstalWp?version=0.1";
import Button from "../Button";
import { bind } from "astal";
import Icons from "../../../lib/icons";

function MicrophoneButton() {
    const mic = Wp.get_default()?.audio.get_default_microphone()!
    return (<Button
        label={bind(mic, "mute").as(mute => mute ? "Muted" : "Unmuted")}
        iconName={bind(mic, "mute").as(mute => Icons.audio.mic[mute ? "muted" : "high"])}
        connection={[bind(mic, "mute"), () => !mic.mute]}
        onPrimaryClick={() => (mic.mute = !mic.mute)}
    />)
}

export default MicrophoneButton
