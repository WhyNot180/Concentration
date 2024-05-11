<script setup>
import { ref, onMounted } from 'vue'

const msg = ref('Hello World!')

const turns = ref(0)

const time = ref(0)

onMounted(() => {
  setInterval(() => {
    time.value++
  }, 1000)
})

const suit = ["H","S","D","C"]
const rank = ["Jo","A","2","3","4","5","6","7","8","9","10","J","Q","K"]

const cards = ref(cartesianProduct(suit,rank))


function start() {
  shuffle(cards.value)
}

function cartesianProduct(...a) {
  return a.reduce((a, b) => a.flatMap(d => b.map(e => [d, e].flat())))
}

// Fisher-Yates shuffle
function shuffle(array) {
  let currentIndex = array.length;

  // While there remain elements to shuffle...
  while (currentIndex != 0) {

    // Pick a remaining element...
    let randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }
}

</script>

<template>
  <h3>turns: {{ turns }}</h3>
  <h2>{{ time }}</h2>
  <button @click="start">Start</button>
</template>
