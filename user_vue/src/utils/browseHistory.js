const DEFAULT_LIMIT = 50;

const getHistoryKey = (userid) => `browseHistory_${userid || "guest"}`;

export const getBrowseHistory = (userid) => {
  try {
    const raw = localStorage.getItem(getHistoryKey(userid));
    if (!raw) return [];
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed : [];
  } catch (error) {
    console.error("读取浏览记录失败:", error);
    return [];
  }
};

export const saveBrowseHistory = (userid, record) => {
  if (!record || !record.id || !record.route) return;
  try {
    const historyList = getBrowseHistory(userid);
    const deduped = historyList.filter(
      (item) => `${item.route}_${item.id}` !== `${record.route}_${record.id}`
    );
    const next = [
      {
        ...record,
        viewedAt: record.viewedAt || new Date().toISOString(),
      },
      ...deduped,
    ].slice(0, DEFAULT_LIMIT);
    localStorage.setItem(getHistoryKey(userid), JSON.stringify(next));
  } catch (error) {
    console.error("保存浏览记录失败:", error);
  }
};

export const clearBrowseHistory = (userid) => {
  try {
    localStorage.removeItem(getHistoryKey(userid));
  } catch (error) {
    console.error("清空浏览记录失败:", error);
  }
};
