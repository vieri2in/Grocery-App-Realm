//
//  ShoppingListItemsView.swift
//  GroceryApp
//
//  Created by bin li on 7/22/23.
//

import SwiftUI
import RealmSwift
struct ShoppingListItemsView: View {
  @State private var isPresented = false
  @State private var selectedItemIds: [ObjectId] = []
  @State private var selectedCategory: String = "All"
  @ObservedRealmObject var shoppingList: ShoppingList
  var items: [ShoppingItem] {
    if selectedCategory == "All" {
      return Array(shoppingList.items)
    } else {
      return shoppingList.items.sorted(byKeyPath: "title").filter {
        $0.category == selectedCategory
      }
    }
  }
    var body: some View {
      VStack {
        CategoryFilterView(selectedCategory: $selectedCategory)
        if items.isEmpty {
          Text("No items found.")
        }
        List {
          ForEach(items, id: \.self) { item in
            NavigationLink {
              AddShoppingListItemView(shoppingList: shoppingList, itemToEdit: item)
            } label: {
              ShoppingItemCell(item: item, selected: selectedItemIds.contains(item.id)) { selected in
                selectedItemIds.append(item.id)
                if let indexToDelete = shoppingList.items.firstIndex(where: {$0.id == item.id}) {
                  $shoppingList.items.remove(at: indexToDelete)
                }
              }
            }
          }
          .onDelete(perform: $shoppingList.items.remove)
        }
        .navigationTitle(shoppingList.title)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            isPresented = true
          }, label: {
            Image(systemName: "plus")
          })
        }
      }
      .sheet(isPresented: $isPresented) {
        AddShoppingListItemView(shoppingList: shoppingList)
      }
    }
}

#Preview {
  NavigationStack {
    ShoppingListItemsView(shoppingList: ShoppingList())
  }
}
