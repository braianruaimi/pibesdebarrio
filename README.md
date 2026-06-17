Estructura propuesta:

assets/
  css/style.css
  js/app.js
  images/
    icons/
    products/

Pasos sugeridos para completar:
1. Mover las imágenes desde la raíz a `assets/images/products`.
2. Actualizar las rutas en `index.html` (ej: `./buzologooriginal.png` -> `assets/images/products/buzologooriginal.png`).
3. Extraer el CSS de `index.html` a `assets/css/style.css` y reemplazar el `link`.
4. Opcional: crear un pequeño `build` o script para automatizar la actualización de rutas.
