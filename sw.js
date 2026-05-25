/* GOMIX Service Worker — v1.0 */
const CACHE = 'gomix-v1';

const APP_SHELL = [
  './',
  './index.html',
  './manifest.json',
  './icon.svg',
  './icon-maskable.svg',
  'https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.47.0/tabler-icons.min.css',
  'https://unpkg.com/react@18/umd/react.production.min.js',
  'https://unpkg.com/react-dom@18/umd/react-dom.production.min.js',
];

/* ─── INSTALL: pre-cache app shell ─── */
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE)
      .then(cache => cache.addAll(APP_SHELL))
      .catch(err => console.warn('[SW] Pre-cache failed:', err))
  );
  self.skipWaiting();
});

/* ─── ACTIVATE: delete old caches ─── */
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

/* ─── FETCH: cache-first for shell, network-first for images ─── */
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);

  /* External images → network first, fallback to cache */
  if (request.destination === 'image') {
    event.respondWith(
      fetch(request)
        .then(res => {
          const clone = res.clone();
          caches.open(CACHE).then(c => c.put(request, clone));
          return res;
        })
        .catch(() => caches.match(request))
    );
    return;
  }

  /* App shell → cache first, then network */
  event.respondWith(
    caches.match(request).then(cached => {
      if (cached) return cached;

      return fetch(request).then(res => {
        /* Cache valid same-origin and CDN responses */
        if (res.ok && (url.origin === self.location.origin || url.hostname.includes('jsdelivr') || url.hostname.includes('unpkg'))) {
          const clone = res.clone();
          caches.open(CACHE).then(c => c.put(request, clone));
        }
        return res;
      }).catch(() => {
        /* Offline fallback: return app shell for navigation requests */
        if (request.mode === 'navigate') {
          return caches.match('./index.html');
        }
      });
    })
  );
});
