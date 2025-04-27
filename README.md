🦖 Spendasaurus: Smart Budget Tracker

📋 Project Overview
Spendasaurus is a smart and fun budget tracking mobile application built with Flutter. It helps users manage their income and expenses, set monthly budgets, visualize financial trends, and secure their data with biometric authentication. The app is designed to provide an intuitive, simple, and enjoyable experience for managing personal finances.

🎯 Main Features
✅ Add and manage income and expense transactions.
✅ Set budgets for different spending categories with dynamic progress tracking.
✅ Visualize spending and earning trends with Pie Charts and Bar Charts.
✅ Upload photos or receipts with transactions.
✅ Customize app preferences (currency selection, dark mode).
✅ Enable biometric security using fingerprint or face authentication.

🛠️ Technologies Used
  1. Flutter & Dart
  2. Google Fonts (google_fonts)
  3. Image Picker (image_picker)
  4. FL Chart (fl_chart)
  5. Local Authentication (local_auth)

🏗️ Project Structure

lib/
├── models/
│    ├── budget.dart
│    ├── transaction.dart
│    └── user.dart
├── pages/
│    ├── home_page.dart
│    ├── add_transaction_page.dart
│    ├── budget_page.dart
│    ├── reports_page.dart
│    ├── settings_page.dart
│    └── summary_page.dart
├── widgets/
│    ├── transaction_tile.dart
│    ├── stat_card.dart
│    └── custom_buttons.dart
├── main.dart
assets/
└── images/
    └── logoMod.jpg

    
🚀 How to Run the Project
1. Clone the repository:
git clone https://github.com/YourGitHubUsername/spendasaurus.git

2. Navigate into the project directory:
cd spendasaurus

3. Install the dependencies:
flutter pub get

4. Run the app on an emulator or a real device:
flutter run

✅ Make sure your emulator/device allows permissions for camera, storage, and biometrics for full app functionality.

👩‍💻 Team Members

Name	                Student ID
Maryam Al'Obeidani	   137875
Al-Zahraa Al Abri	     136364

📈 Contribution Summary

Team Member	Contributions
Maryam Al’Obeidani:	Home Page, Add Transaction Screen, Summary Page, Budget Page, Reports Page, Settings Page
Al-Zahraa Al Abri	Home Page, Add Transaction Screen, Summary Page, Budget Page, Reports Page, Settings Page

📂 GitHub Collaboration
Version control using branches and commits.
Each team member contributed separately and merged changes collaboratively.
Clear commit history reflecting individual work.

🎥 Demo Video
[🔗video]

✅ Important
This project is a course assignment for COMP4206: Mobile Applications Development (Spring 2025) at Sultan Qaboos University.
It demonstrates Flutter application development, UI/UX design, form validation, data management, biometric security, and code refactoring techniques.
