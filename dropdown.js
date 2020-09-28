document.addEventListener("DOMContentLoaded", function(e) {
    console.log("hello");
    var acc = document.getElementsByClassName("accordion");
    console.log(acc);
    console.log(acc.length);
    var i;


    for (i = 0; i < acc.length; i++) {

    acc[i].addEventListener("click", function() {
      /* Toggle between adding and removing the "active" class,
      to highlight the button that controls the panel */
      this.classList.toggle("active");

      if (this.classList.contains('active')){
        console.log('active');
        this.innerHTML = "Hide Files";
      } else {
        console.log('inactive');
        this.innerHTML = "Show Files";
      }
      /* Toggle between hiding and showing the active panel */
      var panel = this.nextElementSibling;
      if (panel.style.display === "block") {
        panel.style.display = "none";
      } else {
        panel.style.display = "block";
      }
    });
    }
})