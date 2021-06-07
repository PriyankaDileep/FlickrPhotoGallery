# FlickrPhotoGallery
Improvements

1.Some parts of the app do not follow MVVM strictly, doesn't have tests, or a more sophisticated form of dependency injection but decided to ignore it to save some time
2.View Models and View Controllers communication is based on closures, could've been cleaner using RxSwift or Swift's Combine Framework
3.A very small part of the app has duplicated code 
4.View Controller identifiers are inline string, would've been better to use a struct with all the identifiers 
5. Due to some lime limitation could achieve cache functionality
