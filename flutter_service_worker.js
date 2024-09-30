'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "5ab2f0b9f57148f85fe1861ca1e5ab1f",
"assets/dotenv.dev": "b4dcd8df3e9a68b333314210c64ea12d",
"assets/assets/image/in_progress.webp": "21f1f60cfb7ab95182090039570eba19",
"assets/assets/image/avatar_woman.webp": "d97b0577223c7ab9a4de23806f959d65",
"assets/assets/image/location_agra.svg": "64607a340a37e5034c702b6bda82f94b",
"assets/assets/image/auth_bg_border.webp": "a06cb152127a68d7d97107f1f8fca5a5",
"assets/assets/image/flowers.webp": "1de82f45523f79f7886a42a858bfba75",
"assets/assets/image/auth_bg.webp": "5827c1c844d4882916b57947a8e52c95",
"assets/assets/image/avatar_other.webp": "eebbddf540ffb2dfd638322729f59dd6",
"assets/assets/image/floral_bg.png": "45aa751453ac6e90b415a3cf1b1d03bc",
"assets/assets/image/avatar_man.webp": "1bf9973386122cb16281bc0e733a64ac",
"assets/assets/font/Krylon-Regular.otf": "5f34288e0be220cf22af7f08c8b8eb11",
"assets/assets/font/Kantumruy-Bold.ttf": "a33d16e9cf60f5d55f8ee3bce2bc2a0e",
"assets/assets/font/ElMessiri-Medium.ttf": "179378483f9ce4d232ac7c3480e37943",
"assets/assets/font/Kantumruy-Light.ttf": "3a90e4d132fd05832be3ac36ceda44d0",
"assets/assets/font/Kantumruy-Regular.ttf": "3a7bfe13e448e8a67275a6166feb7c05",
"assets/assets/font/Comforter-Regular.ttf": "cff123ea94f9032380183b8bbbf30ec1",
"assets/assets/font/ElMessiri-Regular.ttf": "0dfae81209fc5b5e0c3cff63db36b31b",
"assets/assets/font/ElMessiri-Bold.ttf": "4498ccf4fc6a16e754a0da5d41a64a9c",
"assets/assets/font/DMSerifDisplay-Regular.ttf": "25b39681f8cf94ad3cbfc6d25d9c0c4e",
"assets/assets/font/calibri_regular.ttf": "5d7c31b284ddb01fc1cbae0edc9ec210",
"assets/assets/font/ElMessiri-SemiBold.ttf": "91f88ab142ba7278a4a954086376fbc0",
"assets/assets/icon/star.svg": "b5df85ac77ace2e65b62494c7a469b68",
"assets/assets/icon/bottom_nav_dash.svg": "388332beacfb257134291787fc563024",
"assets/assets/icon/calendar.svg": "ad588688d4d5d7847e79d1cc95086d19",
"assets/assets/icon/octicon_person.svg": "ec0909b1ed1bb682305c11cb83e9f7f6",
"assets/assets/icon/bottom_nav_home.svg": "5d8b8872474e9686dc5feee3aa9d8bd3",
"assets/assets/icon/chat_bubble.svg": "d6a99444f76f86a3291046a42047134d",
"assets/assets/icon/bx_menu.svg": "9509d5bebab90043e49226e6d55e6f53",
"assets/assets/icon/bottom_nav_collab.svg": "7bbbceb30420beb0159bcd683657fba7",
"assets/assets/icon/bottom_nav_inspire.svg": "7b0aeb9c01d81278db01b91b13d84019",
"assets/assets/icon/arrow_forward.svg": "7943670505ccb91efcbaa5abebf61c6f",
"assets/assets/icon/check.svg": "7368ea3c9516eb297df28dc0ea734635",
"assets/assets/icon/warning.svg": "bd6c018ea784b06fed1ddaf2e9b69008",
"assets/assets/icon/bottom_nav_vendors.svg": "28337b625327331a7e18e8f8e085afcf",
"assets/assets/icon/decoration.svg": "492babf63c1775ea0268fc369695c8d9",
"assets/assets/icon/arrow_down.svg": "381fe74883b6469c9d3f69b765e6b1b0",
"assets/assets/icon/bi_bell.svg": "5ee4e01aade56bb934ca82925a04d36a",
"assets/assets/icon/money.svg": "870f1423f3cedaf7b70fc0c6134da004",
"assets/AssetManifest.bin.json": "9844aa7497ff610fb6a1b3c43dcc366e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "4ea8160a2fee2a0a2745fec31ffacd9e",
"assets/FontManifest.json": "3923b135eac1758c8e562fb8ca18068f",
"assets/dotenv.prod": "eb4199bf9a7b0dd3de7e07a83d1ce2b8",
"assets/NOTICES": "309852e1a5373fd33a5c61d6db5f4bbd",
"assets/fonts/MaterialIcons-Regular.otf": "8e0ac52971d7e1c6ee8694d616fba6aa",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"main.dart.js": "44708e9ed6b9e49f632d931f0193c264",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"flutter_bootstrap.js": "2ff07b456100dce051846c300709da33",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"index.html": "6c5aec77f38211439d079e4c0c81a3bf",
"/": "6c5aec77f38211439d079e4c0c81a3bf",
"version.json": "281c5c875c5b5aa08d839f46f24b31ed",
"manifest.json": "906fc433ff2f17c2c8af10ca573ca807"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
