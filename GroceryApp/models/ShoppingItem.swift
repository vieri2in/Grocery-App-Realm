//
//  ShoppingItem.swift
//  GroceryApp
//
//  Created by bin li on 7/22/23.
//

import Foundation
import RealmSwift
class ShoppingItem: Object, Identifiable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var title: String
  @Persisted var quantity: Int
  @Persisted var category: String
  override class func primaryKey() -> String? {
    return "id"
  }
}
