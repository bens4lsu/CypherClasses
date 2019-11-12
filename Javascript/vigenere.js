
var Vigenere = {

    keyword : null,

    characterSet: function(xchar) {
        var lcLetters = "abcdefghijklmnopqrstuvwxyz";
        var ucLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        if (lcLetters.indexOf(xchar) >= 0) {
            return lcLetters;
        }
        else if (ucLetters.indexOf(xchar) >= 0) {
            return ucLetters;
        }
        else {
            return false;
        }   
    },
    
    initTransform: function(xchar, position) {
        var keyword = Vigenere.keyword;
        var noxform = false;
        var letters = Vigenere.characterSet(xchar);
        var pos = position % keyword.length;
        var kwLetters = Vigenere.characterSet(keyword.substr(pos, 1));
        if (! keyword || ! letters || ! kwLetters) {
            noxform = true;
            return {noxform: true};
        }
        var charIndex = letters.indexOf(xchar);
        var letterOffset = kwLetters.indexOf(keyword.substr(pos, 1));
        return {noxform: false, charIndex: charIndex, letterOffset: letterOffset, letters: letters};
    },


    transformCharacter: function(xchar, position) {
        var xform = Vigenere.initTransform(xchar, position);
        console.log(xform);
        if (xform.noxform) {
            return xchar;
        }
        var newOffset = xform.charIndex + xform.letterOffset >= 26 ? xform.charIndex + xform.letterOffset - 26 : xform.charIndex + xform.letterOffset;
        return xform.letters[newOffset];
    },
    
    untransformCharacter: function(xchar, position) {
        var xform = Vigenere.initTransform(xchar, position);
        if (xform.noxform) {
            return xchar;
        }
        var newOffset = xform.charIndex + xform.letterOffset >= 26 ? xform.charIndex + xform.letterOffset - 26 : xform.charIndex + xform.letterOffset;
        return xform.letters[newOffset]; 
    },
    
    transformString: function(str){
        if (! Vigenere.keyword){
            return "";
        }
        result = "";
        for (var i = 0; i < str.length; i++) {
          result += Vigenere.transformCharacter(str.charAt(i), i);
        }
        return result;
    },
    
    untransformString: function(str){
        if (! Vigenere.keyword){
            return "";
        }
        result = "";
        for (var i = 0; i < str.length; i++) {
          result += Vigenere.untransformCharacter(str.charAt(i), i);
        }
        return result;
    }
    
};
