import { defineStore } from "pinia";

export const useDataStore = defineStore("dataStore", {
  state: () => ({
    sharedData: null,
  }),
  actions: {
    setSharedData(data) {
      this.sharedData = data;
    },
    clearSharedData() {
      this.sharedData = null;
    },
  },
  persist: true,
});
