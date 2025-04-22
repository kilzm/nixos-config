import { Variable } from "astal";
import PopupWindow from "../Popup/PopupWindow";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import { toggleWindow } from "../../lib/utils";
import MainPage from "./pages/Main";
import MediaWidget from "./items/Media";
import NetworkPage from "./pages/Network";
import BluetoothPage from "./pages/Bluetooth";

export const qspage = Variable("main")

function QuickSettings() {
    return (
        <PopupWindow
            name={"quicksettings"}
            application={App}
            namespace={"quicksettings"}
            cssClasses={["QuickSettings"]}
            layer={Astal.Layer.OVERLAY}
            anchor={TOP | RIGHT}
            onKeyPressed={(self, kv) => {
                if (kv == Gdk.KEY_Escape)
                    if (qspage.get() == "main")
                        toggleWindow(self.name)
                    else
                        qspage.set("main")
            }}
        >
            <box
                cssClasses={["quicksettings"]}
                vertical
                valign={START}
            >
                <box
                    cssClasses={["container"]}
                    valign={START}
                    halign={CENTER}
                >
                    <stack
                        visibleChildName={qspage()}
                        transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
                        transitionDuration={300}
                    >
                        <MainPage />
                        <NetworkPage />
                        <BluetoothPage />
                    </stack>
                </box>
                <MediaWidget />
            </box>
        </PopupWindow>
    )
}

export default QuickSettings
