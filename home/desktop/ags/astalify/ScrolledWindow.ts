import { astalify, ConstructProps, Gtk } from "astal/gtk4";

export type ScrollableWindowProps = ConstructProps<Gtk.ScrolledWindow, Gtk.ScrolledWindow.ConstructorProps>
const ScrolledWindow = astalify<Gtk.ScrolledWindow, Gtk.Calendar.ConstructorProps>(Gtk.ScrolledWindow, { })

export default ScrolledWindow
