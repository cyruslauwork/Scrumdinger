//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Cyrus on 21/3/2022.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine) // Combine the elements that are included in above {}
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            .accessibilityElement(children: .combine) // Combine the elements that are included in above {}
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees){ attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(scrum.title) // Navbar title
        .toolbar { // Navbar
            Button("Edit") { // Action
                isPresentingEditView = true
                data = scrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) { // Show if isPresentingEditView = true
            NavigationView {
                DetailEditView(data: $data) // Prefab view
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { // Action
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { // Action
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0])) // Use ".constant()" to insert instance property into a computed property
        }
    }
}
