//
//  NavController.swift
//  speak
//
//  Created by Anya Akbar on 28/04/21.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.prefersLargeTitles = true
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "Bold"),
            NSAttributedString.Key.font: UIFont.Bold(size: 40)
        ]
        
        self.navigationBar.largeTitleTextAttributes = attrs as [NSAttributedString.Key : Any]
   
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
