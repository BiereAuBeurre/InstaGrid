//
//  GridViewController.swift
//  instaGrid
//
//  Created by Manon Russo on 14/12/2020.
//

import UIKit

final class GridViewController: UIViewController {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private var photoButtons: [UIButton]!
    @IBOutlet private var layoutButtons: [UIButton]!
    private weak var pictureButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutButtons[0].isSelected = true
    }
    
    private func asImage() -> UIImage? {
        /// Defining the mainView.
        UIGraphicsBeginImageContext(mainView.frame.size)
        mainView.layer.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetCurrentContext(), let cgImage = image.makeImage() {
            UIGraphicsEndImageContext()
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    private func openShareController(sender: UIGestureRecognizer) {
        /// Defining the main view (defined in asImage()) as the activityItems' image of the viewController.
        if sender.state == .ended, let image = asImage() {
            print("share controller opened")
            let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
            viewController.completionWithItemsHandler = { (nil, completed, _, error) in
                if completed {
                    self.gridAnimation(x: 0, y: 0)
                } else {
                    self.gridAnimation(x: 0, y: 0)
                }
            }
            /// Creating the popOverController (the sharing menu).
            if let popoverController = viewController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = self.view.bounds
            }
            /// Then present the viewController define in lines above.
            present(viewController, animated: true, completion: nil)
        }
    }
}

extension GridViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ///Add the animation (progressive disapearance of the photo menu)  when the picture is picked.
        picker.dismiss(animated: true) { [weak self] in
            if let image = info[.originalImage] as? UIImage {
                /// Indicate to set the selectionned picture (let image) in the selectionned picture button.
                self?.pictureButton?.setImage(image, for: .normal)
                /// Then said that the picture'll fill the selectionned button.
                self?.pictureButton?.imageView?.contentMode = .scaleAspectFill
            }
        }
    }
}

extension GridViewController: UINavigationControllerDelegate {
}

private extension GridViewController {
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
    
    func hideGridButton(topLeft: Bool, bottomRight: Bool) {
        photoButtons[0].isHidden = topLeft
        photoButtons[3].isHidden = bottomRight
    }
    
    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        for button in layoutButtons {
            button.isSelected = false
        }
        sender.isSelected = true
        
        if sender == layoutButtons[0] {
            hideGridButton(topLeft: true, bottomRight: false)
        } else if sender == layoutButtons[1] {
            hideGridButton(topLeft: false, bottomRight: true)
        } else {
            hideGridButton(topLeft: false, bottomRight: false)
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
