javascript:(function(){
  var v = "2.0.0";

  var submit = function() {
    $.ajax({
      url: "http://my-epub.loc:3000/api/articles",
      method: "POST",
      data: {
        url: window.location.href
      }
    });
  };

  if (window.jQuery === undefined || window.jQuery.fn.jquery < v) {
    var done = false;
    var script = document.createElement("script");
    script.src = "http://ajax.googleapis.com/ajax/libs/jquery/" + v + "/jquery.min.js";
    script.onload = script.onreadystatechange = function() {
      if (!done && (!this.readyState || this.readyState == "loaded" || this.readyState == "complete")) {
        done = true;
        submit();
      }
    };
    document.getElementsByTagName("head")[0].appendChild(script);
  } else {
    submit();
  }
})();
