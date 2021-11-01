//
//  FirebaseLoginService.swift
//  Mars Rover
//
//  Created by XXX on 31.10.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum LoginType {
    case emailAndPassword(email: String, password: String)
    case checkLogin
}

enum LoginError {
    case error(error: String)
    case absentOfUser
    case absentOfProfile
    case profileFetchError
    case notVerifiedEmail
}

typealias LoginProfileCompletion = (ProfileModel?, LoginError?) -> Void

class FirebaseLoginService {
    private var authListener: AuthStateDidChangeListenerHandle?
    private let auth = Auth.auth()
    private var db = Firestore.firestore()
    func loginWithPassword(email: String, password: String, completion: @escaping LoginProfileCompletion) {
        auth.signIn(withEmail: email, password: password) { [weak self] data, error in
            if let error = error {
                completion(nil, .error(error: error.localizedDescription))
            }
            guard let user = data?.user else { return completion(nil, .absentOfUser) }
            guard user.isEmailVerified else {
                try? self?.auth.signOut()
                return completion(nil, .notVerifiedEmail)
            }
            self?.fetchProfileFromFirestore(uid: user.uid) { profile, error in
                if let error = error {
                    completion(nil, error)
                }
                guard let profile = profile else {
                    return completion(nil, .absentOfProfile)
                }
                completion(profile, nil)
            }
        }
    }
    private func fetchProfileFromFirestore(uid: String, completion: @escaping LoginProfileCompletion) {
        let userRef = db.collection("users").document(uid)
        userRef.getDocument { document, error in
            let result = Result {
                try document?.data(as: ProfileModel.self)
            }
            switch result {
            case .success(let profileModel):
                if let profileModel = profileModel {
                    return completion(profileModel, nil)
                } else {
                    return completion(nil, .profileFetchError)
                }
            case .failure(let error):
                return completion(nil, .error(error: error.localizedDescription))
            }
        }
    }
    func checkLoginAndFetchProfile(completion: @escaping LoginProfileCompletion) {
        authListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let user = user else { return completion(nil, .absentOfUser) }
            guard user.isEmailVerified else {
                try? self?.auth.signOut()
                return completion(nil, .notVerifiedEmail)
            }
                self?.fetchProfileFromFirestore(uid: user.uid) { profile, error in
                    if let error = error {
                        return completion(nil, error)
                    }
                    guard let profile = profile else { return completion(nil, .absentOfProfile) }
                    return completion(profile, nil)
                }
        }
    }
    deinit {
        if let listener = authListener {
            Auth.auth().removeStateDidChangeListener(listener)
            print("deinited")
        }
    }
}
