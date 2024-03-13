import { Turbo } from "@hotwired/turbo-rails";

document.addEventListener("turbo:load", () => {
  const selectedCarPark = document.getElementById("car_park_id");
  const selectedCar = document.getElementById("booking_car_id");

  if (selectedCar) {
    selectedCar.addEventListener("change", (event) => {
      Turbo.visit(`/office/car_parks/${selectedCarPark.value}/cars/${selectedCar.value}/offers/select`, {action: "replace", frame: "offers_to_select"});

      const offersForSelectFrame = document.querySelector('turbo-frame[id="offers_to_select"]');

      offersForSelectFrame.addEventListener("turbo:frame-load", (event) => {
        let offersSelect = offersForSelectFrame.querySelector('select');

        document.dispatchEvent(
          new CustomEvent("calculator:offer-selected",
            {
              detail: {offersSelect: offersSelect}
            }
          ));
      });
    });
  }

  if (selectedCarPark) {
    selectedCarPark.addEventListener("change", (event) => {
      const offersForSelectFrame = document.querySelector('turbo-frame[id="offers_to_select"]');
      const offersSelect = offersForSelectFrame.querySelector('select');
      const newOfferButton = offersForSelectFrame.querySelector('a[data-turbo-frame="new_offer"]');
      const newOfferFrame = document.querySelector('turbo-frame[id="new_offer"]');
      const newOfferForm = newOfferFrame.querySelector('form');

      if (offersSelect) {
        offersSelect.remove();
      }

      if (newOfferButton) {
        newOfferButton.remove();
      }

      if (newOfferForm) {
        newOfferForm.remove();
      }
    });
  }
})

document.addEventListener("turbo:before-stream-render", (event) => {
  const selectedCarPark = document.getElementById("car_park_id");
  const selectedCar = document.getElementById("booking_car_id");

  const stream = event.detail.newStream;

  if (stream.target == "new_offer" && stream.action == "update") {
    Turbo.cache.clear();
    Turbo.visit(`/office/car_parks/${selectedCarPark.value}/cars/${selectedCar.value}/offers/select`, {action: "replace", frame: "offers_to_select"});

    const offersForSelectFrame = document.querySelector('turbo-frame[id="offers_to_select"]');

    offersForSelectFrame.addEventListener("turbo:frame-load", (event) => {
      let offersSelect = offersForSelectFrame.querySelector('select');
      offersSelect.lastElementChild.selected = 'selected';

      document.dispatchEvent(
        new CustomEvent("calculator:offer-selected",
          {
            detail: {offersSelect: offersSelect}
          }
        ));
    });
  }
});

