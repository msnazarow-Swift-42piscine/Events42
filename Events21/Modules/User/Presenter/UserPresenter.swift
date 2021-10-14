//
//  UserPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import Foundation
import OrderedCollections

class UserPresenter: ViewToPresenterUserProtocol {

    // MARK: Properties
    weak var view: PresenterToViewUserProtocol!
    let interactor: PresenterToInteractorUserProtocol
    let router: PresenterToRouterUserProtocol
    let dataSource:PresenterToDataSourceUserProtocol

    var events: [EventResponse]!
    var me: MeResponse!

    let formatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()


    let predicates: [String: ((EventResponse, EventResponse) -> Bool)] = [
        "\(String.type) \(String.inc)": { (event1, event2) -> Bool in event1.kind > event2.kind },
        "\(String.syllabus) \(String.inc)": { (event1, event2) -> Bool in event1.cursusIds.max() ?? 0 > event2.cursusIds.max() ?? 0 },
        "\(String.campus) \(String.inc)": { (event1, event2) -> Bool in event1.campusIds.max() ?? 0 > event2.campusIds.max() ?? 0 },
        "\(String.type) \(String.dec)": { (event1, event2) -> Bool in event1.kind < event2.kind },
        "\(String.syllabus) \(String.dec)": { (event1, event2) -> Bool in event1.cursusIds.max() ?? 0 < event2.cursusIds.max() ?? 0 },
        "\(String.campus) \(String.dec)": { (event1, event2) -> Bool in event1.campusIds.max() ?? 0 < event2.campusIds.max() ?? 0 }
    ]




    // MARK: Init
    init(view: PresenterToViewUserProtocol,
         interactor: PresenterToInteractorUserProtocol,
         router: PresenterToRouterUserProtocol,
         dataSource: PresenterToDataSourceUserProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad() {

    }

    func viewWillAppear(){
        loadMe() {
                self.refresh(filters: self.interactor.loadFilters() ?? [ .myCursus: false,
                                                                      .myCampus: false,
                                                                      .future: false,
                                                                      .didSubscribe: false],
                            sort:  [])
        }
    }
    
    func loadMe(comletion: @escaping (() -> Void)) {
        interactor.getMe() { [unowned self] result in
            switch result {
            case .success(let me):
                self.me = me
                view.setName(me.firstName)
                view.setSurname(me.lastName)
                view.setLogin(me.login)
                var levels = ""
                me.cursusUsers.forEach{ cursus in
                    levels.append("\(cursus.cursus.name) \(cursus.level)\n")
                }
                view.setLevel("\(levels)")
                interactor.getImage(for: me.imageUrl) { image in
                    guard let image = image else { return }
                    view.setProfileImageView(image: image)
                }
                comletion()
            case .failure(let error):
                if let description = error.errorDescription {
                    self.view.showAlert(title: error.error, message: description) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                } else if let message = error.message {
                    self.view.showAlert(title: error.error, message: message) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                }
            }

        }
    }

    func loadEvents(campusIds: [Int],
                    cursusIds: [Int],
                    userIds: [Int],
                    sort: [String],
                    filter: [String : [String]],
                    sortedByPredicates: [(EventResponse, EventResponse) -> Bool]) {
        interactor.getEvents(campusIds: campusIds, cursusIds: cursusIds, userIds: userIds, sort: sort, filter: filter) { result in
            switch result {
            case .success(let responses):
                self.events = responses.sorted(by: sortedByPredicates).map {
                    var el = $0
                    el.duration = self.formatter.localizedString(for: el.beginAt, relativeTo: el.endAt).replacingOccurrences(of: " ago", with: "")
                    return el
                }
                self.dataSource.updateForSections([EventSectionModel(self.events)])
                self.view.reloadTableViewData()
            case .failure(let error):
                if let description = error.errorDescription {
                    self.view.showAlert(title: error.error, message: description) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                } else if let message = error.message {
                    self.view.showAlert(title: error.error, message: message) {
                        self.interactor.removeToken()
                        self.router.routeToAuthScreen()
                    }
                }
            }
        }
    }

//    func getUserEvents(userIds: [Int], eventIds: [Int], sort: [String], filter: [String : [String]]) {
//        interactor.getUserEvents(userIds: userIds, eventIds: eventIds, sort: sort, filter: filter) { result in
//            switch result {
//            case .success(let responses):
//                self.events = responses.map{ $0.event }
//                self.dataSource.updateForSections([EventSectionModel(self.events)])
//                self.view.reloadTableViewData()
//            case .failure(let error):
//                if let description = error.errorDescription {
//                    self.view.showAlert(title: error.error, message: description) {
//                        self.interactor.removeToken()
//                        self.router.routeToAuthScreen()
//                    }
//                } else if let message = error.message {
//                    self.view.showAlert(title: error.error, message: message) {
//                        self.interactor.removeToken()
//                        self.router.routeToAuthScreen()
//                    }
//                }
//            }
//        }
//    }

    func didSelectRowAt(modelId: Int) {
        router.routeToEventScreen(with: events[modelId], userId: me.id)
    }

    func buttonDidTapped(_ title: String) {
        switch title {
        case .filters:
            router.presentFilterScreen(delegate: self)
        case .logOut:
            self.interactor.removeToken()
            self.router.routeToAuthScreen()
        default:
            break
        }
    }
}

extension UserPresenter: CellToPresenterUserProtocol {
    
}

extension UserPresenter: TableViewToFiltersDelegateProtocol {
    func refresh(filters: OrderedDictionary<String, Bool>, sort: [String?]) {
        var interactorFilter: [String: [String]] = [:]
        if let future = filters[.future], future {
            interactorFilter[.future] = ["true"]
        }

        let predicates: [(EventResponse, EventResponse) -> Bool] = sort.compactMap{ sortName in
            guard let sortName = sortName else { return nil }
            return self.predicates[sortName]
        }
        loadEvents(campusIds: filters[.myCampus]! ? me.campus.map{ $0.id } : [],
                   cursusIds: filters[.myCursus]! ? me.cursusUsers.map{ $0.cursusId } : [] ,
                   userIds: filters[.didSubscribe]! ? [me.id] : [],
                   sort: [],
                   filter: interactorFilter,
                   sortedByPredicates: predicates)
    }
}
