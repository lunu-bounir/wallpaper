<template>
  <div
    v-on:click="active = !active; $emit('state', active);"
    v-bind:data-active="active"
    v-bind:style="{width: width + 'px', height: width + 'px'}"
  >
    <svg version="1.1" viewBox="0 0 30 30">
      <path fill="none" stroke="#ddd" d="M22.143,23.365  C20.221,25.008,17.726,26,15,26C8.925,26,4,21.075,4,15" style="stroke-width:2;stroke-linecap:round;stroke-miterlimit:10;"/>
      <path fill="none" stroke="#ddd" d="M7.857,6.635  C9.779,4.992,12.274,4,15,4c6.075,0,11,4.925,11,11" style="stroke-width:2;stroke-linecap:round;stroke-miterlimit:10;"/><polygon points="26,20 22,14 30,14" fill="#ddd"/>
      <polygon points="4,10 8,16 0,16 " fill="#ddd"/>
    </svg>
  </div>
</template>
<script>
export default {
  name: 'refresh',
  props: {
    width: {
      default: 32,
      type: Number
    }
  },
  data () {
    return {
      active: false
    }
  }
}
</script>
<style scoped>

div {
  background-color: rgba(37, 37, 37, 0.25);
  color: #444;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
div svg {
  width: 70%;
}
div[data-active=true] {
  opacity: 0.5;
  pointer-events: none;
}
div[data-active=true] svg {
  pointer-events: none;
  animation: rotate 2s infinite;
}
@keyframes rotate {
  0% {
    transform: rotate(0deg);
  }
  25% {
    transform: rotate(90deg);
  }
  50% {
    transform: rotate(180deg);
  }
  75% {
    transform: rotate(275deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
