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

## 3rd Party SDK/Library
Compared to integrating 3rd party SDK/library with the risk of introducing potential bugs/issues, no 3rd party SDK or library is integrated here as all the features are not complex.

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

## Screenshots
| Races | Filter | No Result | Error |
| --- | --- | --- | --- |
| ![Races](https://github.com/alvinh77/next-to-go/assets/12960590/2bd7ff81-42ad-43b9-bcaa-8512025198d1) | ![Filter](https://github.com/alvinh77/next-to-go/assets/12960590/9e6f330f-b5fb-4dbd-a112-1bb46f82f50a) | ![NoResults](https://github.com/alvinh77/next-to-go/assets/12960590/faba421b-0a31-4efe-9449-19481c527317) | ![Error](https://github.com/alvinh77/next-to-go/assets/12960590/defd8bc6-dac8-4410-ba4f-d68190ab0534) |

## Architecture
### Tech Stack:
**SwiftUI + UIKit**:
SwiftUI is mainly used to compose UI elements while UIKit is introduced to handle navigation, considering UIKit has a more mature navigation system in case we would like to implement more features like universal redirection.

**Combine/ObservableObject**:
This is introduced to work with SwiftUI to update UI's changes easily.

**async/await**:
To practice more on the Apple's new programming paradigm, we introduced this to do the asynchronous operation. At the same time I take a challenge of making the project completely strictly concurrency checking. As a result, `Sendable` and `MainActor` are introduced in many places. Limited `@unchecked Sendable` are introduced in the test/mock classes to avoid warnings.

**Diagram/Modularization**:
![Modularization](https://www.mermaidchart.com/raw/11b7b092-582e-4b0d-8dd7-fc9fae89cb55?theme=light&version=v0.1&format=svg)

**Design Patten**:
We adopt a hybrid architecture with MVVM and VIPER, considering making the routing logics more unit testable. Based on the functionalities, we modularised the codes into different parts:
- **AppDependecies**: The top level module in the app for dependencies injection in the app level. The runtime `AppDependencies` could be different class based on the configuration file `DefaultConfiguration.xcconfig`. For example, base URL could be different for different target/environment. The varied `AppConfiguration` could be read from remote platform (eg. LaunchDarkly, backend API) or local configuration file.
- **Router/Routing**: `Router` is the implementation module of `Routing` module. To avoid cycling dependencies, we separate `Routing` and `Router` modules. Lower levels modules will depend on the protocols module `Routing` while higher level module (eg. AppDependencies) will initialize classes/structs in `Router` and inject them to different instances (eg. `RacePresenter`, `FilterPresenter`)
- **Views**: All UI/UX related classes/structs including the views factory. It will depend on most of the lower level modules
- **Presenter**: The core part of the logics that handle views' event and request/distribute data/event. For example, digest events from views to load data or navigate to the next screen, requesting data from repository and updating displayed content on screen.
- **Repository**: It is introduced to handle data logics like data retrieving, caching and mapping.
- **Networking**: A encapsulation of the networking logics that is responsible for requesting/receiving response from backend.
- **Navigation**: A wrapup protocol module for `UINavigationController` which will be injected into `Router`
- **Model**: At the moment, we put all models in this module for simplicity. However in real project, the models will be put in different modules based on the requirements and access control.

# To be improved
Due to time limitation, we made some tradeoffs during the implementation which is acknowledged. To make it better and robuster, we note some points here to track for the futures' improvement. Also feedbacks are welcome and appreciated which would quite help self-improvement.
1. **Commits**: Each commit could be better organized based on its scope. A smaller and single responsibility commit is more readable and revertible.
2. **Accessibility**: This is optionally required in the task but we have not implemented it at the moment but we will do it shortly.
3. **Snapshots testing**: Snapshots tests will be introduced to make static UI validation.
4. **UI testing**: UI testings has not been implemented considering the time limitation like snapshots testing. This can be done with the Accessibility work mentioned above.
5. **CI/CD**: This could be introduced like what we did [here](https://github.com/alvinh77/async-data-loader/actions)
