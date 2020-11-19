//
//  MainViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 07.11.20.
//

import Foundation

enum MainViewState {
    case movies
}

final class MainViewModel {
    var mainViewState: DynamicType<MainViewState> = DynamicType<MainViewState>()

    init() {
        mainViewState.value = .movies
    }
}
