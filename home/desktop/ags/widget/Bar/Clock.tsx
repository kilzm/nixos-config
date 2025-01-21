import { GLib, Variable } from "astal"
import { toggleWindow } from "../../lib/utils"

function Clock() {
    const format = "%a %d %b  %R"
    const time = Variable("").poll(
        1000,
        () => GLib.DateTime.new_now_local().format(format)!,
    )

    return (
        <button
            onClicked={() => toggleWindow("calendar")}
        >
            <label
                cssClasses={["time"]}
                onDestroy={() => time.drop()}
                label={time()}
            />
        </button>
    )
}

export default Clock
