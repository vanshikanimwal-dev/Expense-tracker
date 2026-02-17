Smart Expense Tracker

A modern, production-ready Flutter expense tracking application built with Clean Architecture, Firebase, and Riverpod.
Track income, expenses, analytics, and financial summaries with a beautiful UI and real-time cloud sync.

Features

Firebase Authentication (Email/Password)

Cloud Firestore expense storage

Real-time expense updates

Income & expense tracking

Category-based transactions

Financial summary dashboard

Monthly analytics charts

Pie chart spending breakdown

Add / edit / delete transactions

Swipe-to-delete interaction

Light & dark theme support

Clean architecture structure

Riverpod state management

App Screens

Login Screen
Secure Firebase authentication

Home Dashboard
Balance, income, expense overview

Analytics Screen
Charts and category spending

Add / Edit Sheet
Modern bottom sheet transaction input

Tech Stack

Flutter
Firebase Auth
Cloud Firestore
Riverpod
FL Chart
Equatable
Clean Architecture

Project Architecture
lib/
│
├── core/
│   ├── theme/
│   ├── utils/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │
│   ├── expenses/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│
├── firebase_options.dart
├── main.dart


Architecture Layers:

Presentation → UI + Providers
Domain → Entities + Repositories
Data → Firebase implementations

Getting Started
1. Clone Repository
git clone https://github.com/YOUR_USERNAME/smart-expense-tracker.git
cd smart-expense-tracker

2. Install Dependencies
flutter pub get

3. Firebase Setup

This project uses Firebase.

Step 1 — Create Firebase Project

Go to Firebase Console
Create project

Step 2 — Add Android App

Package name:

com.example.expenseTracker


Download:

google-services.json


Place inside:

android/app/

Step 3 — Enable Firebase Services

Enable:

Authentication → Email/Password
Cloud Firestore → Test mode

Step 4 — FlutterFire Configure
dart pub global activate flutterfire_cli
flutterfire configure


This generates:

firebase_options.dart

4. Run App
flutter run

Data Model

Expense:

id: String
title: String
amount: double
category: ExpenseCategory
date: DateTime


Amount rules:

Positive → Income
Negative → Expense

Categories

Food
Transport
Shopping
Entertainment
Health
Bills
Travel
Education
Other

Charts & Analytics

Monthly bar chart
Category pie chart
Total spending summary
Income vs expense

State Management

Riverpod providers:

authStateChangesProvider
expensesStreamProvider
expenseSummaryProvider
themeModeProvider

Firebase Structure

Firestore:

users/{userId}/expenses/{expenseId}


Fields:

title
amount
category
date

Dependencies
flutter_riverpod
firebase_core
firebase_auth
cloud_firestore
fl_chart
equatable

Future Improvements

Budget limits
Recurring transactions
Export CSV/PDF
Notifications
Multi-currency
AI spending insights
Biometric login

Author

Vanshika Nimwal

License

MIT License

Contribution

Pull requests are welcome.
For major changes, open an issue first.

Support

If you like this project, give it a star.
