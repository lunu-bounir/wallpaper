<template>
  <div class="root" v-if="enabled" v-bind:title="'Updated on ' + (new Date(now)).toLocaleString()">
    <table>
      <tr>
        <td>↓ {{ main.temp_min}}</td>
        <td>↑ {{ main.temp_max}}</td>
        <td></td>
      </tr>
      <tr class="header">
        <td colspan="2" class="main">{{ main.temp }}°</td>
        <td>
          <span data-id="icon" v-bind:class="['wi', 'wi-owm-' + weather[0].id]"></span>
        </td>
      </tr>
      <tr>
        <td colspan="3">{{weather[0].main}} - {{weather[0].description}}</td>
      </tr>
      <tr>
        <td>Pressure: {{main.pressure}}</td>
        <td>Humidity: {{main.humidity}}</td>
        <td>Wind: {{wind.speed}} @{{wind.deg}}°</td>
      </tr>
    </table>
  </div>
</template>
<script>
  export default {
    props: {
      wk: {
        type: String,
        default: ''
      }
    },
    data() {
      let j = localStorage.getItem('weather.data');
      if (j) {
        j = JSON.parse(j);
      }
      return Object.assign({
        get now() {
          return Number(localStorage.getItem('weather.now') || 0)
        },
        set now(val) {
          localStorage.setItem('weather.now', val);
        },
        get period() {
          return Number(localStorage.getItem('weather.period') || 15);
        },
        get city() {
          return localStorage.getItem('weather.city') || '';
        },
        get zip() {
          return localStorage.getItem('weather.zip') || '';
        },
        get units() {
          return localStorage.getItem('weather.units') || 'imperial';
        },
        position: {
          get lat() {
            localStorage.getItem('weather.position.lat') || '';
          },
          get lot() {
            localStorage.getItem('weather.position.lot') || '';
          }
        },
        get lang() {
          return localStorage.getItem('weather.lang') || 'imperial';
        },
        enabled: false
      }, j && j.weather ? j : {
        weather: [{
          temp: '-'
        }],
        main: {},
        wind: {},
      });
    },
    methods: {
      validate() {
        return {
          p: Boolean(this.city || (this.position.lat && this.position.lot) || this.zip),
          v: Boolean(this.weather[0].main)
        }
      },
      update() {
        let url = 'https://api.openweathermap.org/data/2.5/weather' +
          `?appid=${this.wk}&units=${this.units}&lang=${this.lang}&`;
        if (this.zip) {
          url += `zip=${this.zip}`;
        }
        else if (this.position.lat && this.position.lon) {
          url += `lat=${this.position.lat}&lon=${this.position.lon}`;
        }
        else {
          url += 'q=' + this.city;
        }
        return fetch(url)
          .then(r => r.json())
          .then(weather => {
            localStorage.setItem('weather.data', JSON.stringify(weather));
            this.now = Date.now();
            Object.assign(this, weather);
            this.enabled = true;
          });
      },
      reset(delay = false) {
        console.log('reset');
        const callback = () => {
          window.clearTimeout(this.id);
          const {p, v} = this.validate();
          this.enabled = v && p;
          if (p) {
            console.log('updating');
            this.update().finally(() => {
              this.id = window.setTimeout(callback, this.period * 60 * 1000);
            });
          }
        };
        window.clearTimeout(this.id2);
        this.id2 = window.setTimeout(callback, delay ? 2000 : 0);
      }
    },
    created() {
      this.reset();
    }
  }
</script>
<style scoped>
  .root {
    padding: 10px;
    background-color: rgba(37, 37, 37, 0.25);
    color: #ddd;
    font: 13px/1.3 "Helvetica Neue",Helvetica,Arial,sans-serif;
    font-weight: 100;
  }
  .main {
    font-size: 500%;
  }
</style>
