<template>
  <div>
    <h2>Image</h2>
    <table>
      <tr>
        <td>Width</td>
        <td><input type="number" min="500" max="3000" v-model="image.width"></td>
      </tr>
      <tr>
        <td>Height</td>
        <td><input type="number" min="500" max="3000" v-model="image.height"></td>
      </tr>
      <tr>
        <td>Keywords</td>
        <td><input type="text" v-model="image.keywords"></td>
      </tr>
    </table>
    <h2>Weather</h2>
    <table>
      <tr>
        <td>City ID</td>
        <td><input type="text" v-model="weather.city" placeholder="e.g.: London,uk"></td>
      </tr>
      <tr>
        <td>Position</td>
        <td>
          <div style="display: flex">
            <input type="text" v-model="weather.position.lat" placeholder="Latitude">&nbsp;-&nbsp;
            <input type="text" v-model="weather.position.lon" placeholder="Longitude">
          </div>
        </td>
      </tr>
      <tr>
        <td>ZIP Code</td>
        <td><input type="text" v-model="weather.zip" placeholder="e.g.:94040,us"></td>
      </tr>
      <tr>
        <td>Language</td>
        <td>
          <select v-model="weather.lang">
            <option value="ar">Arabic - ar</option>
            <option value="bg">Bulgarian - bg</option>
            <option value="ca">Catalan - ca</option>
            <option value="cz">Czech - cz</option>
            <option value="de">German - de</option>
            <option value="el">Greek - el</option>
            <option value="en">English - en</option>
            <option value="fa">Persian (Farsi) - fa</option>
            <option value="fi">Finnish - fi</option>
            <option value="fr">French - fr</option>
            <option value="gl">Galician - gl</option>
            <option value="hr">Croatian - hr</option>
            <option value="hu">Hungarian - hu</option>
            <option value="it">Italian - it</option>
            <option value="ja">Japanese - ja</option>
            <option value="kr">Korean - kr</option>
            <option value="la">Latvian - la</option>
            <option value="lt">Lithuanian - lt</option>
            <option value="mk">Macedonian - mk</option>
            <option value="nl">Dutch - nl</option>
            <option value="pl">Polish - pl</option>
            <option value="pt">Portuguese - pt</option>
            <option value="ro">Romanian - ro</option>
            <option value="ru">Russian - ru</option>
            <option value="se">Swedish - se</option>
            <option value="sk">Slovak - sk</option>
            <option value="sl">Slovenian - sl</option>
            <option value="es">Spanish - es</option>
            <option value="tr">Turkish - tr</option>
            <option value="ua">Ukrainian - ua</option>
            <option value="vi">Vietnamese - vi</option>
            <option value="zh_cn">Chinese Simplified - zh_cn</option>
            <option value="zh_tw">Chinese Traditional - zh_tw</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>Units</td>
        <td>
          <select v-model="weather.units">
            <option value="imperial">Imperial</option>
            <option value="metric">Metric</option>
          </select>
        </td>
      </tr>
    </table>
  </div>
</template>

<script type="text/javascript">
export default {
  name: 'preferences',
  props: {
    keywords: {
      default: 'dog, puppy',
      type: String
    }
  },
  watch: {
    image: {
      deep: true,
      handler(o) {
        localStorage.setItem('image.width', Math.min(3000, Math.max(500, o.width)));
        localStorage.setItem('image.height', Math.min(3000, Math.max(500, o.height)));
        localStorage.setItem('image.keywords', o.keywords.split(/\s*,\s*/).join(', '));
      },
    },
    weather: {
      deep: true,
      handler(o) {
        localStorage.setItem('weather.city', o.city);
        localStorage.setItem('weather.position.lan', o.position.lan);
        localStorage.setItem('weather.position.lon', o.position.lon);
        localStorage.setItem('weather.zip', o.zip);
        localStorage.setItem('weather.lang', o.lang);
        localStorage.setItem('weather.units', o.units);
        this.$emit('prefs', 'weather');
      },
    }
  },
  data () {
    return {
      image: {
        width: Number(localStorage.getItem('image.width')) || 1920,
        height: Number(localStorage.getItem('image.height')) || 1200,
        keywords: localStorage.getItem('image.keywords') || this.keywords
      },
      weather: {
        city: localStorage.getItem('weather.city') || '',
        position: {
          lat: localStorage.getItem('weather.position.lat') || '',
          lon: localStorage.getItem('weather.position.lon') || ''
        },
        zip: localStorage.getItem('weather.zip') || '',
        lang: localStorage.getItem('weather.lang') || 'en',
        units: localStorage.getItem('weather.units') || 'imperial'
      }
    }
  }
}
</script>
<style scoped>
  table {
    width:  100%;
  }
  input {
    width: 100%;
    box-sizing: border-box;
  }
  h2 {
    font-size: 180%;
    font-weight: 200;
  }
</style>
