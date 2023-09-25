//
//  SwiftUICustomLoaderApp.swift
//  SwiftUICustomLoader
//
//  Created by Aakif Nadeem on 25/09/2023.
//

import SwiftUI

@main
struct SwiftUICustomLoaderApp: App {
    var body: some Scene {
        WindowGroup {
            CustomCircleLoader(isShowing: .constant(true)) {
                NavigationView {
                    List(["1", "2", "3", "4", "5"], id: \.self) { row in
                        Text(row)
                    }.navigationBarTitle(Text("Loader Test"), displayMode: .large)
                }
            }
        }
    }
}
