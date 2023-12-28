import Imask from 'imask';

document.addEventListener('turbo:load', () => {
  const phoneInputs = document.querySelectorAll("[data-mask='phone']");
  phoneInputs.forEach((phoneInput) => {
    const phoneMask = new Imask(phoneInput, {
      mask: '+{7}(000)000-00-00',
      lazy: false
    });
  });
})
