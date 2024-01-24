
import { transliterate as tr, slugify } from "transliteration";

const transliterate = (string) => {
  return slugify(tr(string));
};

document.addEventListener("turbo:frame-render", () => {
  const transliterateFields = document.querySelectorAll("[data-transliterate='true']");

  transliterateFields.forEach((field) => {
    const transliterateTargetField = field.dataset.transliterateTargetField;

    field.addEventListener("keyup", (e) => {
      const transliteratedValue = transliterate(e.target.value);
      const targetField = document.querySelector(`[name="${transliterateTargetField}"]`);
      targetField.value = transliteratedValue;
    });
  });
});

