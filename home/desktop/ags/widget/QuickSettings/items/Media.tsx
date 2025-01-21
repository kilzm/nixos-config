import { bind, timeout, Variable } from "astal"
import { App, Gtk, hook } from "astal/gtk4"
import Mpris from "gi://AstalMpris?version=0.1"
import { mod } from "../../../lib/utils"
import Icons from "../../../lib/icons"
import Pango from "gi://Pango?version=1.0"

function Player({ player }: { player: Mpris.Player }) {
    function Title() {
        return <label
            label={bind(player, "title")}
            maxWidthChars={30}
            ellipsize={Pango.EllipsizeMode.END}
            cssClasses={["title"]}
            halign={START}
        />
    }

    function Artist() {
        return <label
            label={bind(player, "artist")}
            maxWidthChars={30}
            cssClasses={["artist"]}
            halign={START}
        />
    }

    function Slider() {
        return (
            <slider
                cssClasses={["slider"]}
                drawValue={false}
                hexpand
                value={bind(player, "position").as(p => player.length > 0 ? p / player.length : 0)}
                onChangeValue={self => { player.position = self.value * player.length }}
            />
        )
    }

    function Controls() {
        return (
            <box
                halign={CENTER}
            >
                {player.canGoPrevious && <button
                    iconName={Icons.media.previous}
                    onClicked={() => player.previous()}
                />}
                <button 
                    iconName={bind(player, "playbackStatus").as(s => Icons.media[s == Mpris.PlaybackStatus.PLAYING ? "pause" : "play"])}
                    onClicked={() => player.play_pause()}
                />
                {player.canGoNext && <button
                    iconName={Icons.media.next}
                    onClicked={() => player.next()}
                />}
            </box>
        )
    }

    function setCoverCss() {
        if (player.coverArt) {
            App.apply_css(`
                window.QuickSettings .quicksettings .media .player-${player.busName.replaceAll(".", "-")} {
                    background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url("file://${player.coverArt}");
            }`)
        }
    }

    return (
        <box
            name={player.busName}
            cssClasses={["player", `player-${player.busName.replaceAll(".", "-")}`]}
            vertical
            hexpand
            setup={self => {
                setCoverCss()
                hook(self, player, "notify::cover-art", setCoverCss)
            }}
        >
            <box vexpand valign={START}> </box>
            <box
                hexpand
                vexpand
                valign={CENTER}
            >
                <box
                    halign={START}
                    vertical
                    vexpand
                    valign={CENTER}
                    cssClasses={["title-box"]}
                >
                    <Title />
                    <Artist />
                </box>
            </box>
            <Slider />
            <Controls />
        </box>
    )
}


function PlayerSwitcher({ mpris, selectedPlayer }: { mpris: Mpris.Mpris, selectedPlayer: Variable<string> }) {
    const players = bind(mpris, "players")

    function changePlayer(direction: number) {
        const allPlayers = mpris.get_players()
        const index = allPlayers.findIndex(p => p.busName === selectedPlayer.get())
        selectedPlayer.set(allPlayers[mod(index + direction, allPlayers.length)].busName)
    }

    return (
        <revealer revealChild={players.as(p => p.length > 0)}>
            <overlay>
                <box
                    cssClasses={["media"]}
                    onScroll={(_, dx, dy) => {
                        if (dy > 0.125)
                            changePlayer(1)
                        else if (dy < -0.125)
                            changePlayer(-1)
                    }}
                >
                    <stack
                        transitionType={Gtk.StackTransitionType.SLIDE_UP_DOWN}
                        transitionDuration={300}
                        interpolateSize
                        visibleChildName={bind(selectedPlayer)}
                        setup={self => {
                            players.get().forEach(p => {
                                self.add_named(<Player player={p} />, p.busName)
                            })
                            mpris.connect("player-added", (_, p) => {
                                self.add_named(<Player player={p} />, p.busName)
                            })
                            mpris.connect("player-closed", (_, p) => {
                            })
                        }}
                    />
                </box>
            </overlay>
        </revealer>
    )

}

function MediaWidget() {
    const mpris = Mpris.get_default()
    const player = Variable<string>("")

    return <PlayerSwitcher mpris={mpris} selectedPlayer={player} />
}

export default MediaWidget
