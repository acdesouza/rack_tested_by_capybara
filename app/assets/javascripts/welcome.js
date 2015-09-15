var btnHello = document.getElementById("hello");
btnHello.addEventListener('click', function(e) {
    var greetingHeader = document.getElementById("greeting");
    var userName = document.getElementById("user_name").value;

    if(userName.trim() !== "") {
      greetingHeader.innerHTML = "Welcome, "+ userName +"!";
    } else {
      greetingHeader.innerHTML = "Welcome!";
    }
});
