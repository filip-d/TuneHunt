/**
 * @author Ola Tuvesson
 * @copyright mikrogroove Limited
 */

(function($) {
  jQuery.fn.mPlayer = function(options) {
      var uiObj = this;
      var playerObj = undefined;

      var htmlPlayer = function() {
        try {
          playerObj = new Audio();
        } catch(e) {
          return null;
        }
        if(playerObj.canPlayType && playerObj.canPlayType("audio/mpeg;").replace(/no/, false)) {
          playerObj.setFile = function(file) {
            playerObj.src = file;
            playerObj.load();

          }
          playerObj.addEventListener("loadstart", function() {
            if(playerObj.src) {
              uiObj.trigger("loadstart");
            }
          },false);
          playerObj.addEventListener("canplay", function() {
             playerObj.play();
          },false);
          playerObj.addEventListener("playing", function() {
            uiObj.trigger("playing");
          },false);
          playerObj.addEventListener("pause", function() {
            isIOS3 ? $(playerObj).trigger("ended",[]) : uiObj.trigger("pause");
          },false);
          playerObj.addEventListener("ended", function() {
            uiObj.trigger("ended");
          },false);
          playerObj.mode = 2
          return playerObj;
        } else {
          return null;
        }
      };

      var flashPlayer = function() {
        if(canUseFlash()) {
          var swf = "/javascripts/mplayer-0.0.1.swf";
          playerObj = document.createElement("object");
              playerObj.setAttribute("type", "application/x-shockwave-flash");
              playerObj.setAttribute("data", swf);
              playerObj.setAttribute("width", 1);
              playerObj.setAttribute("height", 1);
          var params = [{"name":"movie","value":swf},{"name":"allowScriptAccess","value":"always"}];
          $.each(params, function() {
            var param = document.createElement("param");
            param.setAttribute("name",this.name);
            param.setAttribute("value",this.value);
            playerObj.appendChild(param);
          });
          playerObj.setFile = function(file) {
            playerObj.src(file);
            playerObj.play();
          }
          playerObj.mode = 1
          return playerObj;
        } else {
          return null;
        }
      }

      var canUseFlash = function() {
        if (navigator.plugins && navigator.plugins.length) {
          for (n = 0; n < navigator.plugins.length; n++) {
            if (navigator.plugins[n].name.indexOf("Shockwave Flash") != -1) {
              return true;
            }
          }
        }
        try {
          new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
          return true;
        } catch(e) {
          return false;
        }
      }

      uiObj.play = function() {
        playerObj.play();
      }
      uiObj.pause = function() {
        playerObj.pause();
      }
      uiObj.stop = function() {
        if(playerObj.playing) {
          playerObj.stop();
        }
      }
      uiObj.setFile = function(file) {
        playerObj.setFile(file);
      }
      uiObj.mode = function() {
        return playerObj.mode;
      }

      var playerObj = htmlPlayer() || flashPlayer();
      if(playerObj) {
        playerObj.setAttribute("id", "playerObj");
        $(this).append(playerObj);
        return this;
      } else {
        return null;
      }

  }
})(jQuery);