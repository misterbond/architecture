//
//  TabBarScenario.swift
//  Architecture
//
//  Created by Ilya Bondarenko on 19.08.2019.
//  Copyright © 2019 Design and Test Lab. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarScenarioInterface: ScenarioInterface {
    // The navigation controller object for the tab view controller
    var nvc: UINavigationController? { get }
}

class TabBarScenario: Scenario, TabBarScenarioInterface {
    var nvc: UINavigationController?
}
