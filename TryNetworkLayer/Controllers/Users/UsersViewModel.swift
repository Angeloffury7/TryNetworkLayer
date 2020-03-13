//
//  UsersViewModel.swift
//  TryNetworkLayer
//
//  Created by Andrea Stevanato on 03/09/2017.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Foundation

protocol UsersViewModelCoordinatorDelegate: class {
    func usersViewModelPresent(user: GHUser)
}

final class UsersViewModel: ObservableObject {
    
    // MARK: Observables

    @Published var updateView: Bool = false

    // MARK: Properties

    weak var coordinatorDelegate: UsersViewModelCoordinatorDelegate?
    
    let usersRepo: UsersRepoProtocol
    private(set) var users: [GHUser] = []
    
    // MARK: Methods

    init(usersRepo: UsersRepoProtocol = UsersRepo()) {
        self.usersRepo = usersRepo
    }
    
    func fecthUsers() {
        usersRepo.fetch(fromStorage: true, query: "language:swift") { [weak self] (users) in
            self?.users = users
            self?.updateView = true
        }
    }
    
    func searchUsers(query: String) {
        usersRepo.fetch(fromStorage: false, query: query) { [weak self] (users) in
            self?.users = users
            self?.updateView = true
        }
    }

    func deleleAllUsers() {
        self.users.removeAll()
        usersRepo.deleteAll()
        self.updateView = true
    }
    
    // MARK: Table view getter
    
    func numberOfUsers() -> Int {
        users.count
    }
    
    func userAt(indexPath: IndexPath) -> GHUser {
        users[indexPath.row]
    }

    // MARK: Coordinator

    func presentUserDetail(user: GHUser) {
        coordinatorDelegate?.usersViewModelPresent(user: user)
    }
}
