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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }
}

