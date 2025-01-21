import "./globals"
import { App } from "astal/gtk4"
import style from "./style.scss"
import Bar from "./widget/Bar"
import Scrim from "./widget/Scrims/Scrim"
import { toggleWindow } from "./lib/utils"
import PowerMenu from "./widget/PowerMenu"
import AppLauncher from "./widget/AppLauncher"
import { GLib } from "astal"
import OSD from "./widget/OSD"
import Calendar from "./widget/Calendar"
import QuickSettings from "./widget/QuickSettings"

App.start({
    css: style,
    icons: "./icons",
    main: () => {
        GLib.setenv("LD_PRELOAD", "", true)

        Scrim({cssClasses: ["scrim"]})
        Bar(0)
        OSD(0)
        Calendar()
        AppLauncher()
        PowerMenu()
        QuickSettings()
    },
    requestHandler: (request: string, res: (response: any) => void) => {
        const args = request.split(" ")
        switch (args[0]) {
            case "toggle":
                toggleWindow(args[1])
                res("ok")
                break
            default:
                res("unknown command")
        }
    }
})
