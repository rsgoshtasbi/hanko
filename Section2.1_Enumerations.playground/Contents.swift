import UIKit

var greeting = "Hello, playground"

// MARK: - Creating an Enum
//enum LightSwitchState {
//    case on, off
////    case off - additional way
//}


// MARK: - Setting Values to Enum
enum LightSwitchState: String {
    case on = "ON"
    case off = "OFF"
    case niether = "NEITHER"
}



// MARK: - Raw Values
print(LightSwitchState.on.rawValue)
print(LightSwitchState.off.rawValue)

enum LightSwitchStateNumber: Int {
    case on, off
}
print(LightSwitchStateNumber.on.rawValue)
print(LightSwitchStateNumber.off.rawValue)


// MARK: - Value Matching

func lightSwitchPressed(_ lightSwitchState: LightSwitchState) -> String {
    if lightSwitchState == .on {
        return "Turn lights off"
    } else if lightSwitchState == .off {
        return "Turn lights on"
    }
    
    return "Light switch is neither on nor off"
}

lightSwitchPressed(.off)

func lightSwitchPressedSwitchStatement(_ lightSwitchState: LightSwitchState) -> String {
    switch lightSwitchState {
    case .on:
        return "turn lights off"
    case .off:
        return "turn light on"
    default:
        return "light switch is neither on nor off"
    }
}
lightSwitchPressedSwitchStatement(.off)


// MARK: - Associated Values

enum Plant {
    case succulent(String)
    case pothos(String)
}

var selectPlant = Plant.succulent("Agave")

switch selectPlant {
case .succulent(let type):
    print("Succulent type selected: \(type)")
case .pothos(let type):
    print("Pothos type select: \(type)")
}

selectPlant = Plant.pothos("Marble Queen")
switch selectPlant {
case .succulent(let type):
    print("Succulent type selected: \(type)")
case .pothos(let type):
    print("Pothos type select: \(type)")
}
// MARK: - CaseIterable

enum PlantFamily: CaseIterable {
    case succulent
    case pothos
    case bonsai
    case cactus
}

let allPlantFamilies = PlantFamily.allCases
allPlantFamilies.count


// MARK: - Enumeration Article

// the int is the number in the order of the cases
enum PlantType: Int, CaseIterable {
    case succulent
    case pothos
    case bonsai
    case cactus
}

let allPlantTypes = PlantType.allCases

// Loop through plant types and print out the type of plant and its Int values.
allPlantTypes.forEach { plantType in
    print("Plant Type: \(plantType) | Raw Value: \(plantType.rawValue)")
}


// MARK: - Computer property with Getter and Setters
var selectedLocation: String = ""

var city = "Irvine"
var state = "CA"

var location: String {
    get {
        return "\(city), \(state)"
    }
    set (newLocation){
        // this "newLocation" keyword can be whatever you want it to be
        // it is just the name given for the String passed to location
        // IF WE DO THIS, we need to put newLocation in parenthasis next to set
        // OR by default, just use the built in "newValue"
        selectedLocation = newLocation
    }
}

location
location = "Nashville, TN"  // "Nashville, TN"
print("City and State: \(selectedLocation)")  // prints "City and State: Nashville, TN"
