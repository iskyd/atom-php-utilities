module.exports =
class PhpGetterSetter
  constructor: (state) ->
    @editor = atom.workspace.getActiveTextEditor()
    @config =
      getterTemplate:
        type: 'string'
        scope: 'public'
        default:"
          \ \ \ \ /**\n
          \ \ \ \ * Get the value of %variable% \n
          \ \ \ \ * \n
          \ \ \ \ * @return %type%\n
          \ \ \ \ */\n
          \ \ \ %scope% function %methodName%()\n
          \ \ \ {\n
          \ \ \ \ \ \ \ return $this->%variable%;\n
          \ \ \ }\n
          \n"
      setterTemplate:
        type: 'string'
        scope: 'public'
        typeHint: ''
        default: "
          \ \ \ \ /** \n
          \ \ \ \ * Set the value of %variable% \n
          \ \ \ \ * \n
          \ \ \ \ * @param %type% $%variable%\n
          \ \ \ \ * \n
          \ \ \ \ * @return self\n
          \ \ \ \ */\n
          \ \ \ %scope% function %methodName%(%typeHint%$%variable%)\n
          \ \ \ {\n
          \ \ \ \ \ \ \ $this->%variable% = $%variable%;\n
          \n
          \ \ \ \ \ \ \ return $this;\n
          \ \ \ }\n
          \n"
  setVariable: (variable) ->
    @variable = variable
  existGetter: () ->
    if this.editor
      text = this.editor.getText()
      methodName = 'function ' + this.getGetterMethodName()
      if text.search(methodName) != -1
        return true
      return false
  existSetter: () ->
    if this.editor
      text = this.editor.getText()
      methodName = 'function ' + this.getSetterMethodName()
      if text.search(methodName) != -1
        return true
      return false
  getGetter: () ->
    if !this.variable
      return false

    console.log(this.variable)
    return this.config.getterTemplate.default
      .replace(/%variable%/g, this.variable)
      .replace(/%type%/g, this.config.getterTemplate.type)
      .replace(/%methodName%/g, this.getGetterMethodName())
      .replace(/%scope%/g, this.config.getterTemplate.scope)
  getSetter: () ->
    if !this.variable
      return false

    return this.config.setterTemplate.default
      .replace(/%variable%/g, this.variable)
      .replace(/%type%/g, this.config.setterTemplate.type)
      .replace(/%methodName%/g, this.getSetterMethodName())
      .replace(/%scope%/g, this.config.setterTemplate.scope)
      .replace(/%typeHint%/g, this.config.setterTemplate.typeHint)
  getGetterMethodName: () ->
    return 'get' + this.capitalizeFirstLetter(this.variable)
  getSetterMethodName: () ->
    return 'set' + this.capitalizeFirstLetter(this.variable)
  capitalizeFirstLetter: (string) ->
    return string.charAt(0).toUpperCase() + string.slice(1)
