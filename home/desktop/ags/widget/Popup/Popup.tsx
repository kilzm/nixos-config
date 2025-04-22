import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import { WindowProps } from "astal/gtk4/widget";

function Padding({ winName }: { winName: string }) {
    return (
        <button
            cssClasses={["button-padding"]}
            canFocus={false}
            onClicked={() => App.toggle_window(winName)}
            hexpand
            vexpand
        />
    );
}

function Layout({
    child,
    name,
    position,
}: {
    child?: JSX.Element;
    name: string;
    position: string;
}) {
    switch (position) {
        case "top":
            return (
                <box vertical>
                    {child}
                    <Padding winName={name} />
                </box>
            );
        case "top_center":
            return (
                <box>
                    <Padding winName={name} />
                    <box vertical hexpand={false}>
                        {child}
                        <Padding winName={name} />
                    </box>
                    <Padding winName={name} />
                </box>
            );
        case "top_left":
            return (
                <box>
                    <box vertical hexpand={false}>
                        {child}
                        <Padding winName={name} />
                    </box>
                    <Padding winName={name} />
                </box>
            );
        case "top_right":
            return (
                <box>
                    <Padding winName={name} />
                    <box vertical hexpand={false}>
                        {child}
                        <Padding winName={name} />
                    </box>
                </box>
            );
        case "bottom":
            return (
                <box vertical>
                    <Padding winName={name} />
                    {child}
                </box>
            );
        case "bottom_center":
            return (
                <box>
                    <Padding winName={name} />
                    <box vertical hexpand={false}>
                        <Padding winName={name} />
                        {child}
                    </box>
                    <Padding winName={name} />
                </box>
            );
        case "bottom_left":
            return (
                <box>
                    <box vertical hexpand={false}>
                        <Padding winName={name} />
                        {child}
                    </box>
                    <Padding winName={name} />
                </box>
            );
        case "bottom_right":
            return (
                <box>
                    <Padding winName={name} />
                    <box vertical hexpand={false}>
                        <Padding winName={name} />
                        {child}
                    </box>
                </box>
            );
        case "center":
        default:
            return (
                <centerbox>
                    <Padding winName={name} />
                    <centerbox orientation={Gtk.Orientation.VERTICAL}>
                        <Padding winName={name} />
                        {child}
                        <Padding winName={name} />
                    </centerbox>
                    <Padding winName={name} />
                </centerbox>
            );
    }
}

type PopupProps = WindowProps & {
    child?: unknown;
    name: string;
    visible?: boolean;
    animation?: string;
    layout?: string;
};

export default function Popup({
    child,
    name,
    visible,
    layout = "center",
    ...props
}: PopupProps) {
    return (
        <window
            visible={visible ?? false}
            name={name}
            namespace={name}
            layer={Astal.Layer.TOP}
            keymode={EXCLUSIVE}
            application={App}
            anchor={TOP | BOTTOM | RIGHT | LEFT}
            onKeyPressed={(_, keyval) => {
                if (keyval === Gdk.KEY_Escape) {
                    App.toggle_window(name);
                }
            }}
            {...props}
        >
            <Layout name={name} position={layout}>
                {child}
            </Layout>
        </window>
    );
}
