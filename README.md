# Transformers-Shehryar-Rajput
**Transformers-game-for-sofit**

### Building and Starting The Project

**Starting a New Game 🕹**

1. Wait for SPM (Swift Package Manager) to download required packages
2. Press `Start A New Game` button
3. Proceed Accordingly to the desired screens

**If you have already started a game 💾**

If you have already started a game (Pressed `Start A New Game` previously) and wish to return to it, press the Load button to login as the last logged on user

1. Press `Load Game` button
2. Proceed Accordingly to the desired screens


**How the Game Works**

_Login_

1. If a game was started the `load button` will be disabled
2. Loading, uses the previous token retrieved when setting up a new game; allowing you to resume your old game with all your transformers present

_Home_

Depending upon the button clicked the relevant screen opens up

1. Create Transformers:
    - Transformers are created with the supplied properties in the `textfields`
    - The result of the creation is displayed on the create button itself
   
2. Current Transformers:
    - Displays a tableview showing all transformers on server
    - Transformers can be `edited`✏ & `deleted`🗑️ via `leading & trailing swipes` respectively

3. Start a War:
    - Starts a war with the available transformer on the server. The outcome is displayed on the screen shortly after the war is over

**Assumptions**

- Displaying transformers requires 'Their relevant stats to be displayed' but doesnt mention what is considered relevant. Overall rating and the remaining stats that dont count in overall rating are shown; since there are too many starts to be shown on screen that'll cause the screen to look _crowded_
- Its required that the app maintain its state after a restart but doesnt mention how; hence userdefaults is used to just store the token, since everthing is server sided we pull the lists of transformers present on the server reather than emplyoing a DB like Realm to store transformer objects etc
- After the war, the transformers that lose (die) their battle are eliminated but the pdf doesnt state if its needed to kill them on server as well. Hence the delete functionality is empleted however its commented out, to prevent any uneeded behaviour and can be enabled by removing comments


## ✨ Bonus Features ✨ ##
-   [✅] Documentation of classes
-   [✔] UI Tests (Login page)
