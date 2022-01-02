//
//  EventDetailPresenter.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 26.09.2021.
//  
//

import UIKit

class EventDetailPresenter: ViewToPresenterEventProtocol {

    // MARK: Properties
    weak var view: PresenterToViewEventProtocol!
    let interactor: PresenterToInteractorEventProtocol
    let router: PresenterToRouterEventProtocol
    let dataSource:PresenterToDataSourceEventProtocol
    let model: EventResponse
    let userId: Int
    var userEvent: EventUsersResponse?
    var isRegistered = false
    // MARK: Init

    init(view: PresenterToViewEventProtocol,
         interactor: PresenterToInteractorEventProtocol,
         router: PresenterToRouterEventProtocol,
         dataSource: PresenterToDataSourceEventProtocol,
         model: EventResponse,
         userId: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
        self.model = model
        self.userId = userId
    }

    func viewDidLoad(){
        interactor.getUserEvents(userIds: [userId], eventIds: [model.id], sort: [], filter: [:]) { [weak self] result in
			defer { self?.view.show() }
            switch result {
            case .success(let eventUsers):
                guard let user = eventUsers.first else { break }
				self?.userEvent = user
				if self?.model.nbrSubscribers == (self?.model.maxPeople ?? -1) || user.event.beginAt < Date() {
					self?.view.hideButton()
                } else {
					self?.isRegistered = true
					self?.view.setButtonUnregistered()
                }
            case .failure(let error):
				if let date = self?.model.beginAt, date < Date() {
					self?.view.hideButton()
                } else {
					self?.isRegistered = false
					self?.view.setButtonRegistered()
                }
            }
			if let model = self?.model {
				updateText(model: model)
			}
		}

		func updateText(model: EventResponse) {
        let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "\(model.kind)\n", attributes: [.font: UIFont.systemFont(ofSize: 40 * verticalTranslation), .foregroundColor: UIColor.cyan]))
                  text.append(NSAttributedString(string: "\(model.name)\n", attributes: [.font: UIFont.systemFont(ofSize: 30 * verticalTranslation), .foregroundColor: UIColor.black]))
              if let description = model.description {
            text.append(NSAttributedString(string: "\(description)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.white]))
        }
            let maxPeople = (model.maxPeople != nil) ? "/\(model.maxPeople!)" : ""
            text.append(NSAttributedString(string: "Current number of guests: \(model.nbrSubscribers)\(maxPeople)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.black]))
        if let location = model.location {
            text.append(NSAttributedString(string: "Localisation: \(location)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.black]))
        }
        text.append(NSAttributedString(string: "Begin: \(model.beginAt.dateSlashString)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.gray]))
//         if let endAt = model.endAt {
            text.append(NSAttributedString(string: "End: \(model.endAt.dateSlashString)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.gray]))
//        }
        if let duration = model.duration {
            text.append(NSAttributedString(string: "Duration: \(duration)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.black]))
        }
            text.append(NSAttributedString(string: "Campuses: \(model.campusIds)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.black]))
            text.append(NSAttributedString(string: "Cursuses: \(model.cursusIds)\n", attributes: [.font: UIFont.systemFont(ofSize: 20 * verticalTranslation), .foregroundColor: UIColor.black]))


        view.setTextView(text: text)
        }
    }

    func buttonDidTapped(){
        if !isRegistered {
            interactor.registerToEvent(eventId: model.id) { [weak self] result in
                switch result {
                case .success(let userEvent):
					self?.userEvent = userEvent
					self?.isRegistered = true
					self?.view.showAlert(with: "You have registered")
					self?.view.setButtonUnregistered()
                case .failure(let error):
					self?.isRegistered = false
                    if let description = error.errorDescription {
						self?.view.showAlert(title: error.error, message: description)
                    } else if let message = error.message {
						self?.view.showAlert(title: error.error, message: message)
                    }
                }
            }
        } else {
            guard let userId = userEvent?.id else { return }
            interactor.unregisterFromEvent(eventUserId: userId) { [weak self] result in
                switch result {
                case .success:
					self?.isRegistered.toggle()
					self?.view.showAlert(with: "You have unregistered")
					self?.view.setButtonRegistered()
                case .failure(let error):
					self?.isRegistered = false
                    if let description = error.errorDescription {
                        self?.view.showAlert(title: error.error, message: description)
                    } else if let message = error.message {
                        self?.view.showAlert(title: error.error, message: message)
                    }
                }
            }

        }
    }
}

extension EventDetailPresenter: CellToPresenterEventProtocol {
    
}
