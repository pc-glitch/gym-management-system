<template>
  <div class="media-player-container">
    <div class="player-display-area">
      <div v-if="isLoading" class="loading-overlay">
        <div class="spinner"></div>
        <p>媒体加载中...</p>
      </div>

      <video
        v-if="currentMediaType === 'video'"
        :key="currentSource"
        ref="videoPlayerRef"
        :src="currentSource"
        class="video-player"
        controls
        @loadedmetadata="handleMediaLoaded"
        @timeupdate="updateProgress"
        @play="isPlaying = true"
        @pause="isPlaying = false"
        @ended="handleNextTrack"
      ></video>

      <div v-if="currentMediaType === 'audio'" class="audio-player-ui">
        <div class="album-art">
          <div class="music-icon"></div>
        </div>
        <h3 class="track-title">{{ currentTrackName }}</h3>
        <div class="progress-bar-container" @click="seek">
          <div class="progress-bar" :style="{ width: progress + '%' }"></div>
        </div>
        <div class="time-display">
          <span>{{ formattedCurrentTime }}</span>
          <span>{{ formattedDuration }}</span>
        </div>
        <div class="controls">
          <button class="control-button" @click="handlePrevTrack">
            <span class="prev-icon"></span>
          </button>
          <button class="control-button play-pause" @click="togglePlayPause">
            <span v-if="!isPlaying" class="play-icon"></span>
            <span v-else class="pause-icon"></span>
          </button>
          <button class="control-button" @click="handleNextTrack">
            <span class="next-icon"></span>
          </button>
        </div>
      </div>

      <div
        v-if="currentMediaType === 'unknown' && !isLoading"
        class="unknown-media"
      >
        <div class="unknown-icon">?</div>
        <p>不支持的媒体格式</p>
      </div>

      <audio
        ref="audioPlayerRef"
        :src="currentSource"
        style="display: none"
        @loadedmetadata="handleMediaLoaded"
        @timeupdate="updateProgress"
        @play="isPlaying = true"
        @pause="isPlaying = false"
        @ended="handleNextTrack"
      ></audio>
    </div>

    <div class="playlist-area">
      <h4 class="playlist-title">播放列表</h4>
      <ul class="playlist">
        <li
          v-for="(source, index) in playlistSources"
          :key="source"
          class="playlist-item"
          :class="{ active: index === currentTrackIndex }"
          @click="playTrack(index)"
        >
          <span class="track-number">{{ index + 1 }}</span>
          <span class="track-name">{{ getTrackName(source) }}</span>
          <div
            v-if="index === currentTrackIndex && isPlaying"
            class="playing-indicator"
          >
            <span></span><span></span><span></span>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from "vue";

const props = defineProps({
  sources: {
    type: String,
    required: true,
    default: "",
  },
});

const videoPlayerRef = ref(null);
const audioPlayerRef = ref(null);

const currentTrackIndex = ref(0);
const isPlaying = ref(false);
const isLoading = ref(true);
const currentTime = ref(0);
const duration = ref(0);
const progress = ref(0);

const playlistSources = computed(() => {
  if (!props.sources || typeof props.sources != "string") {
    return [];
  }
  return props.sources.split(",").filter((s) => s.trim() != "");
});

const currentSource = computed(
  () => playlistSources.value[currentTrackIndex.value] || ""
);

const currentMediaType = computed(() => {
  if (!currentSource.value) return "unknown";
  const extension = currentSource.value.split(".").pop().toLowerCase();
  if (["mp3", "wav", "ogg", "aac"].includes(extension)) return "audio";
  if (["mp4", "webm", "mov"].includes(extension)) return "video";
  return "unknown";
});

const getTrackName = (source) => {
  if (!source) return "";
  const parts = source.split("/");
  const fileName = parts[parts.length - 1];
  return fileName.split("_")[0] || fileName;
};

const currentTrackName = computed(() => getTrackName(currentSource.value));

const formatTime = (timeInSeconds) => {
  const minutes = Math.floor(timeInSeconds / 60);
  const seconds = Math.floor(timeInSeconds % 60);
  return `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(
    2,
    "0"
  )}`;
};

const formattedCurrentTime = computed(() => formatTime(currentTime.value));
const formattedDuration = computed(() => formatTime(duration.value));

const playTrack = (index) => {
  if (index >= 0 && index < playlistSources.value.length) {
    currentTrackIndex.value = index;
    isLoading.value = true;
    isPlaying.value = false;
  }
};

const getPlayer = () => {
  return currentMediaType.value === "video"
    ? videoPlayerRef.value
    : audioPlayerRef.value;
};

const togglePlayPause = () => {
  const player = getPlayer();
  if (!player) return;
  if (isPlaying.value) {
    player.pause();
  } else {
    player.play();
  }
};

const handleNextTrack = () => {
  if (playlistSources.value.length == 0) return;
  const nextIndex =
    (currentTrackIndex.value + 1) % playlistSources.value.length;
  playTrack(nextIndex);
};

const handlePrevTrack = () => {
  if (playlistSources.value.length == 0) return;
  const prevIndex =
    (currentTrackIndex.value - 1 + playlistSources.value.length) %
    playlistSources.value.length;
  playTrack(prevIndex);
};

const handleMediaLoaded = (event) => {
  duration.value = event.target.duration;
  isLoading.value = false;
  const player = getPlayer();
  if (player) {
    player.play();
  }
};

const updateProgress = (event) => {
  currentTime.value = event.target.currentTime;
  progress.value = (currentTime.value / duration.value) * 100 || 0;
};

const seek = (event) => {
  const player = getPlayer();
  if (!player || !duration.value) return;
  const progressBar = event.currentTarget;
  const clickPosition = event.offsetX / progressBar.clientWidth;
  player.currentTime = clickPosition * duration.value;
};

watch(currentSource, (newSource) => {
  if (newSource) {
    const player = getPlayer();
    if (player) {
      player.load();
    }
  }
});

onMounted(() => {
  if (playlistSources.value.length > 0) {
    isLoading.value = false;
  }
});
</script>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
@keyframes playing-bars {
  0% {
    transform: scaleY(0.1);
  }
  50% {
    transform: scaleY(1);
  }
  100% {
    transform: scaleY(0.1);
  }
}

.media-player-container {
  width: 90%;
  margin: 2rem auto;
  background-color: #ffffff;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  animation: fadeIn 0.5s ease-out;
  color: #1a202c;
}

.player-display-area {
  position: relative;
  background-color: #f8fafc;
}

.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
  z-index: 10;
}
.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #e2e8f0;
  border-top-color: #3385ff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

.video-player {
  width: 100%;
  height: auto;
  display: block;
  border-radius: 16px 16px 0 0;
}

.audio-player-ui {
  padding: 2rem;
  text-align: center;
  animation: slideUp 0.5s ease-out;
}
.album-art {
  width: 120px;
  height: 120px;
  margin: 0 auto 1.5rem;
  background: linear-gradient(145deg, #e2e8f0, #ffffff);
  border-radius: 50%;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  display: flex;
  justify-content: center;
  align-items: center;
}
.music-icon {
  width: 40px;
  height: 40px;
  background-color: #94a3b8;
  border-radius: 50% 50% 0 0;
  position: relative;
}
.music-icon::before {
  content: "";
  position: absolute;
  width: 4px;
  height: 30px;
  background: #f8fafc;
  left: 10px;
  bottom: 0;
}
.music-icon::after {
  content: "";
  position: absolute;
  width: 4px;
  height: 20px;
  background: #f8fafc;
  right: 10px;
  bottom: 0;
}

.track-title {
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0 0 1rem;
  color: #1e293b;
}
.progress-bar-container {
  width: 100%;
  height: 6px;
  background-color: #e2e8f0;
  border-radius: 3px;
  cursor: pointer;
  margin: 1rem 0 0.5rem;
}
.progress-bar {
  height: 100%;
  background-color: #3385ff;
  border-radius: 3px;
  transition: width 0.1s linear;
}
.time-display {
  display: flex;
  justify-content: space-between;
  font-size: 0.8rem;
  color: #64748b;
}
.controls {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 1.5rem;
  gap: 1.5rem;
}
.control-button {
  background: none;
  border: none;
  color: #475569;
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 50%;
  transition: background-color 0.3s ease;
  display: flex;
  justify-content: center;
  align-items: center;
}
.control-button.play-pause {
  width: 50px;
  height: 50px;
  background-color: #3385ff;
  color: #ffffff;
  box-shadow: 0 4px 15px rgba(51, 133, 255, 0.3);
}
.control-button:hover:not(.play-pause) {
  background-color: #e2e8f0;
}
.play-icon {
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-bottom: 8px solid transparent;
  border-left: 14px solid currentColor;
  margin-left: 4px;
}
.pause-icon {
  width: 14px;
  height: 16px;
  border-left: 4px solid currentColor;
  border-right: 4px solid currentColor;
  box-sizing: border-box;
}
.next-icon,
.prev-icon {
  width: 0;
  height: 0;
  border-top: 6px solid transparent;
  border-bottom: 6px solid transparent;
}
.next-icon {
  border-left: 10px solid #475569;
}
.prev-icon {
  border-right: 10px solid #475569;
}

.unknown-media {
  padding: 4rem 2rem;
  text-align: center;
  color: #64748b;
}
.unknown-icon {
  width: 60px;
  height: 60px;
  border: 2px dashed #cbd5e1;
  border-radius: 50%;
  margin: 0 auto 1rem;
  font-size: 2rem;
  line-height: 60px;
}

.playlist-area {
  padding: 1rem 1.5rem;
  max-height: 200px;
  overflow-y: auto;
  background-color: #f8fafc;
}
.playlist-area::-webkit-scrollbar {
  width: 6px;
}
.playlist-area::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 3px;
}
.playlist-title {
  font-size: 1rem;
  font-weight: 600;
  color: #475569;
  margin: 0 0 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid #e2e8f0;
}
.playlist {
  list-style: none;
  padding: 0;
  margin: 0;
}
.playlist-item {
  display: flex;
  align-items: center;
  padding: 0.75rem 0.5rem;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  gap: 1rem;
}
.playlist-item:hover {
  background-color: #f1f5f9;
}
.playlist-item.active {
  background-color: #eaf2ff;
  color: #3385ff;
}
.track-number {
  font-size: 0.85rem;
  color: #94a3b8;
}
.playlist-item.active .track-number {
  color: #70a7ff;
}
.track-name {
  flex-grow: 1;
  font-size: 0.95rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: #334155;
}
.playlist-item.active .track-name {
  color: #1e68d7;
  font-weight: 500;
}
.playing-indicator {
  display: flex;
  align-items: flex-end;
  gap: 2px;
  height: 16px;
}
.playing-indicator span {
  width: 3px;
  background-color: #3385ff;
  border-radius: 2px;
  animation: playing-bars 1s ease-in-out infinite;
}
.playing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}
.playing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
}
</style>
