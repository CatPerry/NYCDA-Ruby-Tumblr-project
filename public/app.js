
let closeButton = document.querySelectorAll(".close-button")
let flashPanel = document.querySelector(".flash")

closeButton.addEventListener("click", event => {
  event.preventDefault()
  flashPanel.classList.add(".hide")
});

window.addEventListener("scroll", function () {
        let nav = document.getElementById("nav")
        let sticky = nav.offsetTop;

        function stickyNav() {
            if (window.pageYOffset >= sticky) {
                nav.classList.add("sticky")
            } else {
                nav.classList.remove("sticky")
            }
        } stickyNav()
    });