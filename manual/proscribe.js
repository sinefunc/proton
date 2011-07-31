$(function () {
  $("h4").each(function() {
    var $this = $(this);

    // Find the next p
    var $p    = $this.find('+ p');
    if (!$p.length) { $p = $this; }

    var $pre = $p.find('+ pre');
    if (!$pre.length) { return; }

    // Build it
    var $el   = $("<section class='literate'>");
    $this.before($el);

    // Move them
    $el.append($pre);
    $el.append($this);
    $el.append($p);
  });

  $("pre").each(function() {
    var $this = $(this);
    $this.addClass('prettyprint');

    // Filename
    var r = /\[(.*?)\s*\((.*?)\)\]\n*/;
    var m = $this.text().match(r);
    if (m) {
      var file = m[1];
      var type = m[2];
      $this.addClass('lang-'+type);

      if (file.length) {
        $this.addClass('has-caption');
        $this.prepend($("<h5 class='caption'>").text(file));
      }

      $this.html($this.html().replace(r, ''));
    }

    // Terminal
    if ($this.text().match(/^\s*([a-zA-Z_~\/]*)\$ /)) {
      $this.addClass('terminal');
      $this.removeClass('prettyprint');
      $this.html($this.html().replace(/([a-zA-Z_~\/]*\$ )(.*?)[\r\n$]/g, "<strong><em>$1</em>$2</strong>\n"));
    }
  });

  prettyPrint();
});

