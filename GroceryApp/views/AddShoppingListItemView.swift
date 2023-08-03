//
//  AddShoppingListItemView.swift
//  GroceryApp
//
//  Created by bin li on 7/22/23.
//

import SwiftUI
import RealmSwift
struct AddShoppingListItemView: View {
  @ObservedRealmObject var shoppingList: ShoppingList
  var itemToEdit: ShoppingItem?
  @Environment(\.dismiss) private var dismiss
  @State private var title: String = ""
  @State private var quantity: String = ""
  @State private var selectedCategory: String = ""
  let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
  let data = ["Produce", "Fruit", "Meat", "Condiments", "Beverage", "Snacks", "Dairy"]
  init(shoppingList: ShoppingList, itemToEdit: ShoppingItem? = nil){
    self.shoppingList = shoppingList
    self.itemToEdit = itemToEdit
    if let itemToEdit = itemToEdit {
      _title = State(initialValue: itemToEdit.title)
      _quantity = State(initialValue: String(itemToEdit.quantity))
      _selectedCategory = State(initialValue: itemToEdit.category)
    }
  }
  private var isEditing: Bool {
    itemToEdit == nil ? false : true
  }
  var body: some View {
    VStack {
      if !isEditing {
        Text("Add Item")
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.largeTitle)
          .fontWeight(.bold)
      }
      LazyVGrid(columns: columns) {
        ForEach(data, id: \.self) { item in
          Text(item)
            .padding(8)
            .fontWeight(.light)
            .frame(width: 120)
            .background(selectedCategory == item ? .orange : .green)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .foregroundColor(.white)
            .onTapGesture {
              selectedCategory = item
            }
        }
      }
      Spacer()
        .frame(height: 60)
      TextField("Title", text: $title)
        .textFieldStyle(.roundedBorder)
      TextField("Quantity", text: $quantity)
        .textFieldStyle(.roundedBorder)
      Button {
        if let _ = itemToEdit {
          update()
        } else {
          save()
        }
        dismiss()
      } label: {
        Text(isEditing ? "Update" : "Save")
          .frame(maxWidth: .infinity, maxHeight: 40)
      }
      .buttonStyle(.bordered)
      .padding(.top, 20)
      Spacer()
        .navigationTitle(isEditing ? "Update Item" : "Add Item")
    }
    .padding()
  }
  private func save() {
    let shoppingItem = ShoppingItem()
    shoppingItem.title = title
    shoppingItem.quantity = Int(quantity) ?? 1
    shoppingItem.category = selectedCategory
    $shoppingList.items.append(shoppingItem)
  }
  private func update() {
    if let itemToEdit = itemToEdit {
      do {
        let realm = try Realm()
        guard let objectToUpdate = realm.object(ofType: ShoppingItem.self,
                                                forPrimaryKey: itemToEdit.id) else { return }
        try realm.write {
          objectToUpdate.title = title
          objectToUpdate.quantity = Int(quantity) ?? 1
          objectToUpdate.category = selectedCategory
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
#Preview {
  AddShoppingListItemView(shoppingList: ShoppingList())
}
