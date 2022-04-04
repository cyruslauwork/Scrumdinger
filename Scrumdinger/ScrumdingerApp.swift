//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Cyrus on 21/3/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()   //  @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
//            MeetingView()
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {  // To find out the error separately by If statement
                            fatalError(error.localizedDescription)
                        }
                    }
                }   // ScrumsView(scrums: $store.scrums)   //  ScrumsView(scrums: $scrums)
            }
            .onAppear {
                ScrumStore.load { result in
                    switch result {
                    case .failure(let error):   //  "error" is what come from ".failure"
                        fatalError(error.localizedDescription)
                    case .success(let scrums):
                        store.scrums = scrums
                    }
                }
            }
        }
    }
}
