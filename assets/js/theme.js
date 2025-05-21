// assets/js/theme.js
export function setTheme(theme) {
  localStorage.setItem("theme", theme);
  document.documentElement.setAttribute("data-theme", theme);
}

export function getStoredTheme() {
  return localStorage.getItem("theme");
}
