//
//  ViewController.swift
//  CoreMLPractice
//
//  Created by 大容 林 on 2018/1/23.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func cameraBtnClick(_ sender: Any) {
        present(imagePicker, animated: true) {
            
        }
    }
    @IBOutlet weak var itemLabel: UILabel!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickImage
            guard let ciimage = CIImage(image: pickImage) else {
                fatalError("Can't not convert image to ciimage,")
            }
            detect(sourceImage: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func detect(sourceImage: CIImage)  {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Error line 29.")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Error line 37.")
            }
            if let firstResult = results.first {
                self.itemLabel.text = firstResult.identifier
            }
            print(results)
           
        }
        let handler = VNImageRequestHandler(ciImage: sourceImage)
        do{
            try handler.perform([request])
        }catch{
            print("Error line 44.")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
}

