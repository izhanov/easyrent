import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["ieForm", "llpForm"];

  initialize() {
    const llpKind = document.getElementById("car_park_kind_llp");
    const ieKind = document.getElementById("car_park_kind_ie");

    if (llpKind.checked) {
      this.enableLlpForm();
      this.disableIeForm();
    } else {
      this.enableIeForm();
      this.disableLlpForm();
    }
  }

  changeKind(e) {
    if (e.target.value === "ie") {
      this.enableIeForm();
      this.disableLlpForm();
    } else {
      this.enableLlpForm();
      this.disableIeForm();
    }
  }

  changeBankName(e) {
    const bankCode = e.target.value;
    const bankCodeInput = document.getElementById("car_park_bank_code");
    bankCodeInput.value = bankCode;
  }

  enableIeForm() {
    const ieLabel = document.querySelector("[for='car_park_kind_ie']");
    ieLabel.classList.add("autopark-change--active");
    const llpLabel = document.querySelector("[for='car_park_kind_llp']");
    llpLabel.classList.remove("autopark-change--active");
    this.enableInputs(this.ieFormTarget);
    this.ieFormTarget.classList.remove("d-none");
  }

  disableLlpForm() {
    this.llpFormTarget.classList.add("d-none");
    this.disableInputs(this.llpFormTarget);
  }

  enableLlpForm() {
    this.enableInputs(this.llpFormTarget);
    const llpLabel = document.querySelector("[for='car_park_kind_llp']");
    llpLabel.classList.add("autopark-change--active");
    const ieLabel = document.querySelector("[for='car_park_kind_ie']");
    ieLabel.classList.remove("autopark-change--active");
    this.llpFormTarget.classList.remove("d-none");
  }

  disableIeForm() {
    this.ieFormTarget.classList.add("d-none");
    this.disableInputs(this.ieFormTarget);
  }

  disableInputs(target) {
    target.querySelectorAll("input").forEach((input) => {
      input.disabled = true;
    });
  }

  enableInputs(target) {
    target.querySelectorAll("input").forEach((input) => {
      input.disabled = false;
    });
  }
}
