import './assets/main.css'

import { createApp } from 'vue'
import { button, layoutGrid } from 'vue-material-adapter'
import App from './App.vue'

const app = createApp(App)

app.use(button)
app.use(layoutGrid)

app.mount('#app')