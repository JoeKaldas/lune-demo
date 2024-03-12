import "core-js/stable";
import "@hotwired/turbo-rails";
import * as bootstrap from "bootstrap";
window.bootstrap = bootstrap;
import "./controllers";

Turbo.setConfirmMethod((message, element) => {
  let modalElement = document.getElementById("turbo-confirm");
  modalElement.querySelector("h2").textContent = message;

  modalElement.addEventListener("click", (event) => {
    if (event.target.id == "turbo-confirm") {
      modalElement.close("close");
    }
  });

  modalElement.querySelector(".btn-close").addEventListener("click", (event) => {
    modalElement.close("close");
  });

  modalElement.showModal();
  setTimeout(() => {
    modalElement.classList.add("show");
  }, 150);

  return new Promise((resolve, reject) => {
    modalElement.addEventListener("close", (event) => {
      resolve(modalElement.returnValue == "confirm");
    }, { once: true });
  })
})

document.addEventListener("turbo:load", () => {
  document.querySelectorAll('.nested-link').forEach((el) => {
    el.addEventListener("click", (e) => {
      e.stopPropagation();
    });
  });
});

// Turbo Streams allow us to hook into a turbo:before-stream-render event.
// From here we can apply animation classes to elements that are just about to be added, or just about to be removed.
// https://edforshaw.co.uk/hotwire-turbo-stream-animations
document.addEventListener("turbo:before-stream-render", function (event) {
  const fallbackToDefaultActions = event.detail.render

  event.detail.render = function (streamElement) {
    if (streamElement.action == "redirect") {
      window.location.href = streamElement.getAttribute('location')
    } else {
      fallbackToDefaultActions(streamElement)
    }
  }

  // Add a class to an element we are about to add to the page
  // as defined by its "data-stream-enter-class"
  if (event.target.firstElementChild instanceof HTMLTemplateElement && event.target.templateContent.firstElementChild) {
    var enterAnimationClass =
      event.target.templateContent.firstElementChild.dataset.streamEnterClass;
    if (enterAnimationClass) {
      event.target.templateElement.content.firstElementChild.classList.add(
        enterAnimationClass
      );
    }
  }

  // Add a class to an element we are about to remove from the page
  // as defined by its "data-stream-exit-class"
  var elementToRemove = document.getElementById(event.target.target);
  if (elementToRemove) {
    var streamExitClass = elementToRemove.dataset.streamExitClass;
    if (streamExitClass) {
      // Intercept the removal of the element
      event.preventDefault();
      elementToRemove.classList.add(streamExitClass);
      // Wait for its animation to end before removing the element
      elementToRemove.addEventListener("animationend", function () {
        event.target.performAction();
      });
    }
  }
});
