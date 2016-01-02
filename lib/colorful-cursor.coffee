class ColorfulCursor
  COLOR_CODE_LENGTH    = 6
  COLOR_LEVEL_MULTIPLE = 3
  HEX                  = 16
  INDEX_OFFSET         = 1

  activate: (state) ->
    atom.config.colorfulCursor = {}
    atom.config.colorfulCursor.color = 'ffffff'

    setInterval ->
      textEditor = atom.workspace.getActiveTextEditor()
      view = atom.views.getView(textEditor)
      if view?.shadowRoot
        classList = view.shadowRoot.
          querySelector('.cursors').classList
        classList.add 'colorful-cursor'
        view.shadowRoot.querySelector('.cursors .cursor')?.
          style.backgroundColor = "##{atom.config.colorfulCursor.color}"
        view.onkeydown = (e) ->
          convertedKeyCode = e.keyCode * COLOR_LEVEL_MULTIPLE
          setColor(convertedKeyCode)

      setColor = (value) ->
        newColor = atom.config.colorfulCursor.color
        newColor = newColor.concat(value.toString(HEX))
        startOffset = newColor.length - COLOR_CODE_LENGTH - INDEX_OFFSET
        endOffset = startOffset + COLOR_CODE_LENGTH
        newColor = newColor.substring(startOffset, endOffset)
        atom.config.colorfulCursor.color = newColor

module.exports = new ColorfulCursor()
