import { Binding } from "astal"
import { ButtonProps } from "astal/gtk4/widget"
import Pango from "gi://Pango?version=1.0"

type ItemProps = {
    title: string | Binding<string>,
    iconName: string | Binding<string>,
    subtitle?: string | Binding<string>,
    index?: number,
} & ButtonProps

function Item({ title, iconName, subtitle, index, ...props }: ItemProps) {
    return (
        <button
            setup={(self) => {
                self.add_css_class("item")
            }}
            {...props}
        >
            <box>
                <box cssClasses={["icon"]}>
                    <image
                        iconName={iconName}
                    />
                </box>
                <box
                    valign={CENTER}
                    vertical
                >
                    <label
                        cssClasses={["title"]}
                        label={title}
                        xalign={0}
                    />
                    {subtitle && <label
                        cssClasses={["subtitle"]}
                        wrap
                        hexpand
                        maxWidthChars={25}
                        xalign={0}
                        ellipsize={Pango.EllipsizeMode.END}
                        label={subtitle}
                    />}
                </box>
                {index != undefined && <box cssClasses={["hotkey"]} halign={END} valign={CENTER} hexpand>
                    <label label={`Alt + ${index}`} />
                </box>}
            </box>
        </button>
    )
}

export default Item
