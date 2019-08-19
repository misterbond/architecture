//
//  Scenario.swift
//  Architecture
//
//  Created by Ilya Bondarenko on 16.08.2019.
//  Copyright © 2019 Design and Test Lab. All rights reserved.
//

import Foundation

// Interface for scenario
protocol ScenarioInterface {
    
    // The delegate object for callbacks
    var delegate: ScenarioDelegate? { get }
    
    // An array of child scenarios
    var childScenarios: [Scenario]! { get }
    
    // The root view controller for present/push a new view controller
    var rootVC: UIViewController! { get }
    
    // This method executes actions to start the scenario
    func start()
    
    // This method executes actions to stop the scenario
    func stop()
}


// This delegate is the basis for the scenario and serves to communicate between scenarios
protocol ScenarioDelegate: class {
    func didFinish(scenario: Scenario)
}


// This class implements the mediator pattern.
// It stores all the logic associated with some view controller.
// This class also implements a ScenarioInterface protocol.
class Scenario: NSObject, ScenarioInterface {
    
    weak var delegate: ScenarioDelegate?
    
    private(set) var rootVC: UIViewController!
    
    private(set) var childScenarios: [Scenario]! = [Scenario]()
    
    // MARK: - Init method
    
    init(delegate: ScenarioDelegate? = nil, rootVC: UIViewController!) {
        self.delegate = delegate
        self.rootVC = rootVC
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
}


// MARK: - Add and start a new scenario


enum AddChildScenarioError: Error {
    case cantAddScenarioAsChild
}


// An extension of Scenario class for implement additional funcions linked with start a new scenario.
extension Scenario {
    
    func start(scenario: Scenario) {
        do {
            try insertChildScenario(scenario: scenario)
            scenario.start()
        } catch AddChildScenarioError.cantAddScenarioAsChild {
            NSLog("The scenario can't be a child for itself")
        } catch _ {
            NSLog("Unknown error")
        }
    }
    
    private func insertChildScenario(scenario: Scenario!) throws {
        if scenario == self { throw AddChildScenarioError.cantAddScenarioAsChild }
        childScenarios.append(scenario)
    }
}

// An extension of Scenario class for implements a ScenarioDelegate protocol.
extension Scenario: ScenarioDelegate {
    
    func didFinish(scenario: Scenario) {
        scenario.stop()
        childScenarios.removeAll { (sc) -> Bool in return sc == scenario }
    }
}
