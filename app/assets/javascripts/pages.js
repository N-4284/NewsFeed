
document.addEventListener("turbo:load", function() {
  // Get references to the open and close buttons and the iframe container
  var openButton = document.getElementById("toggleOpenButton");
  var avatar = document.getElementById("avatar");
  var closeButton = document.getElementById("toggleCloseButton");
  var iframeContainer = document.getElementById("iframeContainer");

  // Add click event listener to the open button
  openButton.addEventListener("click", function() {
    console.log("open"+open);
    // Toggle visibility of the iframe container
    if (iframeContainer.style.display === "none") {
      iframeContainer.style.display = "block";
    } else {
      iframeContainer.style.display = "none";
    }
  });

  // Add click event listener to the close button
  closeButton.addEventListener("click", function() {
      iframeContainer.style.display = "none";
  });

  // Add click event listener to the document to close the iframe when clicking outside
  document.addEventListener("click", function(event) {
    if ( event.target !== openButton && event.target !== avatar  ) {
      console.log(event.target+"<>"+avatar);
      iframeContainer.style.display = "none";
      open = false;
    }
  });

});
