# SavingsCoop
A native iOS application built with SwiftUI designed to help users create savings goals, track their progress, and simulate deposits/withdrawals via M-PESA and Co-op Bank integrations.

# How to Run the App
## Prerequisites

1.Mac with macOS Sonoma or later

Xcode 15.0 or later installed

iOS 17.0+ Simulator or physical device

# Installation

Clone or download the repository.

Open the project folder.

Double-click the .xcodeproj file to open it in Xcode.

# Running the Project

Select a simulator (e.g., iPhone 15 Pro) from the top toolbar in Xcode.

Press Cmd + R or click the Play button to build and run the app.

# Architecture Overview

The app follows the MVVM (Model–View–ViewModel) architectural pattern to ensure separation of concerns, testability, and a clean UI structure.

1. Model (Data Layer)

Structs

SavingsGoal and Transaction define the core data structures.

Persistence

A DataManager singleton handles data persistence.

Models are serialized into JSON and saved in the device’s local Documents Directory.

Ensures data remains available even after the app is closed.

2. ViewModel (Business Logic)

SavingsViewModel

Acts as the bridge between the UI and the Data Layer.

Holds the source of truth (@Published var goals).

Handles business logic such as:

Calculating progress

Validating inputs

Processing deposits and withdrawals

Exposes intent functions:

createGoal

addTransaction

3. View (UI Layer)

Built entirely with SwiftUI.

Modular Components

GoalCardMain

CustomFieldContainer

SuccessModal

Promotes consistency and reduces code duplication.

Styling

Custom extensions manage the Green/Dark color palette:

#1e3b20

#8bc34a

# Assumptions Made

Currency

Defaults to KES (Kenyan Shilling) based on provided UI designs.

Single User

Assumes one local user (“Hello There!”).

No authentication or multi-user support.

Transaction Methods

Co-op Account and M-PESA transactions are simulated.

No real banking APIs are connected.

All transactions are assumed successful immediately.

Date Format

Uses the device’s local date preference.

Defaults to standard Gregorian formats.

# Trade-offs and Limitations
1. Persistence Strategy (JSON vs. Core Data / SwiftData)

Choice: JSON serialization to the file system.

Why: Lightweight, easy to debug, and simple to implement for project scope.

Limitation: Not optimized for large datasets (e.g., thousands of transactions) since the entire file is read/written for each change.

2. No Backend / Offline Only

Choice: Local-only storage.

Why: Enables instant functionality without internet and simplifies development.

Limitation:

No cross-device syncing.

Data is lost if the app is deleted.

3. Input Validation

Choice: Basic validation (empty fields and valid numbers).

Limitation:

No advanced validation for phone numbers (e.g., Safaricom format).

No bank account number validation.

4. Security

Limitation:

Sensitive data (e.g., mock account balance) is stored in plain text JSON.

A production banking app would require:

Keychain storage

Encryption

Secure data handling practices.
