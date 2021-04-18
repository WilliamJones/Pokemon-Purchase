//
//  User.swift
//  Pokemon Purchase
//
//  Created by William Jones on 4/17/21.
//

import Foundation

//"user": {
//  "name": "Your",
//  "last": "Name",
//  "accountNumber": 11133344556433443,
//  "balance": 12.34,
//  "email": "someuser@thedomain.com"
//    }

struct User {
    let name: String
    let last: String
    let accountNumber: Int
    let balance: Float
    let email: String
    
    init(name: String, last: String, accountNumber: Int, balance: Float, email: String) {
        self.name = name
        self.last = last
        self.accountNumber = accountNumber
        self.balance = balance
        self.email = email
    }
}
