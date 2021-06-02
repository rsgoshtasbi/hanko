import UIKit

// MARK: - Creating Closure
//var orderCoffee = {
//    print("Order a fresh cup of coffee")
//}
//orderCoffee()

// MARK: - Adding Parameters
//var orderCoffee = { (coffeeRoast: String) in
//    print("Hello, thank you for ordering a \(coffeeRoast) roast coffee.")
//}
//orderCoffee("Light")


// MARK: - Returning Values
var orderCoffee = { (coffeeRoast: String) -> String in
    return "Hello, thank you for ordering a \(coffeeRoast) roast coffee."
}
let orderCoffeeOutput = orderCoffee("Dark")
print(orderCoffeeOutput)


// MARK: - Closures as a Method Argument
var purchaseCoffee = {
    print("Purchase a fresh cup of coffee")
}

func completeOrder(purchaseCoffee: () -> Void) {
    print("Confirming payment method")
    purchaseCoffee()
    print("Your coffee will be delivered in 30 minutes")
}

completeOrder(purchaseCoffee: purchaseCoffee)


// MARK: - Initializing Properties with Closures

// this approach has to wait for the viewdidload.
// instead we could just instantiate the titleLabel with a closure
// that will define all the properties at initialization... see bottom example
//class ViewController: UIViewController {
//    var titleLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.text = "Title"
//        titleLabel.backgroundColor = .blue
//
//        view.addSubview(titleLabel)
//        // add constraints if needed
//    }
//}

class ViewController: UIViewController {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.backgroundColor = .blue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        // add constraints if needed
    }
}
