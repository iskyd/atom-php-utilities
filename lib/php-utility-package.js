const {Disposable, CompositeDisposable} = require('atom')
const path = require('path')

const PhpUtility = require('./php-utility')

module.exports =
class PhpUtilityPackage {
  activate () {
    this.disposables = new CompositeDisposable()
    this.disposables.add(atom.commands.add('atom-workspace', {
      'php-utility:generate-getter-setter': () => this.getPhpUtilityInstance().generateGetterSetter(),
    }))
  }

  deactivate () {
    this.disposables.dispose()
    this.phpUtility = null
  }

  getPhpUtilityInstance (state = {}) {
    if (this.phpUtility == null) {
      this.phpUtility = new PhpUtility()
    }
    return this.phpUtility
  }
}
