import { Controller, add } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'identificationNumber',
    'passportNumber',
    'citizen',
    'individualForm',
    'legalForm',
    'kind'
  ];

  connect() {
    const citizen = this.citizenTarget;
    const identificationNumber = this.identificationNumberTarget;
    const passportNumber = this.passportNumberTarget;

    if (citizen.checked) {
      identificationNumber.classList.remove("d-none");
      identificationNumber.querySelector("input").disabled = false;
      passportNumber.classList.add("d-none");
      passportNumber.querySelector("input").disabled = true;
    } else {
      identificationNumber.classList.add("d-none");
      identificationNumber.querySelector("input").disabled = true;
      passportNumber.querySelector("input").disabled = false;
      passportNumber.classList.remove("d-none");
    }

    const kind = this.kindTarget.value;

    if (kind === "individual") {
      this.legalFormTarget.querySelectorAll("input").forEach((input) => input.disabled = true)
      this.individualFormTarget.querySelectorAll("input").forEach((input) => input.disabled = false)
      this.individualFormTarget.classList.remove("d-none");
      this.legalFormTarget.classList.add("d-none");
    } else {
      this.individualFormTarget.querySelectorAll("input").forEach((input) => input.disabled = true)
      this.legalFormTarget.querySelectorAll("input").forEach((input) => input.disabled = false)
      this.individualFormTarget.classList.add("d-none");
      this.legalFormTarget.classList.remove("d-none");
    }
  }

  changeResidence() {
    const citizen = this.citizenTarget;
    const identificationNumber = this.identificationNumberTarget;
    const passportNumber = this.passportNumberTarget;

    if (citizen.checked) {
      identificationNumber.classList.remove("d-none");
      identificationNumber.querySelector("input").disabled = false;
      passportNumber.classList.add("d-none");
      passportNumber.querySelector("input").disabled = true;
    } else {
      identificationNumber.classList.add("d-none");
      identificationNumber.querySelector("input").disabled = true;
      passportNumber.querySelector("input").disabled = false;
      passportNumber.classList.remove("d-none");
    }
  }

  changeKind(e) {
    const kind = this.kindTarget.value;

    if (kind === "individual") {
      this.legalFormTarget.querySelectorAll("input").forEach((input) => input.disabled = true)
      this.individualFormTarget.querySelectorAll("input").forEach((input) => input.disabled = false)
      this.individualFormTarget.classList.remove("d-none");
      this.legalFormTarget.classList.add("d-none");
    } else {
      this.individualFormTarget.querySelectorAll("input").forEach((input) => input.disabled = true)
      this.legalFormTarget.querySelectorAll("input").forEach((input) => input.disabled = false)
      this.individualFormTarget.classList.add("d-none");
      this.legalFormTarget.classList.remove("d-none");
    }
  }
}
