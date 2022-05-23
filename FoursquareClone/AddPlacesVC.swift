//
//  AddPlacesVC.swift
//  FoursquareClone
//
//  Created by emn on 8.05.2022.
//

import UIKit

class AddPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != ""{
            if let chosenImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmosphere = placeAtmosphereText.text!
                placeModel.placeImage = chosenImage
                
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Place Name/Type/Atmosphere", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }

        
    }
    }
    

    

