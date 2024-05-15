import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { Russian } from "flatpickr/dist/l10n/ru.js"
import monthSelectPlugin from "flatpickr/dist/plugins/monthSelect";
import "flatpickr/dist/plugins/monthSelect/style.css";

document.addEventListener('turbo:load', function() {
  const datepickers = document.querySelectorAll('.flatpickr');
  const startOfTheMonth = new Date(new Date().getFullYear(), new Date().getMonth(), 1);

  datepickers.forEach(function(datepicker) {
    flatpickr(datepicker, {
      locale: Russian,
      altInput: true,
      plugins: [
        new monthSelectPlugin(
          {
            dateFormat: "Y-m-d",
            altFormat: "F Y",
           }
        )
      ]
    });
  });
});
