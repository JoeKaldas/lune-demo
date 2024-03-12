import { Controller } from "@hotwired/stimulus";
import { debounce } from "lodash";

export default class extends Controller {
  static targets = ["form", "searchInput", "input", "sort"];

  initialize() {
    if (this.hasSearchInputTarget) {
      this.searchInputTarget.addEventListener("input", debounce(() => this.submit(), 200));
    }
    this.inputTargets.forEach((input) => {
      this.toggleActive(input);
      input.addEventListener("change", () => {
        this.toggleActive(input);
        this.submit();
      });
    });
  }

  toggleActive(input) {
    if (
      (input.type == "checkbox" && input.checked === false) ||
      input.value.length === 0
    ) {
      input.closest(".form-group").classList.add("inactive");
      input.closest(".form-group").classList.remove("active");
    } else {
      input.closest(".form-group").classList.add("active");
      input.closest(".form-group").classList.remove("inactive");
    }
  }

  toggleByID() {
    this.inputTargets.find((input) => input.id == event.target.dataset.checkboxId).click();
  }

  sortRecords() {
    const { attr, dir } = event.target.dataset;
    this.sortTarget.value = `${attr} ${dir}`
    this.submit();
  }

  submit() {
    this.formTarget.submit();
  }

  reset() {
    event.preventDefault();
    this.inputTargets.forEach((input) => {
      input.type == "checkbox" ? (input.checked = false) : (input.value = "");
      this.toggleActive(input);
    });

    this.submit();
  }

  formResponseCallback() {
    if (document.querySelector("#search-form .remote-input")) {
      document.querySelector("#search-form .remote-input").classList.remove("active");
    }
  }
}
