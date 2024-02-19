## Table of Contents
1. [Description](#description)
2. [Package dependencies](#package)
3. [Architecture](#architecture)
   1. [Network](#network)
   2. [UI](#UI)
   3. [Architecture](#Architecture)
4. [Tehnologi](#tehnologi)


## Weather App
<p>A simple project that show the weather in current place of user.</p>

## Package dependencies

Weather App is a Swift package that provides...

- **Alamofire**
  - Alamofire is an HTTP networking library written in Swift.
  - Version: 5.8.1
  - github.com/Alamofire/Alamofire.git


- **IIDadata**
  - This package provides access to Dadata address suggestions and reverse geocoding APIs.
  - Version: 0.2.7
  - github.com/illabo/IIDadata.git
  - 
## Architecture
* Weather App project is implemented using the <strong>Model-View-Controller (MVC)</strong> architecture pattern.
* Model has any necessary data or business logic needed to present necessary weather.
* View is responsible for displaying the weather to the user, and updating.
* Controller handles any user  interactions and update the View as needed.
* Project doesn't have a database.<br><br>

## Tehnologi

The project demonstrated the skill of using

- **Network**
  -  URLSession with async/await to perform a network request and handle the result using the new concurrency features introduced in Swift 5.5.
  - URLSession with comlition handler
  - Using Alamofire library for network requests

- **UI**
  - Using and applying manual layout using autoLayout
  - Basic and not only methods for setting up collectionView and tableView
 
- **Architecture**
  - MVC
  - Using and applying additional managers-file
  - Сoding style


