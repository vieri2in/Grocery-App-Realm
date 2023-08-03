//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by bin li on 7/21/23.
//

import SwiftUI

@main
struct GroceryAppApp: App {
  let migrator = Migrator()
  var body: some Scene {
    WindowGroup {
      let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
      let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
      ContentView()
    }
  }
}
