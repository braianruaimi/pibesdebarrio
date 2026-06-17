// assets/js/app.js
document.addEventListener('DOMContentLoaded', () => {
  // Número por defecto (Argentina). Cambialo por tu número con código de país.
  const WHATSAPP_NUMBER = '5492215047962';

  document.body.addEventListener('click', (e) => {
    const target = e.target;
    if (!target) return;

    if (target.classList.contains('whatsapp-button') || target.classList.contains('gold-electric-button')) {
      const productCard = target.closest('article');
      if (!productCard) return;

      const titleEl = productCard.querySelector('h3');
      const priceEl = productCard.querySelector('p');
      const productName = titleEl ? titleEl.innerText.trim() : 'Producto';
      const productPrice = priceEl ? priceEl.innerText.trim() : '';

      const message = `¡Hola Pibes de Barrio! 🔥 Me interesa el producto *${productName}* con un valor de ${productPrice}. ¿Tienen stock disponible?`;
      const whatsappUrl = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
      window.open(whatsappUrl, '_blank');
    }
  });

  // Registrar Service Worker (queda en la raíz)
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('./sw.js')
      .then(reg => console.log('Service Worker registrado con éxito', reg))
      .catch(err => console.error('Error al registrar el Service Worker', err));
  }
});

// Export modular simple por compatibilidad
window.Pibes = window.Pibes || {};
