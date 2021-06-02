import UIKit

class Education {
    var usedToLearn: Bool
    
    init(usedToLearn: Bool) {
        self.usedToLearn = usedToLearn
    }
}

class Cohorts: Education {
    var canMeetPeople: Bool
    
    init(canMeetPeople: Bool, usedToLearn: Bool) {
        self.canMeetPeople = canMeetPeople
        super.init(usedToLearn: usedToLearn)
    }
}

class StudyGroup: Cohorts {
    var hasCoffee: Bool
    
    init(hasCoffee: Bool, canMeetPeople: Bool, usedToLearn: Bool) {
        self.hasCoffee = hasCoffee
        super.init(canMeetPeople: canMeetPeople, usedToLearn: usedToLearn)
    }
}

var test = StudyGroup(hasCoffee: true, canMeetPeople: true, usedToLearn: true)
test.usedToLearn


protocol BusinessLockable {
    var businessName: String { get }
    var city: String { get }
    func unlockDoors()
    func lockDoors()
}

extension BusinessLockable {
    
    var city: String {
        return "Irvine"
    }
    
    func unlockDoors() {
        // Use an API to unlock the business doors
        print("Unlock doors for \\(businessName)")
    }
    
    func lockDoors() {
        // Use an API to lock the business doors
        print("Lock doors for \\(businessName)")
    }
}


class Test: BusinessLockable {
    var businessName: String
    
    init() {
        self.businessName = "Rashid's Business"
    }
}

Test().businessName

// Delegate Design Pattern

// Delegation is commonly used with protocols. This defines what are the required methods or properties needed to start the job
protocol CoffeeOrderDelegate: AnyObject {
    func ordersCoffee()
}

class Assistant: CoffeeOrderDelegate  {
    
    func ordersCoffee() {
        // Calls and puts coffee orders in
        print("Call nearby coffee shop and puts in order")
    }
}

class Manager {
            
    weak var delegate: CoffeeOrderDelegate?
    
    init(delegate: CoffeeOrderDelegate) {
        self.delegate = delegate
    }
        
    func buysOfficeCoffee() {
        delegate?.ordersCoffee() // when this triggers, it notifies the delegate that its time for the action of ordering coffee
    }
}

let officeAssistant = Assistant() // The object that conforms to the delegate protocol that knows how to do the job

let officeManager = Manager(delegate: officeAssistant) // The object that doesn't know how to do the job but knows when it's needed
officeManager.buysOfficeCoffee() // Notifies the delegate that they can order coffee

//The officeAssistant object now prints "Call nearby coffee shop and puts in order"
