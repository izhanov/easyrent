import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

export default class extends Controller {
  static targets = ["form"];

  submit(event) {
    event.preventDefault();
    const form = this.formTarget
    const action = form.getAttribute("action");

    fetch(action,
      {
        method: "PATCH",
        body: new FormData(form)
      }
    )
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          const modal = bootstrap.Modal.getInstance(form.closest(".modal"));
          modal.hide();
        } else {
          console.log(data);
        }
      })

  }
}

