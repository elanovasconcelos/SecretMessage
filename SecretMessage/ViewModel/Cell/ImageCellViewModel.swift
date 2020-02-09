//
//  ImageCellViewModel.swift
//  SecretMessage
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ImageCellViewModel: NSObject, CellViewModelProtocol {
    
    let type: CellType = .image
    let data: Data
    let image: Observable<UIImage?>
    
    init(data: Data) {
        self.data = data
        self.image = Observable<UIImage?>(nil)
        
        super.init()
        
        ImageCellViewModel.generateQRCode(from: data) { (result) in
            self.image.value = result
        }
    }
    
    static func generateQRCode(from data: Data, completionHandler: @escaping (UIImage?) -> Void) {

        ThreadHelper.background {
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)

                if let output = filter.outputImage?.transformed(by: transform) {
                    completionHandler(UIImage(ciImage: output))
                    return
                }
            }
            
            completionHandler(nil)
        }
    }
}
