import { App } from "astal/gtk4"
import { scrimWindowNames } from "./variables"

export function mod(a: number, b: number) {
    return ((a % b) + b) % b
}

export function range(length: number, start = 1) {
    return Array.from({ length }, (_, i) => i + start)
}

export function capitalize(str: string) {
    return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
}

export function activePopupWindows() {
    const windowNames = scrimWindowNames.get()

    return App.get_windows().filter((window) => windowNames.includes(window.name) && window.visible)
}

export function toggleWindow(windowName: string) {
    const window = App.get_window(windowName)
    if (!window)
        return

    if (window.visible) {
        window.visible = false
    } else {
        activePopupWindows().forEach((win) => {
            win.set_visible(false)
        })
        window.set_visible(true)
    }
}

