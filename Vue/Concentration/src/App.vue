<script setup>
import { ref } from 'vue'

const msg = ref('Hello World!')

const turns = ref(0)

const time = ref(0)

const cards = ref([{ rank: 1, suit: 0}])

function start() {
  turns.value++
}

</script>

<template>
  <h3>turns: {{ turns }}</h3>
  <h2>{{ time }}</h2>
  <button @click="start">Start</button>
</template>
