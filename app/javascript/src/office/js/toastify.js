import Toastify from "toastify-js";

[
  'turbo:load',
  'turbo:frame-render',
].forEach(eventName => {
  document.addEventListener(eventName, () => {
    const notifications = document.querySelectorAll("[data-notification]")

    Array.from(notifications).forEach(notification => {
      Toastify({
        text: notification.dataset.notification,
        duration: 3000,
        gravity: "top",
        position: "center",
        className: `toastify-${notification.dataset.kind}`,
        stopOnFocus: true
      }).showToast();
    })
  });
});
