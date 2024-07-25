# Rolling iOS App

## Overview

Hi! Want to know what the latest popular moviw are, or the upcoming releases? This is an app designed for movie lovers! 🍿🎬

I used [TMDB](https://developer.themoviedb.org/docs/getting-started) to obtain movie-related information.

Rolling is the one-stop destination for quick and relevant insight on the latest films, including ratings, synopsis, posters, trailers and release dates. The interface is designed to be simple, practical and easy to use.

So, why not download and try it out?

For the Traditional Chinese version of the README, please see [README-zh-TW.md](README-zh-tw.md).

## Main Features

**Movie List**:
- Popular Movies
- Upcoming Releases

**Movie Introduction**:
- Official Trailer
- Synopsis
- Popularity, Release Date and Movie Duration
- Poster 
- Related Movies

## Development Framework
- SwiftUI
- Combine

## Development Environment

- Xcode 15.2  
- Swift 5.0  
- iOS 17.0  
- macOS 14.1  

## Package Dependencies

- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
- [YouTube-Player-iOS-Helper](https://github.com/youtube/youtube-ios-player-helper)

## Installing the Application

To use Rolling, follow these steps:

Open Xcode, select Integrate -> Clone from the top menu -> Paste the project URL from the top menu, select Product -> Run to run the application on the simulator or connected iOS device

## Project Architecture

This project uses the MVVM architecture, separating data models, business logic, and UI into different layers. The following explains the project structure:

- ViewModel  
  MovieListViewModel:    
  MovieList, fetches popular movies and upcoming releases data  
  MovieIntroViewModel:  
  MovieIntroduction, fetches movie information, videos, images, related movies  

- Model  
  Movie:  
  Common data type
  XXXResponse:  
  Data types for upcoming releases, popular movies, movie information, videos, images, related movies

- View  
  MovieListContentView:  
  Movie list, composed of PopularView and UpcomingView in order  
  MovieIntroContentView:  
  Movie introduction, composed of YouTubePlayerView, OverviewView, PosterView, SimilarView in order

- Service
  NetworkService:  
  Network requests, returns custom error type NetworkError in case of errors
  MovieRequestFactory:  
  Produces specified API URLRequest
  RequestProducer:  
  Handles the URLRequest production process

## About the Code

**To improve code readability, maintainability, and extensibility, the following has been implemented**

- Custom error handling:  
In NetworkService, an Enum defines custom error types NetworkError, covering various possible error situations, providing more specific and meaningful error messages, facilitating error handling and testing

- Following API naming conventions:  
When defining Structs, property names are kept consistent with API fields, improving code readability and allowing easy comparison between code and API documentation

- Independent Views for XXXContentView:  
Representing main feature pages, utilizing SwiftUI's View Composition feature to break pages into multiple independent Views, each rendering its own content

- Combine for handling multiple APIs:  
ViewModel uses CombineLatest to handle multiple API requests and send all results at once when all requests are completed

- Generic network requests:  
The NetworkService class follows the NetworkProtocol protocol. The func fetch uses generics to handle various data types, constraining objects to Decodable to ensure all types can be parsed from JSON

- Easy URLRequest creation:  
MovieRequestFactory focuses on generating specified API URLRequests, eliminating the need for additional URL-related parameters when used, as it already calls RequestProducer to complete the process

- Type extensions:  
Struct Movie adds backdropURL and posterURL, making it convenient to obtain related URLs without needing to compose URLs and convert types each time

- YouTubeiOSPlayerHelper:  
A Framework for easily embedding and playing YouTube videos in iOS applications, eliminating the need for WKWebView communication, allowing direct input of video IDs for playing, pausing, fast-forwarding, and other related settings

- Reusing PosterItemView:  
The Poster for popular movies and the movie introduction page uses the same View, saving unnecessary resource waste and implementation time

**To enhance user experience, the following has been implemented**

- Not using the original YouTube progress control component:  
In YouTubePlayerView, controls = 0 is specifically set to remove the control component, using custom UI elements to adjust playback progress for easier customization

- Left-right swiping for popular movies:  
Using Scrollview's paging effect, displaying one popular movie at a time through left-right swiping, increasing app-user interaction opportunities

- Clean Design:  
Related font sizes directly use SwiftUI font, distinguishing largeTitle, headline, subheadline, footnote to categorize information importance in the simplest way

- Displaying Loading animation during loading:  
During network requests, the ViewModel's isLoading parameter determines whether to display an animation, letting users know data is being fetched

## Technologies Used

- Dependency Injection:  
ViewModel depends on protocols rather than instances, requiring external injection when instantiating itself, reducing coupling and allowing easy replacement of different network services or URLRequest creation

- Design Patterns:

  Observer Pattern  
Implemented using Combine, ViewModel adopts the ObservableObject protocol and uses @Published property wrapper, allowing Views to automatically subscribe and respond to data changes in the ViewModel

  Factory Pattern  
MovieRequestFactory encapsulates the complex logic of creating various movie-related URLRequests, such as createUpcoming(), createPopular(), etc., providing a consistent interface for creating different types of requests

  Singleton Pattern  
NetworkService creates a globally unique instance, with a private init() method ensuring access only through the shared property, effectively managing network requests and avoiding resource duplication

- Combine:  
Utilizing the Combine framework for Reactive Programming, NetworkService uses AnyPublisher to handle asynchronous network requests, ViewModel uses Publishers.CombineLatest to merge multiple request results, subscribing to Publishers using the sink method, implementing data flow processing and view updates, simplifying asynchronous operation handling and improving code readability

## LLM Assistance

**To accelerate development, the following was done during the development process**

- Generating API Struct data types
- Setting SwiftUI View styles
- Combine usage methods
- Code Review
