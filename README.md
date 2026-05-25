# GOMIX 🌨️
**App web de pedidos de antojitos y bebidas — PWA instalable en celular**

---

## 🚀 Publicar en GitHub Pages (modo demo)

1. Ve a [github.com](https://github.com) → **New repository** → `gomix` → **Public**
2. Haz clic en **"uploading an existing file"** y sube todos los archivos
3. Ve a **Settings → Pages** → Source: rama `main` → **Save**
4. Tu app estará en: `https://TU-USUARIO.github.io/gomix`

En modo demo, los datos se guardan en `localStorage` del navegador.

---

## ☁️ Activar Supabase (backend en la nube)

### Paso 1 — Crear proyecto en Supabase
1. Ve a [supabase.com](https://supabase.com) y crea una cuenta (gratuito)
2. Crea un nuevo proyecto
3. Anota tu **Project URL** y **anon/public key** (en Settings → API)

### Paso 2 — Configurar la base de datos
1. En el dashboard de Supabase, ve a **SQL Editor → New Query**
2. Pega el contenido de `supabase-setup.sql` y ejecútalo

### Paso 3 — Conectar la app
Edita `index.html` y llena la sección `CFG` al inicio del script:

```javascript
const CFG = {
  supabaseUrl : 'https://TU-PROYECTO.supabase.co',
  supabaseKey : 'tu-anon-key-aqui',
  whatsapp    : '5215512345678',   // tu número con código de país
  adminPin    : '9999',             // cambia este PIN
};
```

### Paso 4 — Subir cambios a GitHub
Actualiza el `index.html` en tu repositorio y listo.

---

## 📱 Instalar en el celular

### Android (Chrome)
- Abre la URL en Chrome → aparece banner "Instalar app" ó menú ⋮ → **Instalar**

### iPhone / iPad (Safari)
- Abre la URL en Safari → botón compartir (□↑) → **"Agregar a pantalla de inicio"**

---

## ✨ Funcionalidades

| Feature | Demo (sin Supabase) | Con Supabase |
|---------|---------------------|--------------|
| Catálogo de productos | ✅ localStorage | ✅ Base de datos |
| Carrito multiproducto | ✅ | ✅ |
| Pedidos | ✅ localStorage | ✅ Nube en tiempo real |
| Imágenes desde galería | ✅ base64 | ✅ Supabase Storage |
| Notificación WhatsApp | ✅ (si configuras número) | ✅ |
| Skeletons de carga | ✅ | ✅ |
| Admin: gestión de pedidos | ✅ | ✅ + estados en tiempo real |
| Admin: gestión de productos | ✅ | ✅ sincronizado |
| PWA offline | ✅ | ✅ |

---

## 🔑 Panel de administrador

- PIN por defecto: **`9999`** — cámbialo en `CFG.adminPin`
- Acceso: botón "Admin" en la esquina superior derecha
- Pestañas: **Pedidos** (con cambio de estado) y **Catálogo** (agregar/editar/eliminar)

---

## 📁 Archivos

```
gomix/
├── index.html           ← App completa
├── manifest.json        ← Configuración PWA
├── sw.js                ← Service Worker (offline)
├── icon.svg             ← Ícono
├── icon-maskable.svg    ← Ícono Android
├── supabase-setup.sql   ← Script SQL para Supabase
└── README.md
```

---

## ⚠️ Nota de seguridad

El PIN de admin está en el código del cliente. Para una operación comercial real:
- Usa **Supabase Auth** (email + contraseña) en lugar del PIN
- Aplica **Row Level Security** estricto en Supabase
- No expongas la `anon key` si tienes datos sensibles (es seguro para lectura pública)
