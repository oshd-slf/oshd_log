import log from "./logfile_srv1.json" assert { type: 'json' };

Vue.createApp({
  data() {
    return {
      logMessages: log
    }
  }
}).mount("#app")
