# flutter_application

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Instalación

Comprobar de manera local con el terminar este funcionando y en check lo siguiente: flutter doctor, paso siguiente npm install.

Abrir el siguiente archivo: lib/main.dart

- Ejecutar F5 o el siguiente comando en terminar flutter run

# Recomendaciones

Se hizo uso de firebase y de tecnologia GPS por lo cual se tuvo tocar la carpeta android/ , en la cual para que funcione con su firebase requerira modificarlo donde corresponda.

> Explicando la carpeta lib

Se utilizo la arquitectura Clean Code MVCS, por lo cual incoorpora lo siguiente:

- Vistas: Todo lo que aparecera
- Controllers: Recibe lo que envian por las vistas y le envia de igual manera
  - Actualizar la url del archivo lib/controller/controller.dart según corresponda.
- Services: Interactura con el controlador para conectar con la BD o Api Rest (authenticator, peticiones)
- Models: Transforma la información que recibe del controlador para devolverle (abstracts,common,mappers,modelos)

Flutter 3.4.0-17.2.pre • channel dev • https://github.com/flutter/flutter.git

Framework • revision d6260f127f (5 months ago) • 2022-09-21 13:33:49 -0500

Engine • revision 3950c6140a

Tools • Dart 2.19.0 (build 2.19.0-146.2.beta) • DevTools 2.16.0
