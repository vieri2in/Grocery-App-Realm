//
//  ShoppingItemCell.swift
//  GroceryApp
//
//  Created by bin li on 7/23/23.
//

import SwiftUI

struct ShoppingItemCell: View {
  let item: ShoppingItem
  var selected: Bool
  let isSelected: (Bool) -> Void
  var body: some View {
    HStack {
      Image(systemName: selected ? "checkmark.square" : "square")
        .onTapGesture {
          isSelected(!selected)
        }
      VStack(alignment: .leading) {
        Text(item.title)
        Text(item.category)
          .opacity(0.4)
      }
      Spacer()
      Text("\(item.quantity)")
    }.opacity(selected ? 0.4 : 0.8)
  }
}
#Preview {
  ShoppingItemCell(item: ShoppingItem(), selected: true, isSelected: {_ in })
}
