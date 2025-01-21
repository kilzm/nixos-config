import { bind, timeout, Variable } from "astal"
import { Gdk, Gtk, hook } from "astal/gtk4"
import Icons from "../../lib/icons"
import Mpris from "gi://AstalMpris?version=0.1"
import Pango from "gi://Pango?version=1.0"

function Media() {
    const spotify = Mpris.Player.new("spotify")

    const revealed = Variable(false)
    const toggle = Variable(false)

    return (
        <button
            cssClasses={["media"]}
            onButtonPressed={(_, event) => {
                switch (event.get_button()) {
                    case Gdk.BUTTON_PRIMARY:
                        spotify.play_pause()
                        break
                    case Gdk.BUTTON_MIDDLE:
                        toggle.set(!toggle.get())
                        break
                }
            }}
            onScroll={(_, dx, dy) => {
                if (dy < -.125)
                    spotify.next()
                else if (dy > .125)
                    spotify.previous()
            }}
            onHoverEnter={() => { revealed.set(true) }}
            onHoverLeave={() => { revealed.set(toggle.get()) }}
            onDestroy={() => {
                revealed.drop()
                toggle.drop()
            }}
        >
            <box>
                <revealer
                    revealChild={bind(revealed)}
                    focusable={false}
                    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
                    setup={(self) => {
                        var trackid = ""
                        hook(self, spotify, "notify", () => {
                            if (trackid === spotify.get_trackid())
                                return
                            trackid = spotify.get_trackid()
                            revealed.set(true)
                            timeout(3500, () => { revealed.set(toggle.get()) })
                        })
                    }}
                >
                    <label
                        label={bind(spotify, "metadata").as(() => `${spotify.artist} - ${spotify.title}`)}
                        maxWidthChars={40}
                        ellipsize={Pango.EllipsizeMode.END}
                    />
                </revealer>
                <image iconName={Icons.media.spotify} />
            </box>
        </button>
    )
}

export default Media
