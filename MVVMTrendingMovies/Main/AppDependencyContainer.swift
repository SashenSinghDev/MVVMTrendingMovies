//
//  MainAppDependencyCoordinator.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation

struct Dependencies {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
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
            return Dependencies(networkService: networkService)
        }

        func makeNetworkService() -> NetworkService {
            let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                              queryParameters: ["api_key": appConfiguration.apiKey])
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
