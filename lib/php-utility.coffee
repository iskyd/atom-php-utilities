PhpGetterSetter = require('./utilities/php-getter-setter')

module.exports =
class PhpUtility
  constructor: (state) ->
    @editor = atom.workspace.getActiveTextEditor()
    @editor.setTabLength(4)
    @getterSetter = new PhpGetterSetter()
  generateGetterSetter: (focus) ->
    if @editor
      selection = @editor.getSelectedText()
      if selection
        @getterSetter.setVariable(this.removeCharacters(selection))
        if !@getterSetter.existGetter()
          @editor.moveToBottom()
          @editor.insertNewline()
          getter = @getterSetter.getGetter()
          @editor.insertText(getter)
        if !@getterSetter.existSetter()
          @editor.moveToBottom()
          @editor.insertNewline()
          setter = @getterSetter.getSetter()
          @editor.insertText(setter)
        @editor.save()
  removeCharacters : (string) ->
    return string.replace('$', '')
