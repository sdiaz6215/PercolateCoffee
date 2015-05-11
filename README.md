# PercolateCoffee iOS Submission

### Requirements
* Do all layout using auto layout in code ✓
* Network calls must be done using AFNetworking ✓
* Target iOS 7.1+ ✓
* Install libraries with Cocoapods ✓

### Nice-to-haves
* Send your api_key as the Authorization HTTP header, not as a GET param ✓
* Use Mantle for object serialization ✓
* Make use of Reactive Cocoa ✓✘
  * Table Cells were utilizing Reactive Cocoa to bind subviews to model properties, but a late discovery of a memory issue with RACObserve forced me to set properties manually. Reactive Cocoa is still being utilized in the detail views, but I did not have enough time to debug the memory issue.
* Make the app offline usable ✓

### Assumptions Taken
* Icon design
* As per design supplied, app has no status bar
* Objects returned by GET endpoint with bad/empty data were to be omitted from display
* Share button has no functionality as no requirements were given
