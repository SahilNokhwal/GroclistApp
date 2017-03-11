import Foundation
class Shoper {
    var id : Int
    var price : String
    var product : String
    var quantity : String
    init(id : Int , product : String ,quantity : String,price: String) {
        self.id = id
        self.price = price
        self.product = product
        self.quantity = quantity
    }
}