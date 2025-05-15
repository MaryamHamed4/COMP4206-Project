 🦖 Spendasaurus: Smart Budget Tracker

## 📋 Project Overview

**Spendasaurus** is a smart, engaging mobile application built with **Flutter** for tracking personal finances. It empowers users to record their income and expenses, set budgets, generate financial plans, and view financial insights through interactive charts—all with secure access via Firebase authentication and biometric security.

This app was developed as a final course project for **COMP4206: Mobile Applications Development (Spring 2025)** at **Sultan Qaboos University**, showcasing advanced Flutter features, cloud integration, UI/UX design, and production-readiness through full deployment on a physical Android device.

---

## 🎯 Key Features

✅ **Firebase Authentication** for secure login/registration
✅ **Add, view, update, and delete** income/expense transactions
✅ **Set and track budgets** per category with visual progress
✅ **Generate financial plans** using a multi-step form with validations
✅ **Real-time reports** via Pie and Bar Charts (using `fl_chart`)
✅ **TabBar, Bottom Navigation, and Drawer** for seamless navigation
✅ **Upload receipts/images** with transactions (image\_picker)
✅ **Search/filter functionality** to find transactions quickly
✅ **Dark mode and currency selection** in app preferences
✅ **Biometric authentication** for enhanced app security
✅ **Snackbars and modals** for user feedback on actions

---

## 🛠️ Technologies Used

* **Flutter & Dart**
* **Firebase Firestore & Authentication**
* `fl_chart` (data visualization)
* `image_picker` (photo upload)
* `google_fonts` (custom fonts)
* `local_auth` (biometrics)

---

## 🧱 Project Structure

```
lib/
├── models/
│   ├── budget.dart
│   ├── transaction.dart
│   └── user.dart
├── pages/
│   ├── home_page.dart
│   ├── add_transaction_page.dart
│   ├── budget_page.dart
│   ├── reports_page.dart
│   ├── settings_page.dart
│   ├── login_page.dart
│   └── financial_plan_page.dart
├── widgets/
│   ├── nav_bar.dart
│   └── common_widgets.dart
├── main.dart
assets/
└── images/
    └── logoMod.jpg
```

---

## 🚀 How to Run the Project

1. Clone the repository:

```bash
git clone https://github.com/YourGitHubUsername/spendasaurus.git
```

2. Navigate to the project folder:

```bash
cd spendasaurus
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

✅ Ensure your emulator/device allows access to **camera, storage, and biometrics**.

---

## 📊 Firebase Collections

* `users`: email, createdAt
* `transactions`: title, amount, category, createdAt, userId
* `budgets`: category, limit, month, userId

Each supports full **CRUD operations**, with **search/filter** and **user-specific access**.

---

## 👥 Team Members

| Name               | Student ID |
| ------------------ | ---------- |
| Maryam Al’Obeidani | 137875     |
| Al-Zahraa Al Abri  | 136364     |

Both members collaborated on all major components including UI design, Firebase integration, CRUD operations, authentication, charts, and deployment.

---

## 📈 Contribution Summary

| Team Member        | Responsibilities                                                         |
| ------------------ | ------------------------------------------------------------------------ |
| Maryam Al’Obeidani | All pages: Home, Transactions, Budget, Reports, Financial Plan, Settings |
| Al-Zahraa Al Abri  | All pages: Home, Transactions, Budget, Reports, Financial Plan, Settings |

---

## 📂 GitHub & Version Control

* Public repository with clean folder structure
* Version control via Git branches and commits
* All contributions properly documented in commit history

---

## 🎥 Demo Video
(Video demonstrates login, Firebase usage, CRUD operations, UI components, and biometric security)

---

## ✅ Course Note

This project was completed as part of **COMP4206: Mobile Applications Development**. It demonstrates:

* Firebase integration and authentication
* State management and navigation
* Layered UI with Stack, TabBar, Drawer
* Search, filtering, and chart visualizations
* Full deployment on a real Android device

