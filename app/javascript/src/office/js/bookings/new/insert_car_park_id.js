document.addEventListener('turbo:frame-render', (event) => {
  const frame = event.target;

  if (frame.id == "new_client") {
    const hiddenCarParkIDInput = document.createElement('input');
    hiddenCarParkIDInput.type = 'hidden';
    hiddenCarParkIDInput.id = 'car_park_id';
    hiddenCarParkIDInput.name = 'car_park_id';
    hiddenCarParkIDInput.value = document.querySelector('select[id="car_park"]').value;
    frame.firstElementChild.prepend(hiddenCarParkIDInput);
  }
})
