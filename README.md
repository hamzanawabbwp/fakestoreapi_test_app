# Test App Flutter Application

This is the **Test App** Flutter project, designed to manage products and a shopping cart. It features product listings, product details, and the ability to add items to a cart, including checkout functionality.

## Features
- **Product Listing**: Displays a list of products with images, prices.
- **Product Details**: Detailed view of each product including a description and price.
- **Cart Management**: Add or remove products from the cart.
- **Checkout**: Navigate to a checkout page from any screen.

## Setup Instructions

### Requirements
- Flutter SDK: 3.22.2  [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart 3.4.3
- Android Studio or Visual Studio Code (Recommended)

### Steps to Run the Project

1. **Clone the Repository**:

2. **Install Dependencies**:
Ensure that all the required Flutter dependencies are installed by running the following command:
```bash
flutter pub get



### Short Write-Up

#### Technical Decisions:
- The **Provider** package was chosen for its simplicity and performance in managing the state of the cart and products globally across the app. By using `ChangeNotifier`, the app efficiently updates the UI when there are changes in cart data.
  
- To provide a smooth and interactive user experience, the **MotionToast** package was integrated, offering success and error toasts to notify users when they add a product to the cart or when there is an issue.

- For fetching and displaying products, `FutureBuilder` is used to handle asynchronous requests and show appropriate loading indicators, which keeps the UI responsive and user-friendly.
