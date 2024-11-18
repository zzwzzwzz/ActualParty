//
//  GuestModel.swift
//  ActualParty
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import Foundation // SwiftUI also works perfectly fine

struct Guest: Identifiable {
    var id: UUID = UUID()
    var name: String
    var prefersGluten: Bool
    var partyHours: Int
}
