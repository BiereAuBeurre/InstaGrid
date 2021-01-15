//
//  GridViewController.swift
//  instaGrid
//
//  Created by Manon Russo on 14/12/2020.
//

import UIKit

final class GridViewController: UIViewController {
    
    @IBOutlet weak var arrowSwipeView: UIImageView!
    @IBOutlet weak var textSwipeView: UILabel!
    @IBOutlet weak var fullSwipeView: UIStackView!
    @IBOutlet weak var mainView: UIView!
    
    var pictureButton: UIButton!
    
    @IBOutlet var photoButtons: [UIButton]!
    @IBOutlet var layoutButtons: [UIButton]!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func asImage() -> UIImage {
        ///Defining the mainView
        UIGraphicsBeginImageContext(mainView.frame.size)
        mainView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetCurrentContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image!.makeImage()!)
    }
}

extension GridViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ///Add the animation (progressive disapearance of the photo menu)  when the picture is picked
        picker.dismiss(animated: true) { [weak self] in
            if let image = info[.originalImage] as? UIImage {
                /// Indicate to set the selectionned picture (let image) in the selectionned picture button
                self?.pictureButton?.setImage(image, for: .normal)
                /// Then said that the picture'll fill the selectionned button
                self?.pictureButton?.imageView?.contentMode = .scaleAspectFill
            }
        }
    }
}

extension GridViewController: UINavigationControllerDelegate {
}

extension GridViewController {
    func moveUp(view: UIView) {
        view.center.y -= 900
    }
    
    func moveBackDown(view: UIView) {
        view.center.y += 900
    }
    
    func moveLeft(view:UIView) {
        view.center.x -= 900
    }
  
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        /*Find out how to make the main view come back only when the action is ended*/

        switch sender.direction {
        case .up:
            print("case up")
            let duration: Double = 1.0
            UIView.animate(withDuration: duration, animations: {
                self.moveUp(view: self.mainView)
            })
//            { (_) in
//                    self.moveBackDown(view: self.mainView)
//            }
        case.left:
            print("case left")
        default:
            print("default")
        }
        if sender.state == .ended {
            print("did swipe")
            ///Defining the main view (defined in asImage()) as the activityItems' image of the viewController
            let image = asImage()
            let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
            viewController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.moveBackDown(view: self.mainView)
                    }) } else {
                        UIView.animate(withDuration: 0.5, animations: {
                            self.moveBackDown(view: self.mainView)
                        }) }
            }
            /// Creating the popOverController (the sharing menu)
            if let popoverController = viewController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = self.view.bounds
            }
            /// Then present the viewController define in lines above
            present(viewController, animated: true, completion: nil)
            //            viewWillAppear(true)
        }
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
            layoutButtons[0].imageView?.isHidden = true
            photoButtons[3].isHidden = true
            photoButtons[0].isHidden = false
        } else {
            layoutButtons[0].imageView?.isHidden = true
            photoButtons[0].isHidden = false
            photoButtons[3].isHidden = false
        }
    }
    
    @IBAction func didTapMainViewbutton(_ sender: UIButton) {
        pictureButton = sender
        let imagePicker = UIImagePickerController()
        /// Indicate that the source of the picture's going to be the potoLibrary
        imagePicker.sourceType = .photoLibrary
        /// Indicate to the picture to place itself where the user tap
        imagePicker.delegate = self
        /// Allow the editing by resizing, useless because of the content mode scaleAspectFill below  :
        /*imagePicker.allowsEditing = true*/
        /// Activate the animation that open the library, if disabled nothing happened after taping button
        present(imagePicker, animated: true, completion: nil)
    }
}
