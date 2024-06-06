# Estore

Flutter project for practising and learning purposes.
This app is an in-progress work, whose new features will be added in feature branches, and integrated into ```main``` branch when approved.

## Vesioning
- Flutter 3.19.6 (Channel stable)
- Dart 3.3.4


## Additional notes
Aplicación básica que permite registrar, actualizar, y eliminar productos, los cuales se mantienen únicamente en el estado.
La aplicación permite lsitar los productos creados y ver sus detalles.

Se usa ```Provider``` para el manejo del estado, el cual nos permite tener siempre actualizada la lista de productos que se muestra.
Gracias a ```Provider``` también, separamos lo que es la UI de la lógica, la cual consiste en operaciones CRUD para el manejo de los productos.