//     jqXMLParser.js 0.1.0
//     https://github.com/nim579/jqXMLParser
//     (c) 2015 Nick Iv (studio@nim579.ru)
//     jqXMLParser may be freely distributed under the  license.
window.XMLParser = {
  parse: function(xml) {
    var $xml, result;
    $xml = $('<xml_container>' + xml + '</xml_container>');
    result = this._parser($xml);
    return result;
  },
  _parser: function($node) {
    var $children, result;
    result = null;
    if ($node.children().length > 0) {
      result = {};
      $children = $node.children();
      $children.each((function(_this) {
        return function(index, el) {
          var elContent;
          elContent = _this._parser($(el));
          if (result[el.tagName.toLowerCase()] != null) {
            if (!_.isArray(result[el.tagName.toLowerCase()])) {
              result[el.tagName.toLowerCase()] = [result[el.tagName.toLowerCase()]];
            }
            return result[el.tagName.toLowerCase()].push(elContent);
          } else {
            return result[el.tagName.toLowerCase()] = elContent;
          }
        };
      })(this));
    } else {
      result = this._textTyper($node.text());
    }
    return result;
  },
  _textTyper: function(text) {
    text = text.trim();
    if (!_.isNaN(Number(text)) && text !== "") {
      text = Number(text);
    } else {
      if (text.toLowerCase() === 'true') {
        text = true;
      } else if (text.toLowerCase() === 'false') {
        text = false;
      }
    }
    return text;
  }
};
