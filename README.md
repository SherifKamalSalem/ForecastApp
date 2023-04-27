# ForecastApp

# ForecastApp iOS App is built using Clean Architecture and MVVM &nbsp;

## Layers
* **Domain Layer** = Entities + Use Cases + Gateways Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views

### Dependency Direction

**Note:** **Domain Layer** should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)

#### Clean Architecture Concepts
##### Application Logic

* `UseCase / Interactor` - contains the application / business logic for a specific use case in your application
    * It is referenced by the `Presenter`. The `Presenter` can reference multiple `UseCases` since it's common to have multiple use cases on the same screen
    * It manipulates `Entities` and communicates with `Gateways` to retrieve / persist the entities
    * The `Gateway` protocols should be defined in the `Application Logic` layers and implemented by the `Gateways & Framework Logic`
    * The separation described above ensures that the `Application Logic` depends on abstractions and not on actual frameworks / implementations
    * It should be covered by Unit Tests
* `Entity` - plain `Swift` classes / structs
    * Models objects used by your application Main, Item, etc.

##### Gateways & Framework Logic

* `Gateway` - contains actual implementation of the protocols defined in the `Application Logic` layer
    * We can implement for instance a `LocalPersistenceGateway` protocol using `CoreData` or `Realm`
    * We can implement for instance an `ApiGateway` protocol using `URLSession` or `Alamofire`
    * We can implement for instance a `UserSettings` protocol using `UserDefaults`
    * It should be covered by Unit Tests
* `Persistence / API Entities` - contains framework specific representations
    * For instance we could have a `CoreDataOrder` that is a `NSManagedObject` subclass
    * The `CoreDataOrder` would not be passed to the `Application Logic` layer but rather the `Gateways & Framework Logic` layer would have to "transform" it to an `Order` entity defined in the `Application Logic` layer
* `Framework specific APIs` - contains implementations of `iOS` specific APIs such as sensors / bluetooth / camera
 
## Includes
* Searching for forecast by city name, zipCode, lat/lon and current location.
* Ability to see forecast for searched location 
* Ability to navigate to Dashboard screen

## Requirements
* Xcode Version 12+  Swift 5.0+

