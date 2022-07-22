//
//  ClientModel.swift
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
class ClientModel: ObservableObject {

    let db = Firestore.firestore()
    @Published var cards: [Int] = .init()
    @Published var status = "settings"
    @Published var currentRound: String = ""

    struct Session: Codable, Identifiable {
        @DocumentID var id: String?
        var cards: [Int] = .init()
        var currentRound: String = ""
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
