import * as humps from 'humps';

document.addEventListener("turbo:load", (e) => {
  let store = {
    services: {}
  };

  document.addEventListener('calculator:reset-total-price', (customEvent) =>{
    delete store.offerId;
    calculateTotalAmount(store)
  });

  const offersSelect = document.getElementById('booking_offer_id');

  if (offersSelect) {
    store.offerId = offersSelect.value;
    offersSelect.addEventListener('change', (e) => {
      store.offerId = e.target.value;
      calculateTotalAmount(store);
    });
  }

  document.addEventListener('calculator:offer-selected', (customEvent) => {
    const offersSelect = customEvent.detail.offersSelect;
    store.offerId = offersSelect.value;

    calculateTotalAmount(store);

    offersSelect.addEventListener('change', (e) => {
      store.offerId = e.target.value;
      calculateTotalAmount(store);
    });
  })

  const startsAt = document.getElementById('booking_starts_at');
  const endsAt = document.getElementById('booking_ends_at');

  if (startsAt && endsAt) {
    if (startsAt.value && endsAt.value) {
      store.startsAt = new Date(startsAt.value);
      store.endsAt = new Date(endsAt.value);
    }

    startsAt.addEventListener('focusout', (e) => {
      store.startsAt = new Date(e.target.value);
      calculateTotalAmount(store);
    });

    endsAt.addEventListener('focusout', (e) => {
      store.endsAt = new Date(e.target.value);
      calculateTotalAmount(store);
    });
  }

  let servicesCheckboxes = document.querySelectorAll('[id^="booking_services_"]');

  servicesCheckboxes.forEach((checkbox) => {
    if (checkbox.checked) {
      const serviceId = checkbox.id.split('_')[2];
      store.services[serviceId] = checkbox.value;
    }

    checkbox.addEventListener('change', (e) => {
      const serviceId = e.target.id.split('_')[2];

      if (e.target.checked) {
        store.services[serviceId] = e.target.value;
      } else {
        delete store.services[serviceId];
      }
      calculateTotalAmount(store);
    });
  });


  const pledgeAmount = document.getElementById('booking_pledge_amount');

  if (pledgeAmount) {
    store.pledgeAmount = pledgeAmount.value;

    pledgeAmount.addEventListener('keyup', (e) => {
      if (e.target.disabled) {
        store.pledgeAmount = 0;
      } else {
        if (e.target.value === '') {
          store.pledgeAmount = 0;
        } else {
          store.pledgeAmount = e.target.value;
        }
        calculateTotalAmount(store)
      }
    });
  }

  document.addEventListener('calculator:services-changed', (customEvent) => {
    let servicesCheckboxes = document.querySelectorAll('[id^="booking_services_"]');

    servicesCheckboxes.forEach((checkbox) => {
      checkbox.addEventListener('change', (e) => {
        const serviceId = e.target.id.split('_')[2];

        if (e.target.checked) {
          store.services[serviceId] = e.target.value;
        } else {
          delete store.services[serviceId];
        }
        calculateTotalAmount(store);
      });
    });
  });

  let withPleadgeAmountCheckbox = document.getElementById('booking_with_pledge_amount');

  if (withPleadgeAmountCheckbox) {
    withPleadgeAmountCheckbox.addEventListener('change', (e) => {
      if (e.target.checked) {
        const pledgeAmount = document.getElementById('booking_pledge_amount');
        store.pledgeAmount = pledgeAmount.value;
        calculateTotalAmount(store);
      } else {
        store.pledgeAmount = 0;
        calculateTotalAmount(store);
      }
    });
  }
})

function calculateTotalAmount(store) {
  if (store.offerId && store.startsAt && store.endsAt) {
    const totalAmount = fetch(`/office/ajax/bookings/calculate`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        booking: humps.decamelizeKeys(store)
      })
    })
      .then(response => response.json())
      .then(data => {
        const booking = humps.camelizeKeys(data.booking)
        const totalAmount = document.getElementById('total-amount');
        totalAmount.innerHTML = booking.totalPrice;
      })
  } else {
    const totalAmount = document.getElementById('total-amount');
    totalAmount.innerHTML = "0,00 теңге"
  }
}

