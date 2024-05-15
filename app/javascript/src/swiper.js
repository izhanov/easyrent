import Swiper from 'swiper/bundle';
import 'swiper/css/bundle';

document.addEventListener('turbo:load', () => {
  const swiper = new Swiper(".swiper", {
    // Optional parameters
    direction: "horizontal",
    loop: true,

    // Navigation arrows
    navigation: {
      nextEl: ".car-photo-slider__next",
      prevEl: ".car-photo-slider__prev",
    },
    spaceBetween: 6
  });
});
