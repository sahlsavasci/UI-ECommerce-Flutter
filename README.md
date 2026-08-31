# EcoGlobal - Modern Flutter E-Commerce UI

A sleek, responsive, and robust Flutter E-Commerce mobile application built with Material 3, clean architecture principles, and Provider state management.

---

## 📱 Features

- **Authentication & Profile:**
  - Login and Registration with real-time form validation and password visibility toggle.
  - User profile view with editable settings and safe logout flow.
  - Change Password screen with matching confirmation validation.
- **Product Catalog & Discovery:**
  - Category navigation and dynamic search bar.
  - Best-selling product showcase with discount badges and quick "Add to Cart" action.
  - Reusable and responsive `ProductCard` component.
- **Cart Management:**
  - Dynamic shopping cart powered by `CartProvider`.
  - Item selection checkboxes, real-time quantity increments/decrements, and item deletion.
  - Coupon code entry and dynamic total price calculation.
- **Chat & Support:**
  - Chat list with unread badges and search.
  - Interactive chat detail view with sender/receiver message bubbles and real-time messaging simulation.
- **Navigation & Layout:**
  - Smooth bottom navigation bar powered by `curved_navigation_bar`.
  - Responsive layouts supporting varied screen densities without hardcoded bounds.
  - Centralized `AppTheme` for consistent color palettes, typography, and component styling.

---

## 🏗 Architecture & Project Structure

```
lib/
├── main.dart             # Application entry point, MultiProvider setup & routes
├── models/               # Domain data models
│   ├── cart_item.dart    # CartItem entity with calculated totals
│   ├── chat_message.dart # ChatMessage model
│   ├── product.dart      # Product model with discount calculation
│   └── user.dart         # User entity & copyWith
├── pages/                # Screen views
│   ├── account_page.dart
│   ├── cart_page.dart
│   ├── change_password_page.dart
│   ├── detail_chat.dart
│   ├── home_page.dart
│   ├── list_chat.dart
│   ├── login_page.dart
│   └── register_page.dart
├── providers/            # State Management (Provider)
│   ├── auth_provider.dart
│   └── cart_provider.dart
├── theme/                # Centralized Design System
│   └── app_theme.dart    # Brand colors, typography, ThemeData
└── widgets/              # Reusable UI components (snake_case)
    ├── cart_app_bar.dart
    ├── cart_bottom_navbar.dart
    ├── cart_item_samples.dart
    ├── categories_widget.dart
    ├── custom_button.dart
    ├── custom_text_field.dart
    ├── home_app_bar.dart
    ├── items_widget.dart
    └── product_card.dart
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.12.0` or higher
- Dart SDK `^3.12.0`

### Installation & Run

1. Clone the repository and navigate into the project root:
   ```bash
   git clone <repository_url>
   cd ui_ecommerce
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run static code analysis:
   ```bash
   flutter analyze
   ```

4. Run unit and widget tests:
   ```bash
   flutter test
   ```

5. Launch the application:
   ```bash
   flutter run
   ```

---

## 🧪 Testing

Automated smoke, unit, and widget tests are located under `test/`:
- **Smoke Tests:** Verifies authentication screens, forms, and validation errors.
- **Provider Tests:** Unit tests for `CartProvider` (add, remove, quantity update, total calculation) and `AuthProvider` (login, register, logout).
