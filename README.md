# Smart Ahwa Manager
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Elgammal1299/smart_ahwa_manager)

Smart Ahwa Manager is a comprehensive Flutter-based application designed to modernize and simplify order management for coffee shops (Ahwas). It provides an intuitive interface for adding orders, tracking their status, and generating insightful business reports.

## Core Features

*   **Effortless Order Creation:** Quickly add new orders with customer details, drink selection, quantity, and customizations.
*   **Dynamic Customizations:** Utilizes the **Decorator design pattern** to dynamically add extras like milk, mint, or extra sugar, with automatic price adjustments.
*   **Real-time Order Tracking:** View all orders neatly organized into "Pending" and "Completed" tabs for efficient workflow management.
*   **Actionable Order Cards:** Mark orders as complete or remove them with a single tap directly from the order list.
*   **Insightful Reporting Dashboard:** Get a quick overview of your business performance with cards displaying total revenue, pending vs. completed orders, top-selling drinks, and most popular additions.

## Application Flow & Screens

The application is structured around a bottom navigation bar for easy access to its three main sections:

1.  **Add Order Screen**: A simple form to input a customer's name, and select a beverage and quantity. Based on the beverage chosen, a list of relevant additions (e.g., "Milk" for coffee, "Mint" for tea) becomes available for further customization.
2.  **Orders Screen**: A tabbed interface that separates active (pending) and fulfilled (completed) orders. Each order is displayed on a detailed card showing the customer, item, quantity, and final price. Pending orders can be marked as complete or deleted.
3.  **Reports Screen**: A dashboard that presents key business metrics in clear, easy-to-read cards. This includes total revenue, total pending orders, total completed orders, the most popular drink, and the most requested addition.

## Technical Details

*   **Framework**: Built with the Flutter framework for cross-platform compatibility.
*   **State Management**: Leverages `flutter_bloc` (using `Cubit`) for predictable and scalable state management.
*   **Architecture**: Organized using a feature-first directory structure, promoting separation of concerns and maintainability.
*   **Design Patterns**: Implements core software design patterns, most notably the **Decorator Pattern** to handle beverage and addition combinations. This makes the system easily extensible with new drinks or extras without modifying existing code.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK installed on your machine. You can find instructions [here](https://flutter.dev/docs/get-started/install).

### Installation & Setup

1.  Clone the repository to your local machine:
    ```sh
    git clone https://github.com/elgammal1299/smart_ahwa_manager.git
    ```
2.  Navigate to the project directory:
    ```sh
    cd smart_ahwa_manager
    ```
3.  Install the necessary dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the application on your emulator or physical device:
    ```sh flutter run
![IMG-20250918-WA0024](https://github.com/user-attachments/assets/5f33e106-fcfa-4d19-8c9e-a49c861c1416)
![IMG-20250918-WA0026](https://github.com/user-attachments/assets/569f404e-396d-48d5-86f8-eb3169f6e5ec)
![IMG-20250918-WA0025](https://github.com/user-attachments/assets/c28cefa0-7a45-404e-a355-ff5e5f722a38)
![IMG-20250918-WA0027](https://github.com/user-attachments/assets/b14066a4-8e86-4e12-a198-657731bdc3fa)


   
