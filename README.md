# GOMIX 🌨️
**Antojitos y bebidas a domicilio — Progressive Web App**

Aplicación web para la venta de productos alimenticios preparados.
Funciona como app instalable en cualquier celular (Android e iOS).

---

## 📁 Archivos

```
gomix/
├── index.html        ← App completa (React)
├── manifest.json     ← Configuración PWA
├── sw.js             ← Service Worker (modo offline)
├── icon.svg          ← Ícono de la app
├── icon-maskable.svg ← Ícono para Android (fondo completo)
└── README.md         ← Este archivo
```

---

## 🚀 Publicar en GitHub Pages

### Paso 1 — Crear el repositorio
1. Ve a [github.com](https://github.com) e inicia sesión
2. Haz clic en **New repository**
3. Ponle nombre: `gomix` (o el que prefieras)
4. Márcalo como **Public**
5. Haz clic en **Create repository**

### Paso 2 — Subir los archivos
1. En tu nuevo repositorio, haz clic en **uploading an existing file**
2. Arrastra todos los archivos de esta carpeta (`index.html`, `manifest.json`, `sw.js`, `icon.svg`, `icon-maskable.svg`)
3. Haz clic en **Commit changes**

### Paso 3 — Activar GitHub Pages
1. Ve a **Settings** → **Pages** (en el menú lateral)
2. En **Source**, elige **Deploy from a branch**
3. Selecciona la rama `main` y carpeta `/ (root)`
4. Haz clic en **Save**
5. Espera 1-2 minutos y tu app estará en:
   ```
   https://TU-USUARIO.github.io/gomix
   ```

---

## 📱 Instalar en el celular

### Android (Chrome)
1. Abre la URL de tu app en Chrome
2. Aparecerá un banner en la parte inferior: **"Agregar a pantalla de inicio"**
3. O bien, toca el menú (⋮) → **Instalar aplicación**

### iPhone / iPad (Safari)
1. Abre la URL en Safari
2. Toca el botón de compartir (□↑)
3. Selecciona **"Agregar a pantalla de inicio"**
4. Toca **Agregar**

---

## 🔑 Acceso de administrador

El PIN de administrador es: **`9999`**

En el panel de admin puedes:
- **Pedidos** — Ver todos los pedidos recibidos con datos del comprador
- **Catálogo** — Agregar, editar y eliminar productos

Los productos y pedidos se guardan localmente en el dispositivo del administrador.

---

## ✏️ Personalizar

Para cambiar los productos iniciales, edita el array `INIT_PRODUCTS` en `index.html`.

Para cambiar el PIN, edita la constante `PIN` en `index.html`:
```javascript
const PIN = '9999'; // ← cambia este valor
```

---

## 📦 Tecnologías

- **React 18** (via CDN, sin build step)
- **Tabler Icons** (iconos)
- **Service Worker** (soporte offline)
- **localStorage** (persistencia de datos)
- **PWA Manifest** (instalable en celulares)
