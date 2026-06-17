const CACHE_NAME = "pibesdebarrio-static-20260513035638";
const CORE_ASSETS = [
  "./",
  "./index.html",
  "./404.html",
  "./manifest.webmanifest",
  "./assets/css/style.css",
  "./assets/js/app.js",
  "./assets/images/products/llaveroori.jpg",
  "./assets/images/products/buzoori.png",
  "./assets/images/products/buzologooriginal.png",
  "./assets/images/products/jarraoro.png",
  "./assets/images/products/rememujer.jpg",
  "./assets/images/products/remenegra.jpg"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(CORE_ASSETS)),
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys.map((key) => {
          if (key !== CACHE_NAME) {
            return caches.delete(key);
          }

          return Promise.resolve(false);
        }),
      ),
    ),
  );
  event.waitUntil(self.clients.claim());
});

self.addEventListener("message", (event) => {
  if (event.data?.type === "SKIP_WAITING") {
    self.skipWaiting();
  }
});

self.addEventListener("fetch", (event) => {
  if (event.request.method !== "GET") {
    return;
  }

  const requestUrl = new URL(event.request.url);
  const isSameOrigin = requestUrl.origin === self.location.origin;
  const isNavigationRequest = event.request.mode === "navigate";

  if (!isSameOrigin) {
    return;
  }

  if (isNavigationRequest) {
    event.respondWith(
      fetch(event.request).catch(() => caches.match("./")),
    );

      return;
    }

    if (requestUrl.pathname.endsWith("/manifest.webmanifest")) {
      event.respondWith(
        caches.match(event.request).then((cachedResponse) => cachedResponse || fetch(event.request)),
      );
    }
});
