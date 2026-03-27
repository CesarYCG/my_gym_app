# FitMe - Gym Application

## 📖 Description
FitMe is a personal project created to learn Swift and SwiftUI. It is a Gym application developed to gain a deeper understanding of the Swift development workflow, application architecture, and iOS development best practices. The app serves as a practical, hands-on learning model to explore how iOS applications are built from scratch.

## 🚀 How to Download and Run

To get this project up and running on your local machine, follow these steps:

### Prerequisites
- A **Mac** running macOS.
- **Xcode** (latest version recommended), which you can download from the [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835).

### Steps
1. **Clone the repository:**
   Open your terminal and run the following command:
   ```bash
   git clone <your-repository-url>
   ```
   *(Note: Replace `<your-repository-url>` with the actual URL of your Git repository)*

2. **Navigate to the project directory:**
   ```bash
   cd fitme
   ```

3. **Open the project in Xcode:**
   Double-click the `fitme.xcodeproj` file in Finder, or open it via terminal:
   ```bash
   open fitme.xcodeproj
   ```

4. **Run the application:**
   - Select a Simulator (e.g., iPhone 15 Pro) from the device dropdown menu at the top center of the Xcode window.
   - Press the **Play** button (▶) in the top-left corner, or use the keyboard shortcut `Cmd + R` (`⌘R`) to build and run the app.

## 📁 Folder Structure

Here is an overview of the main directories in this project and what they contain:

- **`fitme/`**: The core application source code directory.
  - **`fitmeApp.swift`**: The main entry point and setup of the SwiftUI application.
  - **`Views/`**: Contains the SwiftUI views that define the layouts and user interface of the app.
  - **`Constants/`**: Holds constant values, app configurations, or reusable static data.
  - **`Assets.xcassets/`**: The unified asset catalog containing images, app icons, and custom colors used in the UI.

- **`fitme.xcodeproj/`**: The Xcode project package. It contains the essential build settings, targets, schema configurations, and file references necessary for Xcode to compile the code.

- **`fitmeTests/`**: Contains the unit tests for the application (using XCTest). This is where specific application logic, models, and functions are tested in isolation.

- **`fitmeUITests/`**: Contains the automated User Interface tests. Used to simulate real user interactions and guarantee that the UI components behave as expected during navigation.
