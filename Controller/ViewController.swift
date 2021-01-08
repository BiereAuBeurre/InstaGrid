//
//  ViewController.swift
//  instaGrid
//
//  Created by Manon Russo on 14/12/2020.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var holderSwipeView: UIStackView!
    
    @IBOutlet weak var arrowSwipeView: UIImageView!
    
    
    @IBOutlet weak var textSwipeView: UIButton!
    
    @IBOutlet weak var holderMainView: UIView!
    
    
    @IBOutlet weak var photoButton1: UIButton!
    
    @IBOutlet weak var photoButton2: UIButton!
    
    @IBOutlet weak var photoButton3: UIButton!
    
    @IBOutlet weak var photoButton4: UIButton!
    
    @IBOutlet weak var holderLayoutsView: UIStackView!
    
    @IBOutlet weak var layoutButton1: UIButton!
    
    @IBOutlet weak var layoutButton2: UIButton!
    
    @IBOutlet weak var layoutButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonLayout1Pressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        photoButton1.isHidden = true
        photoButton3.isHidden = false
    }
    
    @IBAction func buttonLayout2Pressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        photoButton1.isHidden = false
        photoButton3.isHidden = true
    }
    
    @IBAction func buttonLayout3Pressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        photoButton1.isHidden = false
        photoButton3.isHidden = false
    }
    
}

