import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

export default class extends Controller {
  static targets = ["status", "statusSelect", "statusButton"];

  connect() {
    console.log("ChangeStatusController connected");
  }

  changeStatus(event) {
    const onStatuses = ["return_the_deposit"];

    if (onStatuses.includes(event.target.value)) {
      const modal = document.getElementById("car-inspect");
      const modalInstance = new bootstrap.Modal(modal, { backdrop: "static" });
      modalInstance.show();
    }
  }
}
