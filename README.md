# MVVMTrendingMovies

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/SashenSinghDev/MVVMTrendingMovies/blob/main/LICENSE)

MVVMTrendingMovies is an iOS app built with the MVVM architecture to retrieve the latest trending movies and makes use of the [The Movie Database](https://developers.themoviedb.org/) API.

<img src="https://user-images.githubusercontent.com/3530948/111340219-bbce7780-8678-11eb-9824-af21a1ee1e74.png" width=30% height=30%> <img src="https://user-images.githubusercontent.com/3530948/111340891-5038da00-8679-11eb-9ec7-60b4b29e0bbf.png" width=30% height=30%>


## Features

- Lists latest trending movies
- See movie details which includes an overview of the movie

## Requirements

- Xcode 11+
- Swift 5.0+
- iOS 13+

## Installation

- Download the zip file
- Open the .xcodeproj file
- Run the app


## Project Structure

The project makes use of the MVVM architecture along with the repository pattern wherby view models will use the repository façade, instead of performing these operations themselves. In turn, view models transform and expose model data to views to display on-screen. 

No third party libraries were used and testing has been applied to all relevant layers.
