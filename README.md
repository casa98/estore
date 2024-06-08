# Project Documentation: Estore App

## Versioning Information

- **Flutter**: 3.19.6 (Channel stable)
- **Dart**: 3.3.4

## Data Models Design

This project contains two data models to represent the products and categories fetched from the API (`https://fakestoreapi.com`). These models are located in the `lib/models/` folder and are implemented in the following files:

### product_model.dart
This file defines the structure of a product, its attributes (`id`, `title`, `price`, `category`, `description`, `image`). It also provides a `fromJson` method to facilitate the conversion from JSON format to a `ProductModel` Dart object.

### category_model.dart
This file defines the structure of a category, which includes a single attribute `name`. It also includes a `fromJson` method.

## API Request and Processing

API requests and processing are managed in the `lib/services/product_service.dart` file. This file contains methods to fetch products, categories, and product details using HTTP requests. The `http` package is used to perform these requests.

### product_service.dart

Three main methods are defined to interact with the API:

- `getProducts()`: Fetches list of products.
- `getCategories()`: Fetches list of categories.
- `getProductById(int id)`: Fetches details of a specific product by its ID.

Each method performs an HTTP request and converts the JSON response into the corresponding data models.

## Error Handling with Either
HTTP Requests error handling in this project is managed using the `dartz` library, specifically the `Either` type. This type is used to represent a value that can be either a success (`Right`) or a failure (`Left`). This approach allows that API errors are handled properly in a more elegant way. 


### Additional notes
Another solution to manage errors without using a package, could've been using `Success` and `Failure` classes, which would extend a `sealed class` and allow us to manage errors similarly.
