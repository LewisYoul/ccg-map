<template>
  <div @mouseenter="activate" @mouseleave="deactivate" class="container">
    <transition-group name="slide">
      <MapOverlay v-for="(ccg, index) in ccgs" :key="index"
        @closed="unselectCcg"
        :ccg="ccg"
        :position="index + 1"
        ref="ccgOverlays"
      />
    </transition-group>
  </div>
</template>

<script>

import MapOverlay from './MapOverlay'

export default {
  name: 'MapOverlayContainer',

  components: { MapOverlay },

  props: {
    ccgs: { type: Array, required: true },
  },

  data() {
    return {
      active: false
    }
  },

  methods: {
    activate() {
      console.log(this.$children)
      console.log('activate')
      this.$refs.ccgOverlays.map(child => child.activate())
    },

    deactivate() {
      console.log('deactivate')
      this.$refs.ccgOverlays.map(child => child.deactivate())
    },

    unselectCcg(id) {
      console.log('unsel')
      this.$emit('unselectCcg', id)
    }
  }
}


</script>

<style scoped>
  .container {
    position: fixed;
    z-index: 1;
    left: 0;
    top: 30%;
    /* height: 340px; */
    width: 200px;
    background-color: white;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  }
</style>
