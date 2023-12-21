# YassirTestTask

Hello! 

I would like to say thanks for providing me the opportunity to take on the technical task. I invested an effort in my solution to make it with a focus on quality and good coding practices instead of UI/UX. While I believe there's room for improvements, I also have numerous ideas for future ideas that we could discuss on next call. I would also be happy to answer any of your questions.


## Info

- The app is implemented following the guidelines and documentation you provided.
- A short demo video is attached.
- The app is implemented without extra third-party libraries. No reasons to add them for this simple showcase.
- Architecture: MVP + Router, Builder, Layers.
- Predictable, readable, and self-documented code, following SOLID, KISS, Clean Architecture.
- Monolithic, but ready for scaling and modularisation.
- No storyboards: everything is in the code.
- View layers include table view and stack view with autocalculation of height.
- Dark/light themes are supported.
- Landscape/portrait modes are supported.
- Covered by tests - not every class, just simple examples.


## Some Further Ideas:

### General:
- Authentication implementation + session tokens logic.
- Backend-side data contract improvements - simplify and remove unnecessary data from the API.
- Environment set up from the BE side (dev and prod env).
- Save sensitive data to the keychain + set up SSL Pinning to secure network requests.
- Add logging, metrics, events, charts, alerts.
- Table view improvements like making batch updates.
- UI/UX improvements.

### Scaling:
- Set up DI (Dependency Injection).
- Set up SwiftLint and Code Style.
- Set up release train (for example, Fastlane).
- Use SwiftGen to simplify some code.
- Modularise the app using Cocoa podspecs or SwiftPM.
- Apply a design system approach.
- Improve performance, app size, and app startup.
- Different iOS version and device testing.

### About Tests:
- Add unit, UI, components tests, snapshot tests.
- Network tests & JSON mapping tests.
- ViewModels and Models tests.
- UI theme testing.
- Dependency container tests.
- Memory leak tests.
- Testing on CI/CD.
