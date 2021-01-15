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
    
    func openShareController(sender: UIGestureRecognizer) {
        if sender.state == .ended {
            print("share controller opened")
            ///Defining the main view (defined in asImage()) as the activityItems' image of the viewController
            let image = asImage()
            let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
            viewController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    self.gridAnimation(x: 0, y: 0)
                } else {
                    self.gridAnimation(x: 0, y: 0)
                }
            }
            /// Creating the popOverController (the sharing menu)
            if let popoverController = viewController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = self.view.bounds
            }
            /// Then present the viewController define in lines above
            present(viewController, animated: true, completion: nil)
        }
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
    func gridAnimation(x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.mainView?.transform = CGAffineTransform(translationX: x, y: y)
        })
    }
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                print("case up")
                self.gridAnimation(x: 0, y: -900)
                openShareController(sender: sender)
            }
        case .left:
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                print("case left")
                self.gridAnimation(x: -900, y: -0)
                openShareController(sender: sender)
            }
        default: break
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
        /// Activate the animation that open the library, if disabled nothing happened after taping button
        present(imagePicker, animated: true, completion: nil)
    }
}
