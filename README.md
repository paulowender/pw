<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Este pacote tem por finalidade fornecer uma abstração dos principais componentes do flutter de forma a acelerar o desenvolvimento como um mini framework, provendo controle de tema e padrões de layout.

## Features

Theme Controller
Theme Switch Button
Buttons
Fields

## Getting started

Este pacote tem algumas dependências que precisam ser consideradas, como por exemplo o Get e Get storage.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
// THEME Controller
final pw = PWThemeController();
pw.isDark? // true or false
pw.theme // = isDark? PWTheme.light : PWTheme.dark

// To change theme in any screen
PWThemeSwitch() // => SwitchListTile
PWThemeSwitch(icoMode: true) // => IconButton
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
