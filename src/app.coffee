window.XMLParser =
    parse: (xml)->
        $xml = $('<xml_container>'+xml+'</xml_container>')
        result = @_parser $xml
        return result

    _parser: ($node)->
        result = null

        if $node.children().length > 0
            result = {}
            $children = $node.children()
            $children.each (index, el)=>
                elContent = @_parser $(el)
                if result[el.tagName.toLowerCase()]?
                    unless _.isArray result[el.tagName.toLowerCase()]
                        result[el.tagName.toLowerCase()] = [result[el.tagName.toLowerCase()]]

                    result[el.tagName.toLowerCase()].push elContent

                else
                    result[el.tagName.toLowerCase()] = elContent

        else
            result = @_textTyper $node.text()

        return result

    _textTyper: (text)->
        text = text.trim()

        if not _.isNaN(Number(text)) and text isnt ""
            text = Number text

        else
            if text.toLowerCase() is 'true'
                text = true

            else if text.toLowerCase() is 'false'
                text = false

        return text
