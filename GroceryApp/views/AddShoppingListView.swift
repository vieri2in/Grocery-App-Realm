//
//  AddShoppingListView.swift
//  GroceryApp
//
//  Created by bin li on 7/21/23.
//

import SwiftUI
import RealmSwift
struct AddShoppingListView: View {
  @State private var title: String = ""
  @State private var address: String = ""
  @Environment(\.dismiss) var dismiss
  @ObservedResults(ShoppingList.self) var shoppingLists
    var body: some View {
      NavigationStack {
        Form {
          TextField("Enter title", text: $title)
          TextField("Enter address", text: $address)
          Button {
            //
            let shoppingList = ShoppingList()
            shoppingList.title = title
            shoppingList.address = address
            $shoppingLists.append(shoppingList)
            dismiss()
          } label: {
            Text("Save")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.bordered)
        }
        .navigationTitle("New List")
      }
    }
}

#Preview {
    AddShoppingListView()
}
