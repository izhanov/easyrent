import Imask from 'imask';

['turbo:load', 'turbo:frame-render'].forEach((event) => {
  document.addEventListener(event, () => {
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

    const priceInputs = document.querySelectorAll("[data-mask='price']");
    priceInputs.forEach((priceInput) => {
      const numberMask = new Imask(priceInput, {
        mask: Number,
        thousandsSeparator: ' ',
        scale: 2,
        radix: ".",
        max: 2_000_000,
        min: 0
      });
    });
  });
});
