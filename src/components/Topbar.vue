<template>
  <div class="topbar--container">
    <h1 style="margin-top: 0px; padding-top: 18px;">Clinical Commissioning Groups</h1>
  </div>
</template>

<script>
export default {
  methods: {
    close() {
      this.$emit('closed')
    }
  }
}


</script>

<style scoped>
  .topbar--container {
    padding-left: 18px;
    position: relative;
    height: 80px;
    background-color: white;
    box-shadow: 0 3px 6px 0 hsla(0,0%,57%,.23);
    z-index: 2;
    text-align: left;
  }
</style>
