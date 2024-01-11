import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['query', 'results']
  static values = { url: String }

  connect() {
    this.search = this.debounce(this.search, 500);
    console.log(this.urlValue)
  }

  search() {
    fetch(this.urlValue + '?q=' + this.queryTarget.value, { headers: { "Accept": 'text/plain', "Content-Type": "application/json" } })
      .then(response => response.text())
      .then((data) => {
        this.resultsTarget.innerHTML = data;
      });
  }

  debounce(func, timeout = 500){
    let timer;

    return (...args) => {
      clearTimeout(timer);
      timer = setTimeout(() => { func.apply(this, args) }, timeout);
    };
  }
}
