/* eslint-disable max-len */
import options from "options"
import { bash, dependencies } from "lib/utils"
import { colors, special } from "~/.cache/wal/colors.json"
import { font } from "~/.config/agsconfig.json"

const deps = [
    "font",
    "theme",
    "bar.corners",
    "bar.flatButtons",
    "bar.position",
    "bar.battery.charging",
    "bar.battery.blocks",
]

const popoverPaddingMultiplier = 1.6


const $ = (name: string, value: string) => `$${name}: ${value};`


const variables = () => [
    $("bg", special.background),
    $("fg", special.foreground),

    $("primary-bg", colors.color2),
    $("primary-fg", colors.color0),

    $("error-bg", "#AC5859"),
    $("error-fg", "#141414"),

    $("padding", `6pt`),
    $("spacing", `12pt`),
    $("radius", `20px`),
    $("transition", `200ms`),

    $("shadows", `${true}`),

    $("widget-bg", `transparentize(#EEEEEE, ${0.95})`),

    $("hover-bg", `transparentize(#EEEEEE, ${0.85})`),
    $("hover-fg", `lighten(${special.foreground}, 8%)`),

    $("border-width", `1px`),
    $("border-color", `transparentize(#EEEEEE, ${0.95})`),
    $("border", "$border-width solid $border-color"),

    $("active-gradient", `linear-gradient(to right, ${colors.color2}, darken(${colors.color2}, 4%))`),
    $("shadow-color", "rgba(0,0,0,.6)"),
    $("text-shadow", "none"), // "2pt 2pt 2pt $shadow-color"
    $("box-shadow", "2pt 2pt 2pt 0 $shadow-color, inset 0 0 0 $border-width $border-color"),

    $("popover-border-color", `transparentize(#EEEEEE, ${0.95})`),
    $("popover-padding", `$padding * ${popoverPaddingMultiplier}`),
    $("popover-radius", "$radius + $popover-padding"),

    $("font-size", `11pt`),
    $("font-name", `${font} Light`),

    // etc
    $("charging-bg", "#00D787"),
    $("bar-battery-blocks", "7"),
    $("bar-position", "top"),
    $("hyprland-gaps-multiplier", "2.4"),
    $("screen-corner-multiplier", `${0.4}`),
]

async function resetCss() {
    if (!dependencies("sass", "fd"))
        return

    try {
        const vars = `${TMP}/variables.scss`
        const scss = `${TMP}/main.scss`
        const css = `${TMP}/main.css`

        const fd = await bash(`fd ".scss" ${App.configDir}`)
        const files = fd.split(/\s+/)
        const imports = [vars, ...files].map(f => `@import '${f}';`)

        await Utils.writeFile(variables().join("\n"), vars)
        await Utils.writeFile(imports.join("\n"), scss)
        await bash`sass ${scss} ${css}`

        App.applyCss(css, true)
    } catch (error) {
        error instanceof Error
            ? logError(error)
            : console.error(error)
    }
}

Utils.monitorFile(`${App.configDir}/style`, resetCss)
options.handler(deps, resetCss)
await resetCss()
