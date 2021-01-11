//
//  ViewController.swift
//  instaGrid
//
//  Created by Manon Russo on 14/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var arrowSwipeView: UIImageView!

    @IBOutlet weak var textSwipeView: UIButton!
 

    @IBOutlet var photoButtons: [UIButton]!
    @IBOutlet var layoutButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        for button in layoutButtons {
            button.isSelected = false
        }
        sender.isSelected = true
        
        if sender == layoutButtons[0] {
            photoButtons[0].isHidden = true
            photoButtons[3].isHidden = false

        } else if sender == layoutButtons[1] {
            photoButtons[3].isHidden = true
            photoButtons[0].isHidden = false
        } else {
            photoButtons[0].isHidden = false
            photoButtons[3].isHidden = false
        }
    }
    
/*
    
    @IBAction func buttonLayout3Pressed(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        photoButton1.isHidden = false
        photoButton3.isHidden = false
    }
    */
}

