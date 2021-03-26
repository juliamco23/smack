//
//  ChannelVC.swift
//  smack
//
//  Created by Juliam Costa on 25/03/2021.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70

    }
}
