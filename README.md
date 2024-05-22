# Software Engineering Project


# Shit that needs to be done:
*For all pages, user needs to be passed though to keep user session open*

- Goals page:
    - Show goals if already set
    - Prompt a new goal
    - If no goal prompt to set a goal
- Transport mode page:
    - Seperate for logged in user
- Locations page:
    - When going back as a logged in user it should go back to the welcome page
- Help page:
    - Just something there
- Info Pages need to be fixed




# How to get started

- You will have to install Flutter SDK (just google and download)
- Then you need to install Android SDK (Its a while new IDE but we wont have to use it, you just need it for the emulator)
- Add flutter to path so that the "flutter" commands work
- Run "flutter doctor" and if there is a problem with Andoid, then you probably need to install "android command line tools" 
    - https://developer.android.com/studio -> its at the bottom of this page
    - Then you extract that zipped file into users/YourUsername/AppData/local/Android/sdk
    - Then when you run the "flutter doctor" it gives a command to fix this

When you run it, you first have to start the emulator and then just type "flutter run" in the terminal.


# carbon_tracker

**This representes the client side of the application (Flutter)**


# carbon_tracker_server

**This represents the server side of the applicaiton (Java, APIs, SQL)


# How to run the application

- Start an emulator: *>Flutter: laund emulator*
- In the terminal: *flutter run*
- cd into the server folder and run *"gradle bootRun"* to run the server side.



