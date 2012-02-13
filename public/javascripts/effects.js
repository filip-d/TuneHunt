var userAgent = navigator.userAgent.toLowerCase();
var isIphone = userAgent.indexOf("iphone") > -1 || userAgent.indexOf("ipad") > 0 || userAgent.indexOf("ipod") > 0;
var isIOS3 = isIphone ? userAgent.indexOf("os 3_") > -1 : false;
var isMozilla = userAgent.indexOf("mozilla") > -1;
var mPlayerMode = 0;
var mPlayerType = undefined;
var logging = false;
var killClick = false;
$(document).ready(function () {
	window.scrollTo(0, 1);
	if (window.location.hash) {
		$("tr#" + window.location.hash).addClass("highlight")
	}
	if (isIphone) {
		$("a:not([rel])").live("click", function (c) {
			c.preventDefault();
			window.location = $(this).attr("href")
		})
	}
	$("a.toggle").live("click", function () {
		$expander = $(this).closest(".expander");
		$expander.toggleClass("open");
		window.location.hash = $(this).attr("href")
	});
	$("a.disabled").not(".info").bind("click", function () {
		return false
	});
	$("body").bind("click", function (c) {
		if (killClick) {
			if (c.preventBubble) {
				c.preventBubble()
			}
			if (c.preventDefault) {
				c.preventDefault()
			}
			if (c.stopPropagation) {
				c.stopPropagation()
			}
			if (c.stopImmediatePropagation) {
				c.stopImmediatePropagation()
			}
			killClick = false;
			return false
		}
	});
	$("table.expander").removeClass("locked");
	$("table.expander").toggleClass("open");
	$('a[rel="popup"]').live("click", function () {
		var d = $(this).attr("href");
		var c = $("div#overlay");
		c.empty();
		var e = $("<div>").appendTo(c).addClass("popup loading");
		if (isIphone) {
			c.css({top:window.pageYOffset + "px", position:"absolute", height:"200%"});
			e.css({top:+window.pageYOffset + "px"})
		}
		c.show();
		e.load(d, function () {
			$(this).removeClass("loading")
		});
		return false
	});
	$('a[rel="close"]').live("click", function () {
		$("div#overlay").empty().hide();
		return false
	});
	$("div#overlay").live("click", function () {
		$("div#overlay").empty().hide()
	});
	$("div#overlay").bind("touchstart", function (d) {
		var c = $(d.target);
		if (c.is("a") && c.parents(".popup").length) {
			c.trigger("click")
		} else {
			killClick = true
		}
		return false
	});
	$("div.popup form").live("submit", function () {
	});
	$('a[rel="basket"]').live("click", function () {
		if (!$(this).is(".in_basket")) {
			var c = $("#basket_stub");
			var d = $(this);
			c.addClass("loading");
			d.addClass("loading");
			c.load(d.attr("href"), function () {
				$(this).removeClass("loading");
				d.removeClass("loading");
				d.addClass("in_basket");
				if (d.is(".release")) {
					$("a.buy").addClass("in_basket")
				}
			})
		}
		return false
	});
	$("input#voucher_code").live("focus", function () {
		oldVoucher = $(this).val();
		$(this).val("")
	});
	$("input#voucher_code").live("blur", function () {
		if ($(this).val() == "") {
			$(this).val(oldVoucher)
		}
	});
	$("form.search").bind("submit", function () {
		if ($("input#q", this).val()) {
			return true
		} else {
			return false
		}
	});
	$("a.download").live("click", function () {
		var c = $(this);
		var d = c.parents("[id]:first").attr("id");
		_gaq.push(["_trackEvent", "download", $("body").attr("class"), d])
	});
	var a = $("#player").mPlayer();
	if (a) {
		$("a.playlist.play").css("display", "block");
		mPlayerMode = a.mode();
		var b = {id:null, index:-1, entries:[], current:function () {
			return this.entries[this.index]
		}, controls:function (d) {
			if (this.id) {
				if (typeof d == "object") {
					d = d.join(", .")
				}
				var c = this.current().add($('a.playlist[href="' + this.id + '"]'));
				return d ? c.filter("." + d) : c
			} else {
				return jQuery()
			}
		}, clear:function () {
			a.trigger("listended");
			this.id = null;
			this.index = -1;
			this.entries = [];
			a.trigger("listcleared")
		}, add:function (c) {
			this.entries.push(c);
			this.index = this.index < 0 ? 0 : this.index
		}, next:function () {
			if (this.entries && this.index < (this.entries.length - 1)) {
				this.index++;
				a.trigger("listnext");
				return this.current()
			} else {
				return null
			}
		}, prev:function () {
			if (this.entries && this.index > 0) {
				this.index--
			}
			a.trigger("listprev");
			return this.current()
		}};
		$('a[rel="player"]').live("click", function () {
			var d = $(this);
			if (d.is(".next")) {
				b.next()
			} else {
				if (d.is(".prev")) {
					b.prev()
				} else {
					if (d.is(".playing")) {
						a.pause()
					} else {
						if (d.is(".paused")) {
							a.play()
						} else {
							b.clear();
							if (d.is(".playlist")) {
								b.id = $(this).attr("href");
								$("a.play:not(.playlist)", b.id).each(function () {
									b.add($(this))
								})
							} else {
								b.id = d.parents("[id]:first").attr("id");
								b.add(d)
							}
							a.setFile(b.current().attr("href"));
							if (d.is(".preview")) {
								var c = "preview"
							} else {
								var c = "play"
							}
							_gaq.push(["_trackEvent", c, $("body").attr("class"), b.id.replace("#", ""), mPlayerMode])
						}
					}
				}
			}
			d.blur();
			return false
		});
		a.live("loadstart", function (c) {
			log("loadstart");
			b.controls("play").removeClass("playing").removeClass("paused").addClass("loading");
			if (b.entries.length > 1) {
			}
		});
		a.live("playing", function (c) {
			log("playing");
			b.controls("play").removeClass("paused").removeClass("loading").addClass("playing")
		});
		a.live("pause", function (c) {
			log("paused");
			b.controls("play").removeClass("loading").removeClass("playing").addClass("paused")
		});
		a.live("ended", function (c) {
			log("track ended");
			b.controls("play").removeClass("paused").removeClass("loading").removeClass("playing");
			if (b.entries && b.index < (b.entries.length - 1)) {
				b.next()
			} else {
				a.trigger("listended")
			}
		});
		a.live("listnext", function (c) {
			log("next track");
			$("a.play").removeClass("paused").removeClass("loading").removeClass("playing");
			a.setFile(b.current().attr("href"))
		});
		a.live("listprev", function (c) {
			log("prev track");
			$("a.play").removeClass("paused").removeClass("loading").removeClass("playing");
			a.setFile(b.current().attr("href"))
		});
		a.live("listended", function (c) {
			log("playlist ended");
			$("a.play").removeClass("paused").removeClass("loading").removeClass("playing");
			b.controls(["next", "prev"]).hide("fast")
		});
		a.live("listcleared", function (c) {
			log("playlist cleared");
			$("a.play").removeClass("paused").removeClass("loading").removeClass("playing")
		})
	}
});
function log(b) {
	if (logging) {
		var c = $("ol#console").length ? $("ol#console") : $('<ol id="console" >').appendTo("body");
		var a = $("li", c).first().attr("value") || 0;
		a++;
		c.prepend('<li value="' + a + '">' + b || "[null]</li>")
	}
}
jQuery.fn.extend({insertAtCaret:function (a) {
	return this.each(function (d) {
		if (document.selection) {
			this.focus();
			sel = document.selection.createRange();
			sel.text = a;
			this.focus()
		} else {
			if (this.selectionStart || this.selectionStart == "0") {
				var c = this.selectionStart;
				var b = this.selectionEnd;
				this.value = this.value.substring(0, c) + a + this.value.substring(b, this.value.length);
				this.selectionStart = c + a.length;
				this.selectionEnd = c + a.length
			} else {
				this.value += a;
				this.focus()
			}
		}
	})
}});
jQuery.fn.extend({deleteAtCaret:function (a) {
	return this.each(function (d) {
		if (this.selectionStart || this.selectionStart == "0") {
			var c = this.selectionStart;
			var b = this.selectionEnd;
			if (c != b) {
				this.value = this.value.substring(0, c) + this.value.substring(b, this.value.length)
			} else {
				if (a == 1) {
					this.value = this.value.substring(0, c) + this.value.substring(b, this.value.length).substr(1)
				} else {
					this.value = this.value.substring(0, c).slice(0, -1) + this.value.substring(b, this.value.length);
					if (c > 0) {
						c--
					}
				}
			}
			this.selectionStart = c;
			this.selectionEnd = c
		}
	})
}});