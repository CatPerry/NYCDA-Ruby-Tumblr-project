let slideIndex = 0;

function carousel() {

  let x = document.getElementsByClassName("mainimg");

  for (let i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  slideIndex++;
  if (slideIndex > x.length) {
    slideIndex = 1
  }
  x[slideIndex-1].style.display = "block";
  setTimeout(carousel, 3000);
}
carousel();


window.addEventListener("scroll", function () {

  function stickyNav() {
    let nav = document.querySelector("nav")
    let sticky = nav.offsetTop;
      if (window.scrollY <= nav) {
        nav.classList.add("sticky")
      } else {
        nav.classList.remove("sticky")
      }
  } stickyNav();
});





// let flash = document.getElementsByClassName(".flash")
// function disappearFlash() {
//   setTimeout(function() {
//     flash.remove();
//     }, 5000);
//  })