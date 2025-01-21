import { bind, exec, execAsync } from "astal"
import { weather } from "../../service/Weather"

function Weather() {
    return (
        <button
            cssClasses={["weather"]}
            onClicked={() => {
                execAsync("gnome-weather")
            }}
        >
            <box>
                <label
                    cssClasses={["icon"]}
                    label={bind(weather).as(w => SYMBOLS[w.weather_code][w.is_day])} />
                <label
                    cssClasses={["temperature"]}
                    label={bind(weather).as(w => w && `${Math.round(w?.temperature_2m || 0)}°`)} />
            </box>
        </button>
    )
}

const SYMBOLS: {
    [code: number]: [night: string, day: string]
} = {
    0: ["🌙", "☀️"],
    1: ["☁️", "🌤️"],
    2: ["☁️", "⛅"],
    3: ["☁️", "⛅"],
    45: ["☁️", "☁️"],
    48: ["☁️", "☁️"],
    51: ["☁️", "☁️"],
    53: ["☁️", "☁️"],
    55: ["☁️", "☁️"],
    56: ["☁️", "☁️"],
    57: ["☁️", "☁️"],
    61: ["🌧️", "🌦️"],
    63: ["🌧️", "🌧️"],
    65: ["☔", "☔"],
    66: ["🌧️", "🌧️"],
    67: ["☔", "☔"],
    71: ["🌨️", "🌨️"],
    73: ["🌨️", "🌨️"],
    75: ["🌨️", "🌨️"],
    77: ["🌨️", "🌨️"],
    80: ["🌧️", "🌧️"],
    81: ["🌧️", "🌧️"],
    82: ["🌧️", "🌧️"],
    85: ["🌨️", "🌨️"],
    86: ["🌨️", "🌨️"],
    95: ["🌩️", "🌩️"],
    96: ["🌩️", "🌩️"],
    99: ["🌩️", "🌩️"],
}

export default Weather
