# NextToGo (Take Home Exercise)
NextToGo is a demo app which is written for the technical task to demonstrate author's knowledge and skills. Also as part of the interview process, it provides a better observation and understanding of author's thought process and methodology.

## Features
The main feature of this app is displaying ‘Next to Go’ races using a given [API](https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10).
- The race list displayed on screen should be always 5 and sorted advertised start ascending.
- Started races should be removed from screen with the tolerance of 1 minute.
- Races can be filtered by category, eg. `Horse`, `Harness` and `Greyhound`, the filtered categories can be any combination of these 3 categories. Conversely the applied filter can be removed.
- For a race, meeting name, race number and advertised start as a countdown have to be displayed as minimum.
- Race data will be updated/refreshed periodically. 

## Tech Requirements
- SwiftUI or UIKit to build UI/UX.
    - Here we adopt SwiftUI which provide a modern and efficient way of composing UI elements.
- Has some level of testing. Full coverage is not necessary, but there should be at least some testing for key.
    - Here unit tests are covered for most parts. UI/UX tests have not been added considering time limitation. Some `Structs` have not be covered because they are pretty straightforward as there are only properties and default initializer inside.
- Documentation
    - As the codes are pretty simpler, limited documentation/comments are added in codes
    - `README.md` is provided here.
- Use scalable layouts.
    - System style font is adopted for Text/Image. To scale up/down font in simulator, press `+/-`, `option` and `cmd`.
- Use of custom Decodable (Optional)
    - To make naming consistent that conforms Swift standard (using camel case naming rather than underscore) and extract the useful information from backend response, customized decoding is adopted.
- Use of SF Symbols for any icons (Optional)
    - An icon of SF Symbols is used for countdown timer in the race list.
- Add accessibility labels such that you can navigate via voiceover (Optional)
    - This has not been added to the codebase at the moment considering the time limitation. Will add this later.

## Running and Testing
To be able to run and test the app, the specs requirements are as follows:
- iOS 15+
- Swift 5.5+
- Xcode 13+

Run:
1. Open the file `NextToGo.xcodeproj`
2. Select `NextToGo` target with supported simulator.
3. `cmd + R` or click `Run` button in Xcode.

Test:
1. Open the file `NextToGo.xcodeproj`
2. Select `NextToGo` or `MextToGoTests` target with supported simulator.
3. `cmd + U` or click `Test` button in Xcode.
