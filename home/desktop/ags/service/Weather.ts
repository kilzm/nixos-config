import { Variable } from "astal"

const weatherCommand = [
    "curl",
    "https://api.open-meteo.com/v1/forecast?latitude=48.11&longitude=11.66&current=is_day,temperature_2m,weather_code&timezone=Europe%2FBerlin"
]

type Weather = {
    temperature_2m: number,
    weather_code: number,
    is_day: number,
}

export const weather = Variable<Weather>({ temperature_2m: 0, weather_code: 0, is_day: 0 }).poll(
    30_000,
    weatherCommand,
    (out, _) => JSON.parse(out).current,
)
