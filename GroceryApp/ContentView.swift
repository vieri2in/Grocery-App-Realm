//
//  ContentView.swift
//  GroceryApp
//
//  Created by bin li on 7/21/23.
//

import SwiftUI
import RealmSwift
struct ContentView: View {
  @State private var isPresented: Bool = false
  @ObservedResults(ShoppingList.self) var shoppingLists
  var body: some View {
    NavigationStack {
      VStack {
        if shoppingLists.isEmpty {
          Text("No shopping lists.")
        }
        List {
          ForEach(shoppingLists, id: \.id) { shoppingList in
            NavigationLink {
            ShoppingListItemsView(shoppingList: shoppingList)
            } label: {
              VStack(alignment: .leading) {
                Text("\(shoppingList.title)")
                Text("\(shoppingList.address)")
                  .opacity(0.4)
              }
            }
          }
          .onDelete(perform: $shoppingLists.remove(atOffsets:))
        }
      }
      .navigationTitle("Grocery App")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            isPresented = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $isPresented) {
        AddShoppingListView()
      }

    }
  }
}

#Preview {
  ContentView()
}
