<template>
  <div id="app">
    <Topbar/>
    <Map/>
  </div>
</template>

<script>
import Map from './components/Map.vue'
import Topbar from './components/Topbar.vue'

export default {
  name: 'App',
  components: { Map, Topbar },
}
</script>

<style>
  body {
    margin: 0;
  }
  #app {
    position: relative;
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    height: 100vh;
  }
  
  /* ANIMATIONS */

  .flex-1 { flex: 1 }
  .flex-2 { flex: 2 }
  .flex-3 { flex: 3 }

  .margin-bottom {
    margin-bottom: 6px;
  }
  .slide-enter-active {
    animation: menu-slide .5s;
  }
  .slide-leave-active {
    animation: menu-slide .5s reverse;
  }
  @keyframes menu-slide {
    from {
      transform: translateX(-100%);
    }
    to {
      transform: translateX(0);
    }
  }
</style>
