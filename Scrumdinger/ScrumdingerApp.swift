//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Cyrus on 21/3/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
//            MeetingView()
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
