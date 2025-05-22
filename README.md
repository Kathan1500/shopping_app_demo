---

# 📱 Flutter Fashion Store App

A beautifully styled, all-in-one Flutter fashion shopping app inspired by SHEIN. This mobile application includes visually rich product cards, dynamic size selection, cart functionality, and a smooth checkout flow — all implemented in a single `main.dart` file.

---

## 🧩 Key Features

### 1. Home Catalog

* Displays trending fashion items (e.g., dress, jacket, sneakers)
* Clean product card layout with name, price, image
* Background colors match product aesthetics
* Tappable to navigate to product detail

### 2. Product Detail Page

* Large product image with graceful error fallback
* Dynamic size selection (e.g., S, M, L, XL)
* Quantity selector (+/- buttons)
* Add-to-cart button with feedback snackbar

### 3. Cart Management

* All selected items grouped by size
* Update quantity or remove items inline
* Real-time total cost calculation
* Checkout simulation with success snackbar

### 4. Visual Design

* Inspired by SHEIN/modern fashion shops
* Rounded cards, subtle shadows, pastel backgrounds
* Fonts, layout, and color usage polished for a soft, elegant feel

### 5. Single File Project

* Entire logic in `main.dart`
* Simple for small projects or academic submission

### 6. Data Driven Setup

* Easily modify or expand product list (just change the `products[]` list)
* Each product includes: ID, name, price, image, sizes, background color

### 7. Flutter Ready

* Compatible with latest Flutter 3.x stable builds
* Works on Android emulator, iOS simulator, or Chrome Web

---

## ⚙️ Setup Instructions

### 📦 Prerequisites

* Flutter SDK (3.x recommended)
* Dart SDK (included with Flutter)
* IDE: VS Code or Android Studio

### 🛠 Steps to Run the App

1. **Copy the main.dart** file into `/lib/main.dart`.

2. **Create an `assets/` folder** and add product images:

   ```
   assets/
   ├── dress.png
   ├── jacket.png
   ├── sneakers.png
   ├── bag.png
   └── sunglasses.png
   ```

3. **Update `pubspec.yaml`**:

   ```yaml
   flutter:
     assets:
       - assets/dress.png
       - assets/jacket.png
       - assets/sneakers.png
       - assets/bag.png
       - assets/sunglasses.png
   ```

4. **Run the app**:

   ```bash
   flutter pub get
   flutter run
   ```

---

## 📁 Project Structure

```
lib/
└── main.dart            # All-in-one file (UI + logic)

assets/
├── dress.png
├── jacket.png
├── sneakers.png
├── bag.png
└── sunglasses.png
```

---

## 🖼 Screenshots (Add these in your report or demo)

📸 **Home Screen**
*Image Placeholder – Insert screenshot showing product cards*

📸 **Product Detail Screen**
*Image Placeholder – Insert screenshot with size and quantity selection*

📸 **Cart Screen**
*Image Placeholder – Insert screenshot showing cart items and checkout button*

---

## 🧱 Notable Widgets & Patterns

### 🪧 Product Card

* Uses `Container` and `Row`
* Styled with background color, image, and shadow

### 🎯 Detail Screen

* `ChoiceChip` for sizes
* `IconButton` for quantity control
* Full-width add-to-cart `ElevatedButton`

### 🛒 Cart Screen

* Uses `ListTile` layout per item
* Quantity adjustments handled with `setState()`

### 📢 Feedback

* Snackbar after adding to cart or completing checkout

---

## 🏷 Acknowledgements

* Flutter SDK & DartLang
* SHEIN & H\&M UI inspirations
* Freepik, Pexels for placeholder images
* Open-source Flutter community

---
