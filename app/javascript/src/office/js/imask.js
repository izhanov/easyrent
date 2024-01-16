import Imask from 'imask';

document.addEventListener('turbo:load', () => {
  const phoneInputs = document.querySelectorAll("[data-mask='phone']");
  phoneInputs.forEach((phoneInput) => {
    const phoneMask = new Imask(phoneInput, {
      mask: '+{7}(000)000-00-00',
      lazy: false
    });
  });

  const mileageInputs = document.querySelectorAll("[data-mask='mileage']");
  mileageInputs.forEach((mileageInput) => {
    const numberMask = new Imask(mileageInput, {
      mask: Number,
      thousandsSeparator: ' ',
      scale: 2,
      radix: ".",
      max: 1_500_000,
      min: 0
    });
  });
})
