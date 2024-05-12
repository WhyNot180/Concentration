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

const cards = ref(cartesianProduct(rank,suit))


function start() {
  shuffle(cards.value)
  turns.value = 0
  time.value = 0
}

function getImageURL(rank,suit) {
  return '/../../Images/Cards/' + rank + suit + '.png'
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
  <div class="mdc-layout-grid--fixed-column-width">
    <div class="mdc-layout-grid__inner">
      <div class="mdc-layout-grid__cell--span-4">
        <span><h3 class="mdc-typography--headline3">Turns: {{ turns }}</h3></span>
      </div>
      <div class="mdc-layout-grid__cell--span-4">
        <span><h2 class="mdc-typography--headline2">{{ time }}</h2></span>
      </div>
      <div class="mdc-layout-grid__cell--span-4">
        <span>
          <button class="mdc-button mdc-button--raised" @click="start">
            <span class="mdc-button__ripple"></span>
            <span class="mdc-button__focus-ring"></span>
            <span class="mdc-button__label">Start</span>
          </button>
        </span>
      </div>
      <div class="mdc-layout-grid__cell--span-12" style="columns:14;">
        <span>
          <ul class="mdc-image-list mdc-image-list--masonry my-masonry-image-list" v-for="card in cards">
            <li class="mdc-image-list__item">
              <img class="mdc-image-list__image" :src="getImageURL(card[0],card[1])" width="90%">
            </li>
          </ul>
        </span>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @use "@material/button/mdc-button";
  @use "@material/layout-grid/mdc-layout-grid";
  @use "@material/typography/mdc-typography";
  @use "@material/image-list";
  
  .my-masonry-image-list {
    list-style-type:none;
  }
</style>