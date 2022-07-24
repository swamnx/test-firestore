//
//  ContentModel.swift
//  test-firestore
//
//  Created by Vlad Sobchuk on 7/19/22.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseSharedSwift
import FirebaseFirestoreSwift

class ContentModel: ObservableObject {

    @Published var currentScreen: String? = "home"
    
    @Published var showErrorAlert: Bool = false
    var errorText: String = ""
    
    @Published var sessionAlreadyExistDialog: Bool = false
    
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userName") var userName: String = "Some name"
    
    var sessionId: String = ""

    let db = Firestore.firestore()

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

    func createAndCheckSession() {
        checkSession(nextFunction: createSession)
    }
    
    func checkSession(nextFunction: @escaping () -> Void) {
        db.collection("sessions").whereField("hostId", in: [userId]).getDocuments() { (querySnapshot, error) in
            if let error = error {
                self.errorText = error.localizedDescription
                self.showErrorAlert = true
            } else {
                if !querySnapshot!.documents.isEmpty {
                    self.sessionId = querySnapshot!.documents[0].documentID
                    self.sessionAlreadyExistDialog = true
                }
                else {
                    nextFunction()
                }
            }
        }
    }
    
    func createSession() {
        var ref: DocumentReference? = nil
        let session = Session.init(cards: Array(1...16), createdDate: .init(), currentRound: "", hostId: self.userId,hostName: self.userName, hostIsParticipant: false, status: "settings")
        do {
            ref =  try self.db.collection("sessions").addDocument(from: session) { (error: Error?) -> Void in
              if let error = error {
                  self.errorText = error.localizedDescription
                  self.showErrorAlert = true
              } else {
                  self.sessionId = ref!.documentID
              }
                self.db.document("sessions/\(self.sessionId)/users/\(self.userId)")
                    .setData(["name":self.userName], merge: true) { (error: Error?) -> Void in
                    if let error = error {
                        self.errorText = error.localizedDescription
                        self.showErrorAlert = true
                    } else {
                        self.currentScreen = "host"
                    }
                }
          }
        } catch {
            self.errorText = "some error"
            self.showErrorAlert = true
        }
    }
    
    func deleteSessions() {
        db.collection("sessions").whereField("hostId", in: [userId]).getDocuments() { (querySnapshot, error) in
            if let error = error {
                self.errorText = error.localizedDescription
                self.showErrorAlert = true
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
                self.sessionId = ""
            }
        }
    }

    func connectToSessionAndCheckForHost() {
        checkSession(nextFunction: connectToSession)
    }
    func connectToSession() {
        db.document("sessions/\(sessionId)/users/\(userId)")
            .setData(["name":userName], merge: true) { (error: Error?) -> Void in
                if let error = error {
                    self.errorText = error.localizedDescription
                    self.showErrorAlert = true
                } else {
                    self.currentScreen = "client"
                }

            }
    }
    
}
