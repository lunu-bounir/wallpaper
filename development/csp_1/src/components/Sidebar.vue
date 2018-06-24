<template>
  <div v-click-outside>
    <label><input type="checkbox" v-model="open" v-on:click="open = !open">☰</label>
    <div v-bind:data-open="open" class="slider">
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: 'sidebar',
  data () {
    return {
      open: false
    }
  },
  directives: {
    'click-outside': {
      bind(el, obj, vnode) {
        const onclick = ({target}) => {
          if (el.contains(target) === false){
            vnode.context.open = false;
          }
        }
        document.addEventListener('click', onclick);
        el.destroy = () => document.removeEventListener('click', onclick);
      },
      unbind(el) {
        el.destroy();
      }
    }
  }
}
</script>

<style scoped>
  label {
    cursor: pointer;
    background-color: rgba(37, 37, 37, 0.25);
    color: #ddd;
    display: block;
    position: absolute;
    top: 10px;
    right: 10px;
    padding: 2px 10px;
    font-size: 120%;
  }
  label input {
    display: none;
  }
  .slider {
    background-color: #fff;
    width: 300px;
    position: absolute;
    right: 0;
    top: 0;
    transition: all 300ms ease;
    transition-property: transform, opacity;
    opacity: 0.3;
    transform: translateX(100%);
    border-left: solid 1px #ccc;
    padding: 10px;
    height: calc(100% - 20px);
  }
  .slider[data-open=true] {
    opacity: 1;
    transform: translateX(0);
  }
</style>
