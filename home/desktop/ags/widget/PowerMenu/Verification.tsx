import { App, Gdk, hook } from "astal/gtk4";
import PopupWindow from "../Popup/PopupWindow";
import { toggleWindow } from "../../lib/utils";
import PowerMenuService from "../../service/PowerMenu";
import { bind } from "astal";

function Verification() {
    return (
        <PopupWindow
            name={"verification"}
            namespace={"verification"}
            cssClasses={["verification"]}
            onKeyPressed={(self, kv) => {
                if (kv == Gdk.KEY_Escape)
                    toggleWindow(self.get_name())
            }}
        >
            <box vertical cssClasses={["verification"]}>
                <box vertical cssClasses={["text"]}>
                    <label
                        halign={CENTER}
                        cssClasses={["title"]}
                        label={bind(PowerMenuService, "title")}
                    />
                    <label
                        halign={CENTER}
                        cssClasses={["description"]}
                        label={"Are you sure?"}
                    />
                </box>
                <box homogeneous cssClasses={["buttons"]}>
                    <button
                        onClicked={() => {
                            toggleWindow("verification")
                            PowerMenuService.exec()
                        }}
                        setup={(self) => {
                            hook(self, App, (_, name: string, visible: boolean) => {
                                if (name === "verification" && visible)
                                    self.grab_focus()
                            })
                        }}
                        label={"Yes"}
                    />
                    <button
                        onClicked={() => toggleWindow("verification")}
                        label={"No"}
                    />
                </box>
            </box>
        </PopupWindow>
    )
}

export default Verification
