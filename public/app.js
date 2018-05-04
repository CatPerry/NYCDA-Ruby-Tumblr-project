
let closeButton = document.querySelectorAll(".close-button")
let flashPanel = document.querySelector(".flash")

closeButton.addEventListener("click", event => {
  event.preventDefault()
  flashPanel.classList.add(".hide")
});

window.addEventListener("scroll", function () {
        let nav = document.getElementById("#nav")
        let sticky = nav.offsetTop;

        function stickyNav() {
            if (window.pageYOffset >= sticky) {
                nav.classList.add("sticky")
            } else {
                nav.classList.remove("sticky")
            }
        } stickyNav()
    });

let video = document.getElemnetById("videoloop");

let button = document.getElementById("vidbutton");

function playPause() {
  if (video.paused) {
    video.play();
    button.innerHTML = "Pause";
  } else {
    video.pause();
    button.innerHTML = "Play";
  }
}