import credentials from "../credentials.json";
import response from "../mock/response.json";

import https from "https";

const api_key: string = credentials["api-key"];

export class ApiHandler {
  static async getForecast(latitude: number, longitude: number) {
    // https.get(
    //   "https://api.openweathermap.org/data/2.5/forecast?lat=" +
    //     latitude +
    //     "&lon=" +
    //     longitude +
    //     "&appid=" +
    //     api_key,
    //   (res) => {
    //        return res;
    //   }
    // );

    var current_date = "";
    var current_index = -1;
    var current_weather = response.list[0];

    var info_day: any = {
      days: [],
    };

    for (var partial of response.list) {
      var date = partial.dt_txt.split(" ")[0];

      if (date !== current_date) {
        current_index += 1;
        current_date = date;
        info_day.days[current_index] = {
          date: current_date,
          min: partial.main.temp_min,
          max: partial.main.temp_max,
          temp: partial.main.temp,
          humidity: partial.main.humidity,
          precipitation: partial.pop,
          wind: partial.wind.speed,
          weather: partial.weather[0].main,
          data: [partial.main.temp],
        };
      } else {
        if (partial.main.temp_min < info_day.days[current_index].min)
          info_day.days[current_index].min = partial.main.temp_min;
        if (partial.main.temp_max > info_day.days[current_index].max)
          info_day.days[current_index].max += partial.main.temp_max;

        info_day.days[current_index].temp += partial.main.temp;
        info_day.days[current_index].humidity += partial.main.humidity;
        info_day.days[current_index].precipitation += partial.pop;
        info_day.days[current_index].wind += partial.wind.speed;
        info_day.days[current_index].data.push(partial.main.temp);
      }
    }

    for (var day in info_day.days) {
      var cnt = info_day.days[day].data.length;
      info_day.days[day].temp /= cnt;
      info_day.days[day].humidity /= cnt;
      info_day.days[day].precipitation /= cnt;
      info_day.days[day].wind /= cnt;

      console.log(info_day.days[day].data);
    }
    return info_day;
  }
}
