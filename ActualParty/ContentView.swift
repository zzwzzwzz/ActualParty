//
//  ContentView.swift
//  ActualParty
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingView()
            }
        }
    }
}

struct HomeView: View {
    
    @State private var guests: [Guest] = [
        Guest(name: "Shuvam", prefersGluten: false, partyHours: 3),
        Guest(name: "Seb", prefersGluten: true, partyHours: 12),
        Guest(name: "Avinash", prefersGluten: false, partyHours: 1)
    ]
    
    @State var name: String = ""
    @State var prefersGluten: Bool = false
    @State var partyHours: Int = 1
    
    private func addNewGuest(guest: Guest) {
        guests.append(guest)
    }
    
    @State var isSheetShowing: Bool = false
    
    @Environment(\.dismiss) private var dismissSheet
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(guests) { guest in
                    NavigationLink {
                        GuestDetailView(guest: guest)
                    } label: {
                        ListRowView(guest: guest)
                    }
                }
            }
            .navigationTitle("Guest List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Invite Guests") {
                        isSheetShowing.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {
                        
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                NavigationStack {
                    Form {
                        Section {
                            TextField("Enter Guest Name:", text: $name)
                            Toggle("Prefers Gluten", isOn: $prefersGluten)
                        } header: {
                            Text("Guest Details")
                                .padding(.top, 20)
                        }footer: {
                            Text("Provide guest details here")
                        }
                        
                        Section {
                            Stepper("Party Hours: " + String(partyHours), value: $partyHours, in: 1...24)
                        } footer: {
                            Text("Tap to increase or decrease party hours")
                        }
                    }
                    .navigationTitle("Invite New Guests")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isSheetShowing.toggle()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Submit") {
                                addNewGuest(guest: Guest(name: name, prefersGluten: prefersGluten, partyHours: partyHours))
                                isSheetShowing.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct GuestDetailView: View {
    var guest: Guest
    var body: some View {
        List {
            Text(guest.name)
            Text(String(guest.partyHours) + " party hours")
            Text(String(guest.prefersGluten))
        }
    }
}

struct FormView: View {
    @State var name = ""
    @State var prefersGluten = false
    @State var partyHours = 1
    
    var body: some View {
        Form {
            Section {
                TextField("Enter Guest Name", text: $name)
                Toggle("Prefers Gluten", isOn: $prefersGluten)
            } header: {
                Text("Guest Details")
            } footer: {
                Text("Provide Guest Details here")
            }
            Section {
                Stepper("Party Hours: " + String(partyHours), value: $partyHours, in: 1...24)
            } footer: {
                Text("Indicates the amount of partying your guest can do")
            }
        }
    }
}

struct ListRowView: View {
    var guest: Guest
    
    var body: some View {
        HStack(spacing: 16) {
            CupView(prefersGluten: guest.prefersGluten)
            VStack(alignment: .leading) {
                Text(guest.name)
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Text(String(guest.partyHours) + " party hours")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}

struct CupView: View {
    
    var prefersGluten: Bool
    
    var body: some View {
        VStack (spacing:0) {
            RoundedRectangle(cornerRadius: 999)
                .frame(width: 30, height: 4)
                .foregroundStyle(prefersGluten ? Color.blue : Color.red)
                .opacity(0.3)
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 0)
                .frame(width: 25, height: 30)
                .foregroundStyle(prefersGluten ? Color.blue : Color.red)
        }
    }
}

struct SettingView: View {
    var body: some View {
        Text("Setting")
    }
}

#Preview {
    ContentView()
//    FormView()
}
