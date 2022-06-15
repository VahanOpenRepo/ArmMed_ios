//
//  PolicyViewVontrollerViewController.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 5/22/22.
//

import UIKit

class PolicyViewVontrollerViewController: UIViewController {

    @IBOutlet weak var privacyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        privacyTextView.setShadow()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
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
