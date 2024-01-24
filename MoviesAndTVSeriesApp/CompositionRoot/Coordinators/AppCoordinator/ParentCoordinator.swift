//
//  ParentCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//


protocol ParentCoordinator: AnyObject {
  var childCoordinators: [CoordinatorType] { get set }
}

extension ParentCoordinator {
  func addChildCoordinatorStar(_ childCoordinator: CoordinatorType?) {
    guard let childCoordinator = childCoordinator else { return }
    childCoordinators.append(childCoordinator)
    childCoordinator.start()
  }
  
  func removeChildCoordinator(_ childCoordinator: CoordinatorType) {
    childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
  }
  
  func clearAllChildsCoordinator() {
    childCoordinators = []
  }
}
