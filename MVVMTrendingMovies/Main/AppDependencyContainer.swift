//
//  MainAppDependencyCoordinator.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation

final class Dependencies {
    let networkService: NetworkService
    let imageService: NetworkService

    init(networkService: NetworkService,
         imageService: NetworkService) {
        self.networkService = networkService
        self.imageService = imageService
    }
}

final class AppDependencyContainer {
    let mainViewModel: MainViewModel
    let dependencies: Dependencies

    init(appConfiguration: AppConfiguration = AppConfiguration()) {
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }

        func makeDependencies() -> Dependencies {
            let networkService = makeNetworkService()
            let imageService = makeImageService()
            return Dependencies(networkService: networkService,
                                imageService: imageService)
        }

        func makeNetworkService() -> NetworkService {
            let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                              queryParameters: ["api_key": appConfiguration.apiKey])
            return DefaultNetworkService(config: config)
        }

        func makeImageService() -> NetworkService {
            let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.imageBaseURL)!)
            return DefaultNetworkService(config: config)
        }

        mainViewModel = makeMainViewModel()
        dependencies = makeDependencies()
    }

    func makeMainViewController() -> MainViewController {
        let moviesViewController = makeMoviesController()
        return MainViewController(viewModel: mainViewModel,
                                  moviesViewController: moviesViewController)
    }

    private func makeMoviesController() -> MoviesViewController {
        let dependencyContainer = MoviesDependancyContainer(dependencies: dependencies)
        return dependencyContainer.makeMoviesViewController()
    }
}
