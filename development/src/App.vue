<template>
  <div id="app">
    <header>
      <sidebar>
        <preferences ref="prefs" v-bind:keywords="'cat, kitten'" @prefs="prefs"></preferences>
      </sidebar>
    </header>
    <div id="body">
      <weather ref="weather" v-bind:wk="'69b5506c4a7ebeb68bb7f8066e5a7aa1'"></weather>
    </div>
    <footer>
      <refresh v-bind:width="52" @state="button" ref="button"></refresh>
    </footer>
  </div>
</template>

<script>
import Sidebar from './components/Sidebar.vue';
import Preferences from './components/Preferences.vue';
import Refresh from './components/Refresh.vue'
import Weather from './components/Weather.vue'

export default {
  name: 'app',
  created() {
    const s = document.createElement('script');
    s.src = './assets/unsplash-source.js';
    s.onload = () => {
      this.check();
    }
    document.documentElement.appendChild(s);
  },
  components: {
    Sidebar,
    Preferences,
    Refresh,
    Weather
  },
  data() {
    return {
      now: localStorage.getItem('now') || 0
    }
  },
  methods: {
    button() {
      this.renew();
    },
    prefs(val) {
      if (val === 'weather') {
        this.$refs.weather.reset(true);
      }
    },
    url() {
      const o = this.$refs.prefs.image;
      return (new UnsplashPhoto()).all()
         .fromCategory('animals')
         .of(o.keywords.split(', '))
         .size(o.width, o.height)
         .fetch();
    },
    renew() {
      this.$refs.button.active = true;
      fetch(this.url()).then(r => r.blob()).then(blob => {
        const reader = new FileReader();
        reader.onload = () => {
          localStorage.setItem('image.data', reader.result);
          localStorage.setItem('now', Date.now());
          this.display();
          this.$refs.button.active = false;
        };
        reader.readAsDataURL(blob);
      })
    },
    display() {
      const url = localStorage.getItem('image.data') || './assets/default.jpeg';
      document.body.style['background-image'] = `url(${url})`;
    },
    check() {
      this.display();
      if (Date.now() - this.now > 24 * 60 * 60 * 1000) {
        this.renew();
      }
    }
  }
}
</script>

<style type="text/css">
  html {
    height: 100%;
  }
  body {
    overflow-x: hidden;
    font-family: "Helvetica Neue",Helvetica,sans-serif;
    font-size: 13px;
    height: 100%;
    margin: 0;
    background-size: cover;
    background-repeat: no-repeat;
  }
  #app {
    display: flex;
    flex-direction: column;
    height: 100%;
  }
  #body {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
  header,
  footer {
    padding: 10px;
  }
</style>
