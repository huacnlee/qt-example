export function showInfo(message) {}

export function formatNumber(value, decimals = 2) {
  return parseFloat(value).toFixed(decimals);
}

export const appColors = {
  trendColor: {
    up: '#00B99A',
    down: '#FF5000',
  },
  selectionColor: '#00B99A',
};
