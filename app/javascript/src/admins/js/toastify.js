import Toastify from "toastify-js";

document.addEventListener("turbo:load", () => {
  const notifications = document.querySelectorAll("[data-notification]")

  Array.from(notifications).forEach(notification => {
    console.log(notification.dataset.notification)
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
