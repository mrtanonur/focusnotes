✨ Features

📱 Core Functionality

Create & Manage Notes - Quick note creation with title and content

Real-time Sync - Seamless synchronization across devices via Firebase

Offline Support - Local storage with Hive ensures access without internet

CRUD Operations - Full create, read, update, and delete capabilities

🔐 Authentication & Security

Multiple Sign-in Methods

Email/Password with email verification

Google OAuth integration

Apple Sign-in support


Secure Password Reset - Email-based password recovery

Session Management - Persistent login state

🎨 User Experience

Adaptive UI - Native look and feel on both Android and iOS

Theme Customization - Light, Dark, and System modes

Multi-language Support - English and Turkish localization

Responsive Design - Optimized for various screen sizes

💾 Data Management

Dual Storage Strategy

Local persistence with Hive

Cloud backup with Firebase Firestore


Automatic Sync - Seamless data synchronization

Offline-first Architecture - Work without internet, sync when connected

🛠️ Tech Stack

Frontend

Flutter - UI framework for cross-platform development

Provider - State management solution

Material Design - Android UI components

Cupertino - iOS-style UI components

Backend & Services

Firebase Authentication - User authentication and management

Cloud Firestore - NoSQL cloud database

Google Sign-In - OAuth 2.0 authentication

Sign in with Apple - Apple ID authentication

Local Storage

Hive - Fast, lightweight NoSQL database

Path Provider - File system path access

UUID - Unique identifier generation

Additional Packages

Flutter Localizations - Internationalization support

🎯 Key Features Explained

Offline-First Architecture

FocusNotes uses a dual-storage approach:

Hive stores data locally for instant access

Firestore provides cloud backup and cross-device sync

Changes sync automatically when online

State Management

Uses Provider pattern for:

Authentication state

Note CRUD operations

Theme and language preferences

Navigation state

Installation

Clone the repository

git clone https://github.com/yourusername/focusnotes.git

cd focusnotes

Install dependencies

flutter pub get
