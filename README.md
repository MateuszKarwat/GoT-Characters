# GoT Characters [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/MateuszKarwat/GoT-Characters/master/LICENSE.md) [![Platforms](https://img.shields.io/badge/platform-iOS-red.svg)](http://www.apple.com/pl/ios/)

This is a simple `iOS` application to download most viewed GoT characters from http://gameofthrones.wikia.com.

## What is GoT Characters?
GoT Characters is a simple `iOS` application to display most popular **Game of Thrones** characters.

The whole code is written using [Objective-C](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/ObjectiveC.html). All informations and images are fetched using [Wikia API v1](http://gameofthrones.wikia.com/api/v1/).

Application supports only `iPhones` with `iOS 8+` version in all possible orientations.

Application has two views.

* First one allows user to add given Wikia to favorites list and also gives possibility to filter the ones user marked as favorite.
* Second view - details view - displays the same information as the main view does, but also gives an option to open full Wikia article in Safari.

## Installation
Application uses [Carthage](https://github.com/Carthage/Carthage) to manage dependencies with external libraries.

To run application using Xcode do the following:

1. Clone the `master` branch from this repository.
1. In a repository folder run `carthage update`.
1. Once your frameworks are downloaded and build, you're ready to go.
