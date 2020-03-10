<template>
  <div class="map-overlay--container">
    <div class="map-overlay--wrapper">
      <span class="map-overlay--title">{{ ccg.ccg18nm }}</span>
    </div>
    <div class="map-overlay--divider"></div>
    <div class="map-overlay--wrapper">
      <div class="map-overlay--stat-wrapper margin-bottom">
        <span class="map-overlay--stat-label">Free cycles</span>
        <span class="map-overlay--stat" style="font-size: 25px;">{{ ccg.cycles }}</span>
      </div>
      <span class="margin-bottom">{{ ccg.cycle_definition }}</span>
        <span class="map-overlay--stat-label margin-bottom">Ages</span>
        <span class="map-overlay--stat margin-bottom">{{ ccg.age_range }}</span>
        <span class="map-overlay--stat-label margin-bottom">Time trying to conceive</span>
        <span class="map-overlay--stat margin-bottom">{{ ccg.time_trying }}</span>
        <span class="map-overlay--stat-label margin-bottom">Previous children</span>
        <span class="map-overlay--stat">{{ ccg.previous_children }}</span>
      <CloseButton @closed="close"/>
    </div>
  </div>
</template>

<script>

import CloseButton from './CloseButton'

export default {
  components: {
    CloseButton
  },

  props: {
    ccg: { type: Object, required: true },
  },

  methods: {
    close() {
      this.$emit('closed')
    }
  }
}


</script>

<style scoped>
  .map-overlay--container {
    position: fixed;
    z-index: 1;
    left: 0;
    top: 30%;
    /* height: 340px; */
    width: 200px;
    background-color: white;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  }

  .map-overlay--wrapper {
    display: flex;
    flex-direction: column;
    padding: 14px 14px 14px 14px;
  }

  .map-overlay--title {
    font-size: 18px;
    font-weight: bold;
    max-width: 85%;
  }

  .map-overlay--stat-wrapper {
    display: flex;
    justify-content: space-between;
  }

  .map-overlay--stat-label {
    font-size: 14px;
    font-weight: bold;
  }

  .map-overlay--stat {
    font-size: 14px;
  }

  .map-overlay--divider {
    background-color: pink;
    height: 8px;
  }
</style>
