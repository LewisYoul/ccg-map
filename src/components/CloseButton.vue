<template>
  <i
    @click="close"
    class="far fa-2x fa-times-circle close-button"
  >
  </i>
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
  .close-button {
    position: absolute;
    top: 5px;
    right: 5px;
    color: lightgrey;
    align-self: flex-end;
  }

  .close-button:hover {
    color: grey;
    cursor: pointer;
  }
</style>
