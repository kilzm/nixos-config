import { App, Astal, Gdk, Gtk, Widget } from "astal/gtk4"
import PopupWindow from "../Popup/PopupWindow"
import { mod, toggleWindow } from "../../lib/utils"
import { getCalendarLayout } from "./Layout"
import Icons from "../../lib/icons"
import { bind, Variable } from "astal"

const date = Variable<Date>(new Date())
const calendarJson = bind(date).as(d => getCalendarLayout(d, true))

function shiftDate(n: number) {
    if (n === 0) {
        date.set(new Date())
    } else {
        var targetMonth = date.get().getMonth() + n
        var targetYear = date.get().getFullYear() + Math.floor(targetMonth / 12)
        targetMonth = mod(targetMonth, 12)

        date.set(new Date(targetYear, targetMonth, 1))
    }
}
const weekDays: { day: string, today: number }[] = [
    { day: "Mo", today: 0 },
    { day: "Tu", today: 0 },
    { day: "We", today: 0 },
    { day: "Th", today: 0 },
    { day: "Fr", today: 0 },
    { day: "Sa", today: 0 },
    { day: "Su", today: 0 },
]

function CalendarDay(day: string, today: number) {
    return (
        <button
            cssClasses={["day"]}
            onClicked={() => {
                const d = parseInt(day)
                if (!d) return
                if (today == -1) {
                    if (d > 15)
                        shiftDate(-1)
                    else
                        shiftDate(1)
                }
                const year = date.get().getFullYear()
                const month = date.get().getMonth()
                date.set(new Date(year, month, parseInt(day)))
            }}
            setup={self => {
                if (today == 1) {
                    self.add_css_class("today")
                } else if (today == -1) {
                    self.add_css_class("other-month")
                }
            }}
        >
            <box halign={CENTER}>
                <label label={`${day}`} />
            </box>
        </button>
    )
}

function CalendarHeader() {
    return (
        <centerbox
            cssClasses={["header"]}
            hexpand
        >
            <button
                label={bind(date).as(d => `${d.toLocaleString("default", { month: "long" })} ${d.getFullYear()}`)}
                onClicked={() => date.set(new Date())}
            />
            <label />
            <box
                cssClasses={["controls"]}
            >
                <button
                    onClicked={() => shiftDate(-1)}
                    iconName={Icons.ui.up}
                />
                <button
                    onClicked={() => shiftDate(1)}
                    iconName={Icons.ui.down}
                />
            </box>
        </centerbox>
    )
}

function CalendarDays() {
    return (
        bind(calendarJson).as(c => (
            <box
                vertical
                hexpand
                setup={self => {
                    bind
                    self.set_children(c.map(
                        row => (
                            <box>
                                {row.map(day => CalendarDay(day.day, day.today))}
                            </box>
                        )
                    ))
                }}
            >
            </box>
        ))
    )
}

function Calendar() {
    return (
        <PopupWindow
            application={App}
            name={"calendar"}
            namespace={"calendar"}
            cssClasses={["Calendar"]}
            anchor={TOP}
            onKeyPressed={(self, kv) => {
                if (kv == Gdk.KEY_Escape)
                    toggleWindow(self.name)
            }}
        >
            <box
                cssClasses={["calendar"]}
                vertical
            >
                <CalendarHeader />
                <box
                    cssClasses={["grid"]}
                    vertical
                    halign={CENTER}
                    valign={CENTER}
                >
                    <box
                        cssClasses={["weekdays"]}
                    >
                        {weekDays.map(day => CalendarDay(day.day, day.today))}
                    </box>
                    {CalendarDays()}
                </box>
            </box>
        </PopupWindow>
    )
}

export default Calendar

