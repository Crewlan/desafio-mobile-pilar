# Mobile Challenge 🏅 2023 - Dictionary

> This is a challenge by [Coodesh](https://coodesh.com/)


## Introdução App Dictionary

O app Dictionary é um aplicativo que traz mais de 370k de palavras em inglês e com o uso de uma api para buscar o significado dela.

Alerta! A api usada do rapidapi não é completa e algumas palavras simplesmente nao tem cadastradas la ainda.
E algumas palavras ele traz um resultado diferente como pronuncia dentro de um objeto e momento vem como uma string direto

ex: pronunciation {"all": "something"}  e as vezes vem como pronunciation: "something" e isso acaba quebrando o app.

## Como rodar o projeto
 
Versão de flutter utilizada -> 3.10.6 (recente)

Você pode baixar o [Flutter](https://flutter.dev/docs/get-started/install) seguindos as orientações no site.

Após isso você pode clonar o projeto ou baixar o zip e descompactar.
Abrindo o projeto não se esqueça de dar um `flutter pub get` no terminal e aguardar o projeto pegar todas dependencias do `pubspec.yaml`.
Após isso basta rodar o projeto em seu aparelho conectao a um cabo usb ou em um emulador. Caso não tenha emulador olhe este [guia](https://www.fluttercampus.com/tutorial/4/run-first-application/).

Ou você pode baixar este apk e testar em seu aparelho ou emulador.
[APK](https://drive.google.com/file/d/1lT13-LVEbUpXJraJsFy6G6caHdD2HmBR/view?usp=sharing).

Ou se utilizar macOS, pode rodar no emulador de Iphone normalmente.

### Testes

 - Neste projeto foram realizado testes unitarios desde a camada de datasources até o bloc para gerenciar os estados.
   Para rodar os testes bastar digitar `flutter test` no seu terminal do projeto e aguardar.

### Mais informações
- Este projeto foi desenvolvido usando a Arquitetura limpa seguindo os principios de [Uncle Bob's](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html). 
- [Flutter](https://flutter.dev/)
- [Bloc](https://bloclibrary.dev/#/gettingstarted)

### Bibliotecas e plugins utilizados

 - [bloc (state management)](https://pub.dev/packages/bloc)
 - [get_it (Dependency Injections)](https://pub.dev/packages/get_it)
 - [google_fonts](https://pub.dev/packages/google_fonts)
 - [connectivity_plus](https://pub.dev/packages/connectivity_plus)
 - [equatable (Simplify Equality Comparisons)](https://pub.dev/packages/equatable)
 - [http](https://pub.dev/packages/http)
 - [http_interceptor](https://pub.dev/packages/http_interceptor)
 - [dartz (for Functional programming)](https://pub.dev/packages/dartz)
 - [material_design_icons_flutter](https://pub.dev/packages/material_design_icons_flutter)
 - [floor (SQLite database based in Room)](https://pub.dev/packages/floor)
 - [firebase_remote_config](https://pub.dev/packages/firebase_remote_config)
 - [firebase_core](https://pub.dev/packages/firebase_core)
 - [flutter_tts (For Text to Speech)](https://pub.dev/packages/flutter_tts)
 - [another_flushbar (For Snackbars)](https://pub.dev/packages/another_flushbar)

 #  Bibliotecas de desenvolvimento
  - [flutter_lints](https://pub.dev/packages/flutter_lints)
  - [mocktail (For unit tests)](https://pub.dev/packages/mocktail)
