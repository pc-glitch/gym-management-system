<template>
  <div class="weibo-sharing">
    <button class="icon-btn" @click="share" title="分享到微博">
      <div class="icon" v-html="weiboIcon"></div>
      <span class="text">分享</span>
    </button>
  </div>
</template>

<script setup>
import { ref } from "vue";

const props = defineProps({
  title: {
    type: String,
    required: true,
    default: "分享内容",
  },
});

const weiboIcon = ref(
  `<svg t="1755157457766" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="9690" width="20" height="20"><path d="M0 0h1024v1024H0z" fill="#EDEDED" fill-opacity="0" p-id="9691"></path><path d="M782 590.567c-17.6-52.5-71.8-71.6-84.1-72.8-12.3-1.1-23.5-7.9-15.3-21.8s23.3-54.4-5.8-82.9c-29-28.6-92.5-17.8-137.5 0.7-44.8 18.5-42.4 5.6-41-7.1 1.5-13.3 25.7-87.9-48.3-97-96.9-11.7-221.2 107-265.1 175.4-66.4 103.3-55.9 173.3-55.9 173.3h0.5c7.9 96.5 151.5 173.4 327.5 173.4 151.3 0 278.7-56.9 316.4-134.3 0 0 0.1-0.3 0.5-0.9 3.9-8.3 6.9-16.8 8.8-25.5 5.1-20.7 9.2-50.9-0.7-80.5z m-346.9 199c-125.3 0-226.9-66.6-226.9-148.7s101.5-148.7 226.9-148.7c125.3 0 226.9 66.6 226.9 148.7 0 82.2-101.6 148.7-226.9 148.7z" fill="#E71F19" p-id="9692"></path><path d="M743.6 459.967c2.3 1 4.7 1.5 7.1 1.5 7.1 0 14.1-4.2 16.9-11.2 4.7-11.1 7.1-22.8 7.1-35 0-49.5-40.7-89.8-90.7-89.8-12.2 0-24.1 2.4-35.3 7.1-9.3 3.9-13.7 14.6-9.8 24 3.9 9.2 14.8 13.6 24.2 9.7 6.7-2.7 13.7-4.2 21-4.2 29.7 0 53.8 24 53.8 53.3 0 7.2-1.4 14.1-4.3 20.8-1.9 4.5-2 9.5-0.2 14 2.1 4.4 5.7 7.9 10.2 9.8z" fill="#F5AA15" p-id="9693"></path><path d="M683.1 213.467c-20.6 0-41 3-60.6 8.7-14.6 4.3-22.9 19.5-18.7 34 4.4 14.5 19.7 22.7 34.3 18.5 14.6-4.2 29.7-6.4 44.9-6.4 86.9-0.1 157.5 69.9 157.5 155.8 0 15.4-2.3 30.7-6.7 45.3-4.4 14.5 3.8 29.8 18.4 34.1 2.7 0.8 5.4 1.1 8.1 1.1 11.9 0 22.8-7.6 26.5-19.4 6-19.7 9.1-40.3 9.1-61.1-0.1-116.2-95.5-210.6-212.8-210.6z" fill="#F5AA15" p-id="9694"></path><path d="M414.1 546.367c-66.8 0-121 46.9-121 104.8s54.2 104.8 121 104.8 121-46.9 121-104.8-54.1-104.8-121-104.8z m-39.5 173c-23.4 0-42.4-18.8-42.4-42s19-42 42.4-42 42.4 18.8 42.4 42c0 23.1-19 42-42.4 42z m79.3-75.7c-5.1 8.8-15.3 12.4-22.8 8.1-7.5-4.2-9.3-14.8-4.3-23.6 5.1-8.8 15.3-12.4 22.8-8.1 7.5 4.4 9.4 15 4.3 23.6z" fill="#040000" p-id="9695"></path></svg>`
);

const share = () => {
  const url = "https://service.weibo.com/share/share.php";
  const shareUrl = window.location.href;
  const title = props.title;
  const sharesource = "weibo";
  const fullUrl = `${url}?url=${encodeURIComponent(
    shareUrl
  )}&sharesource=${sharesource}&title=${encodeURIComponent(title)}`;
  window.open(
    fullUrl,
    "weibo-share",
    "width=626,height=436,location=no,menubar=no"
  );
};
</script>

<style scoped>
.weibo-sharing {
  display: flex;
  gap: 16px;
}
.icon-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--secondary-color, #6c757d);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 14px;
  transition: color 0.25s ease;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.icon-btn .icon {
  fill: var(--secondary-color, #6c757d);
  transition: fill 0.25s ease;
  width: 20px;
  height: 20px;
}
.icon-btn:hover {
  color: var(--primary-color, #1e90ff);
}
.icon-btn:hover .icon {
  fill: var(--primary-color, #1e90ff);
}
</style>
