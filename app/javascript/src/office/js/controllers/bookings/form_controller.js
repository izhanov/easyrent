import { Controller } from '@hotwired/stimulus';
import camelcaseKeys from 'camelcase-keys';

export default class extends Controller {
  static targets = [
    "carTitle",
    "carId",
    "pledgeAmount",
    "prepaymentAmount",
    "totalAmount",
    "paymentMethods",
    "paymentMethodAmount",
  ]

  connect() {
  }

  async submit (e) {
    e.preventDefault()
    const response = await fetch('/office/bookings', {method: "POST", body: new FormData(this.element)})
    const data = await response.json()
    if (response.ok) {
      Turbo.visit(`/office/bookings/${data.booking.id}`)
    } else {
      const errors = data.errors
      this.dispatch("error", {detail: camelcaseKeys(errors)})
    }
  }

  handlePledgeAmount(e) {
    if (this.pledgeAmountTarget.disabled) {
      this.pledgeAmountTarget.removeAttribute('disabled');
    } else {
      this.pledgeAmountTarget.setAttribute('disabled', 'disabled');
    }
  };

  handlePrepaymentAmount() {
    if (this.prepaymentAmountTarget.disabled) {
      this.prepaymentAmountTarget.removeAttribute('disabled');
    } else {
      this.prepaymentAmountTarget.value = 0.0;
      this.prepaymentAmountTarget.setAttribute('disabled', 'disabled');
    }
  }

  handlePaymentMethod(e) {
    if (e.target.value === "mixed") {
      this.paymentMethodsTarget.classList.remove("d-none");
      this.paymentMethodAmountTargets.forEach((el) => {
        el.removeAttribute('disabled');
      });
    } else {
      this.paymentMethodAmountTargets.forEach((el) => {
        el.setAttribute('disabled', 'disabled');
      });
      this.paymentMethodsTarget.classList.add("d-none");
    }
  }
}
