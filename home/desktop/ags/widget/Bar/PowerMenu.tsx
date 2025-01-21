import Icons from "../../lib/icons"
import { toggleWindow } from "../../lib/utils"

function PowerMenu() {
    return (
        <button
            cssClasses={["powermenu"]}
            onClicked={() => { toggleWindow("powermenu") }}>
            <image iconName={Icons.ui.menu}/>
        </button>
    )
}

export default PowerMenu
