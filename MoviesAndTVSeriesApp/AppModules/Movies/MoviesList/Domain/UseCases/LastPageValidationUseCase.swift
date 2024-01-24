//
//  LastPageValidationUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//


protocol LastPageValidationUseCaseType {
    var lastPage: Bool { get }
    mutating func updateLastPage(itemsCount: Int)
    func checkAndLoadMoreItems(row: Int,
                               actualItems: Int,
                               action: () -> ())
}

struct LastPageValidationUseCase: LastPageValidationUseCaseType {
    private var threshHold = 5
    
    var lastPage: Bool = false
    
    mutating func updateLastPage(itemsCount: Int) {
        if itemsCount == Int.zero {
            lastPage = true
        }
    }
    
    func checkAndLoadMoreItems(row: Int,
                               actualItems: Int,
                               action: () -> ()) {
        guard !lastPage else { return }
        let limit = actualItems - threshHold
        if limit == row {
            action()
        }
    }
}
