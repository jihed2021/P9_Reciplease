//
//  Extensions.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 15/10/2021.
//

import Foundation
import UIKit
extension UIImageView {
    func load(urlImageString: String?) {
        guard let urlImageString = urlImageString else { return }
        guard let urlImage = URL(string: urlImageString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    self?.image = UIImage(named: "ImageDefault1024x768" + ".jpg")
                }
            }
        }
    }
}
