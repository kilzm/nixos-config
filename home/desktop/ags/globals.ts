import { Astal, Gtk } from "astal/gtk4"

declare global {
    // Align
    const START: number
    const CENTER: number
    const END: number
    const FILL: number
    // Exclusivity
    const NORMAL: number
    const EXCLUSIVE: number
    const IGNORE: number
    // Anchor
    const TOP: number
    const BOTTOM: number
    const LEFT: number
    const RIGHT: number
}

Object.assign(globalThis, {
    START: Gtk.Align.START,
    CENTER: Gtk.Align.CENTER,
    END: Gtk.Align.END,
    FILL: Gtk.Align.FILL,
    EXCLUSIVE: Astal.Exclusivity.EXCLUSIVE,
    NORMAL: Astal.Exclusivity.NORMAL,
    IGNORE: Astal.Exclusivity.IGNORE,
    TOP: Astal.WindowAnchor.TOP,
    BOTTOM: Astal.WindowAnchor.BOTTOM,
    LEFT: Astal.WindowAnchor.LEFT,
    RIGHT: Astal.WindowAnchor.RIGHT,
})
