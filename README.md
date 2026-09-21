# 🐇 Smart Rabbit Driver

Smart Rabbit Driver is a Flutter-based mobile application designed for delivery drivers to manage their assigned deliveries and interact with the delivery workflow through a simple and efficient interface.

The application was developed using **Flutter & Dart**, with **GetX** for state management, navigation, and dependency injection, following the **MVC (Model–View–Controller)** architectural pattern.

---

## 📱 About the Application

Smart Rabbit Driver is the driver-side application of the Smart Rabbit delivery platform.

The application provides drivers with the necessary tools to manage their delivery tasks, view order information, update delivery statuses, and stay connected with the platform.

The project focuses on providing a smooth driver experience while maintaining a modular and maintainable Flutter codebase.

---

# ✨ Features

## 🔐 Authentication

- Driver login
- Secure authentication flow
- Session management
- Validation of user credentials
- Handling authentication errors and API responses

---

## 🚚 Delivery Management

Drivers can manage their assigned delivery tasks through the application.

### Delivery workflow includes:

- View assigned deliveries
- View delivery/order information
- Check delivery details
- Update delivery status
- Follow the delivery workflow
- Handle completed delivery operations

---

## 📦 Order Management

The application provides drivers with access to the information required to handle their assigned orders.

### Order information includes:

- Order details
- Customer information
- Delivery information
- Order status
- Delivery progress

---

## 🗺️ Delivery & Location

The application supports the driver's delivery workflow by providing location-related functionality where required by the delivery process.

This allows the driver to work with delivery locations and navigate through the required delivery process.

---

## 🔄 Delivery Status Updates

Drivers can update the status of their assigned deliveries according to the current stage of the delivery process.

The application communicates these updates with the backend through REST APIs and reflects the latest state in the user interface.

---

## 🔔 Notifications

The application supports notifications to keep drivers informed about relevant delivery and application updates.

---

## 👤 Driver Profile

The application includes a driver profile section where the driver can access their account-related information.

---

## 🌐 API Integration

The application communicates with backend services through RESTful APIs.

API communication is handled using **Dio**, including:

- GET requests
- POST requests
- PUT/PATCH requests
- API response handling
- Error handling
- Request configuration
- Data serialization and deserialization

---

# 🏗️ Architecture

The application follows the **MVC (Model–View–Controller)** architecture.

```text
                ┌─────────────────┐
                │      View       │
                │   UI / Screens  │
                └────────┬────────┘
                         │
                         ▼
                ┌─────────────────┐
                │   Controller    │
                │ Business Logic  │
                │   + GetX State  │
                └────────┬────────┘
                         │
                         ▼
                ┌─────────────────┐
                │      Model      │
                │   Data / API    │
                └─────────────────┘
