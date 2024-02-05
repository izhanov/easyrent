import { Turbo } from "@hotwired/turbo-rails";

const selectedCarPark = document.getElementById("car_park");
const selectedCar = document.getElementById("booking_car_id");

if (selectedCar) {
  selectedCar.addEventListener("change", (event) => {
    Turbo.visit(`/office/car_parks/${selectedCarPark.value}/cars/${selectedCar.value}/offers/select`, {action: "replace", frame: "offers_to_select"});
  });
}

if (selectedCarPark) {
  selectedCarPark.addEventListener("change", (event) => {
    const offersForSelectFrame = document.querySelector('turbo-frame[id="offers_to_select"]');
    const offersSelect = offersForSelectFrame.querySelector('select');
    offersSelect.remove();
  });
}
