## How to Get Started

1. **Install Flutter SDK**
   - Download and install the Flutter SDK from the official website.

2. **Install Android SDK**
   - Download and install the Android SDK.
   - Note: You will need the Android SDK for the emulator, even though you won't need IDE directly to run the application (can be done in vsCode).

3. **Add Flutter to Path**
   - Ensure that Flutter is added to your system path so that the `flutter` commands work properly.

4. **Run Flutter Doctor**
   - Execute `flutter doctor` in the terminal to check for any setup issues.
   - If there are problems with the Android setup, you may need to install the "Android Command Line Tools."
     - Download from [Android Studio](https://developer.android.com/studio) (scroll to the bottom of the page).
     - Extract the zipped file to `users/YourUsername/AppData/local/Android/sdk`.
     - Follow any additional commands provided by `flutter doctor` to resolve issues.

5. **Install the Spring boot SDK**
- The app relies on the dependencies and funtionalities provided by spring boot to run.

# How to Run the Application

1. **Start an Emulator**:
   - Use the command `Flutter: launch emulator` in your development environment.

2. **Start the Server**:
   - Navigate to the server folder using:  `cd server`.
   - Run the server with the command `gradle bootRun`.

3. **Run the Application**:
   - Navigate to the client side with: `cd carbon_tracker`.
   - In the terminal, execute `flutter run`.



4. **Database Credentials**:
   - The database credentials are located in the `application.properties` file, which Spring Boot uses to automatically connect to the database.

5. **View the Database**:
   - If you wish to view the database, you can access it through this link: [Railway Database](https://railway.app/project/76102a3d-e378-4f7c-961b-fb8f0f2b11dd/service/9e5d5275-e38f-4135-8afc-9cfa2a0f8865/data) using the email `cookbook@code-gmail.com` for logging in.






