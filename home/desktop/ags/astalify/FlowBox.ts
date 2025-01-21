import { astalify, ConstructProps, Gtk } from "astal/gtk4";

export type FlowBoxProps = ConstructProps<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>
const FlowBox = astalify<Gtk.FlowBox, Gtk.Calendar.ConstructorProps>(Gtk.FlowBox, {
    setChildren(self, children) {
        for (const child of children.filter(child => child instanceof Gtk.Widget)) {
            self.append(child)
        }
    }
})

export default FlowBox
