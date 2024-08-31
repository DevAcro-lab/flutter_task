# Flutter Task

This app features both login and signup functionalities, allowing users to sign in or register using static data. 
It includes form validation for text fields, ensuring that user input matches specified regular expressions. 
Upon successful login, the app makes an API call to fetch user details, which are then displayed on the home screen 
and profile screen. The app provides a seamless user experience with real-time data validation and integration of user
information from the backend.


## Introduction
Welcome to our app, a user-friendly platform designed to provide a seamless login and signup experience. 
Whether you're a returning user or joining us for the first time, our intuitive interface makes it easy to 
access and manage your account.


## Features
- Splash Screen
- Login
- Sign Up
- Form Validation (User Input, Phone no validation based on country code)
- Displaying user details on Home screen and Profile screen
- Bottom Navigation Bar (for Navigation Ease).

## CONCEPTS USED
1. **MVVM**
   This app is built using the MVVM (Model-View-ViewModel) architectural pattern to ensure a clean separation of concerns and enhance code maintainability. 
The ViewModel handles the business logic and communicates with the Model to fetch user details. It also manages the state and validation logic for login 
and signup functionalities, while the View is responsible for displaying the user interface and updating based on the ViewModel's data.
2. **PROVIDER STATE MANAGEMENT**
   This app is built using the MVVM (Model-View-ViewModel) architectural pattern to ensure a clean separation of 
concerns and enhance code maintainability. Provider is utilized for state management, allowing efficient and reactive 
UI updates based on changes in the ViewModel. The ViewModel handles business logic, manages state, and communicates 
with the Model to fetch user details. The app includes login and signup functionalities with static data, along with 
text field validation using regular expressions. Upon successful login, the app hits a user details API, fetches the data, 
and displays it on the home and profile screens.

## Installation
1. **Clone the repository:**
git clone https://github.com/your-username/your-repository.git
2. **Then simply run it in Android Studio or VS code or any other IDE which supports Mobile app development**

## INSTRUCTION
1. Run the project in any IDE or you can use apk file to test it on your physical device.
2. With Opening you will see a splash screen displaying the company logo
3. Splash screen will be there for 2-3 secs and then will be directed to the login screen Now you can directly login using
the static credentials (email and password), textfields are being validated if Regular expressions for email or password 
are not matching what i have defined in the RegEx then it will show an error. or you can go for sign up filling all the fields (note that 
all the fields here, are also validated, so the criteria must be matched in other to sign up yourself). After all fields are
filled the user will be directed to the Main screen.
4. I am using a Bottom Nav Bar for simple Navigation throughout the app, User can see the user details both on Home Screen
and Profile Screen.

## CREDENTIALS
- email: user@speedforce.com
- password: password
