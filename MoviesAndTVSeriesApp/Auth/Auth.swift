//
//  Auth.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 22/01/24.
//

protocol SessionCheckerAuth {
  var isSessionActive: Bool { get }
}

protocol LogInAuth {
  func logIn()
}

protocol LogOutAuth {
  func logOut()
}

final class Auth {
  private var session = false
}

extension Auth: SessionCheckerAuth {
  var isSessionActive: Bool {
    session
  }
}

extension Auth: LogInAuth {
  func logIn() {
    session = true
  }
}

extension Auth: LogOutAuth {
  func logOut() {
    session = false
  }
}
