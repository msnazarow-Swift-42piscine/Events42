//
//  IntraAPIServiceMock.swift
//  Events21
//
//  Created by out-nazarov2-ms on 10.10.2021.
//

import Foundation

class IntraAPIServiceMock {
    let event = EventResponse(id: 0, name: "myName", description: "Mydescr", maxPeople: 30, nbrSubscribers: 20, location: "Carolina", kind: "Prize", beginAt: Date(), endAt: Date().addingTimeInterval(7200), cursusIds: [1], campusIds: [2])

    lazy var cursusUser = CursusUsersResponse(id: 0, hasCoalition: true, cursus: cursus, cursusId: 1, level: 30.3)

    let campus = CampusResponse(id: 0, country: "Soviet Union", city: "Belokamennoya", active: true, usersCount: 999, name: "Valhalla", vogsphereId: 1)

    let cursus = CursusResponse(name: "SuperCursus", id: 0, slug: "slug", createdAt: Date().addingTimeInterval(-72000))

    lazy var me = MeResponse(id: 0, firstName: "FirstName", lastName: "LastName", imageUrl: "https://purr.objects-us-east-1.dream.io/i/capture.png", login: "sgertrud", cursusUsers: [cursusUser], campus: [campus])

    let user = UserResponse(id: 0, firstName: "FirstName", lastName: "LastName", url: "https://example.com", login: "sgertrud", createdAt: Date().byAddingDay(-720), email: "example@example.com")

    lazy var eventUser = EventUsersResponse(event: event, eventId: 2, id: 3, user: user, userId: 0)

    let token = "my_very_secure_token"
}



extension IntraAPIServiceMock: IntraAPIServiceProtocol, IntraAPIServiceAuthProtocol {
    func tokenIsOutdated() -> Bool {
        true
    }

    func refreshToken(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        completion(.success(token))
    }

    func unregisterFromEvent(eventUserId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void) {
        completion(.success(true))
    }

    func getEvents(campusId: Int?, cursusId: Int?, userId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        completion(.success([event]))
    }

    func getUserEvents(userId: Int?, eventId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        completion(.success([eventUser]))
    }

    func getUserEvents(userIds: [Int], eventIds: [Int], sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        completion(.success([eventUser]))
    }

    func getEvents(campusIds: [Int], cursusIds: [Int], userIds: [Int], sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        completion(.success([event]))
    }

    func getEvents(campusId: Int?, cursusId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        completion(.success([event]))
    }

    func getFutureEvents(campusId: Int?, cursusId: Int?, sort: [String], filter: [String : [String]], completion: @escaping (Result<[EventResponse], IntraAPIError>) -> Void) {
        completion(.success([event]))
    }

    func getMe(completion: @escaping (Result<MeResponse, IntraAPIError>) -> Void) {
        completion(.success(me))
    }

    func registerToEvent(eventId: Int, completion: @escaping (Result<Bool, IntraAPIError>) -> Void) {
        completion(.success(true))
    }

    func getUserEvents(completion: @escaping (Result<[EventUsersResponse], IntraAPIError>) -> Void) {
        completion(.success([eventUser]))
    }

    func getToken(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        completion(.success(token))
    }

    func getUserCode(completion: @escaping (Result<String, IntraAPIError>) -> Void) {
        completion(.success("very_strange_user_code"))
    }

    func removeCode() {

    }

    func removeToken() {

    }

    func hasToken() -> Bool {
        true
    }


}
