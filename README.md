# Vedic Workflows - Priest Management App

A comprehensive Flutter application designed for Vedic Priests to manage their sacred services, customer bookings, rituals, and earnings with a professional and intuitive UI.

## Key Features

-   **Dashboard Overview**: Real-time stats for total, pending, and confirmed bookings, along with "Today's Muhurtham" reminders.
-   **Advanced Booking Management**:
    -   Track bookings through multiple statuses: Pending, Confirmed, In Progress, Completed, and Cancelled.
    -   Real-time search and status-based filtering.
    -   Parallel UI cards showing customer details, amount, and status at a glance.
-   **Ritual Workflow**: 
    -   Secure ritual start using a 4-digit verification code (OTP) provided by the customer.
    -   End-to-end status tracking from acceptance to completion.
-   **Earnings Dashboard**: 
    -   Docked balance card showing total, current month, and last month earnings.
    -   Service performance visualization (Homam, Puja, Grihapravesham).
    -   Detailed transaction history with withdrawal options.
-   **Subscription Plans**: Tiered membership system (Basic, Pro, Elite) with detailed feature comparisons and pricing.
-   **Professional Profile**: Showcase years of experience, ratings, and number of successful bookings.

## Tech Stack

-   **Framework**: [Flutter](https://flutter.dev)
-   **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
-   **Local Database**: [sqflite](https://pub.dev/packages/sqflite) (Persistent storage for bookings and transactions)
-   **Architecture**: Feature-driven development with Repository Pattern.

## Project Structure

```text
lib/
├── core/               # Database and common utilities
├── data/               # Repositories for data abstraction
├── features/           # Feature-based modules
│   ├── bookings/       # Booking list, details, and verification logic
│   ├── earnings/       # Earnings tracking and performance UI
│   ├── home/           # Dashboard and overview
│   ├── profile/        # User profile and settings
│   ├── subscription/   # Membership plans
│   ├── splash/         # Animated entry screen
│   └── main_navigation/# Core tab-based navigation
├── models/             # Data models (BookingModel, etc.)
└── main.dart           # Application entry point
```

## Getting Started

### Prerequisites
-   Android Studio / VS Code
-   An emulator or physical device

### Installation
1.  **Clone the repository**:
    ```bash
    git clone
    cd task_vedic
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the application**:
    ```bash
    flutter run
    ```

## 📸 UI Design Highlights
-   **Theme**: Professional Vedic Purple (`#3B137B`) with Gold and Amber accents.
-   **Navigation**: Seamless transitions between the dashboard and detailed workflow screens.

---
