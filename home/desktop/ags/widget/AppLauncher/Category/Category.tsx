import { Binding } from "astal"
import { Gtk } from "astal/gtk4"

type CategoryProps = {
    name: string,
    child: Gtk.Widget | Gtk.Widget[] | Binding<Gtk.Widget> | Binding<Gtk.Widget[]>,
    action: () => void,
    hotkey?: (key: number) => void,
}

function Category({ name, child, action, hotkey }: CategoryProps) {
    const category = (
        <box vertical name={name}>
            <label label={name} halign={START} cssClasses={["category"]} />
            {child}
        </box>
    )

    return Object.assign(category, { action: action, hotkey: hotkey })
}

type Category = {
    action: () => void,
    hotkey?: (key: number) => void,
} & Gtk.Widget

export default Category
