<script setup>
import { ref } from 'vue'

const msg = ref('Hello World!')

const turns = ref(0)

const time = ref(0)

const suit = [1,2,3,4]
const rank = [0,1,2,3,4,5,6,7,8,9,10,11,12,13]

const cards = ref(cartesianProduct(suit,rank))


function start() {
  turns.value++
}

function cartesianProduct(...a) {
  return a.reduce((a, b) => a.flatMap(d => b.map(e => [d, e].flat())))
}

</script>

<template>
  <h3>turns: {{ turns }}</h3>
  <h2>{{ time }}</h2>
  <button @click="start">Start</button>
</template>
