const host = window.location.hostname;
export const env = {
  production:false,
    apiUrl: `http://${host}:8000/api`,
}