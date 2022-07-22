//
//  HostModel.swift
//  test-firestore
//
//  Created by Vlad Sobchuk on 7/20/22.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseSharedSwift
import FirebaseFirestoreSwift
class HostModel: ObservableObject {

    let db = Firestore.firestore()
    @Published var cards: [Int] = .init()
    let id: String = ""
    var hostId = ""
    var hostName = ""
    @Published var hostIsParticipant = false
    @Published var status = "settings"

    struct Session: Codable, Identifiable {
        @DocumentID var id: String?
        var cards: [Int] = .init()
        var createdDate: Date?
        var currentRound: String = ""
        var hostId: String
        var hostName: String
        var hostIsParticipant: Bool = false
        var status: String

    }

    func fetchSession(_ sessionId: String) async {
        db.collection("sessions").document(sessionId).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            if let doc = try? documentSnapshot?.data(as: Session.self) {
                print(doc)
            }
        }
    }
}
