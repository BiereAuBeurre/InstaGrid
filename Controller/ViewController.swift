//
//  ViewController.swift
//  instaGrid
//
//  Created by Manon Russo on 14/12/2020.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var arrowSwipeView: UIImageView!
    @IBOutlet weak var textSwipeView: UIButton!
 
    var pictureButton: UIButton!

    @IBOutlet var photoButtons: [UIButton]!
    @IBOutlet var layoutButtons: [UIButton]!
    
    var imagePicker = UIImagePickerController()
    
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
    
    @IBAction func didTapMainViewbutton(_ sender: UIButton) {
        pictureButton = sender
        let imagePicker = UIImagePickerController()
        /// Quand touché, ouvre le menu pour sélectionner une image -> Ok
        /// Choisir une image -> Ok
        /// L'adapter au bouton (fill) -> /!\ à faire /!\
        /// Remplacer "+" par 'image choisie -> ok
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [weak self] in
            if let image = info[.originalImage] as? UIImage {
                self?.pictureButton?.setImage(image, for: .normal)
                self?.pictureButton?.imageView?.contentMode = .scaleAspectFill
            }
        }
    }
}


