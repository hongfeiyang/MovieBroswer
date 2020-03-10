//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/14/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}

extension UIColor {
    
    static var contrastColor: UIColor {
        switch Constants.USER_INTERFACE_STYLE {
        case .dark:
            return UIColor.white
        case .light:
            return UIColor.black
        default:
            return UIColor.white
        }
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
    var complementaryColor: UIColor {
        var d: Float = 0

        // Counting the perceptive luminance - human eye favors green color...
        let luminance = 0.299 * self.rgba.red + 0.587 * self.rgba.green + 0.114 * self.rgba.blue

        if (luminance > 0.5) {
            d = 0 // bright colors - black font
        }
        else {
           d = 255 // dark colors - white font
        }

        return UIColor(red: CGFloat(d/255), green: CGFloat(d/255), blue: CGFloat(d/255), alpha: 1);
    }
}



func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let date = dateFormatter.date(from: dateString)
            return date ?? Date.distantPast
        })
        //decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        //encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, textColor: UIColor = .label, textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    static func symbolWithTintColor(symbol systemName: String, weight: UIImage.SymbolWeight = .regular, tintColor: UIColor = .label) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(weight: weight)
        let image = UIImage(systemName: systemName, withConfiguration: configuration)
        return image?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }
    
    
}

extension UIButton {
    convenience init(title: String, titleColor: UIColor = .label, font: UIFont = .systemFont(ofSize: 15)) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        self.init(frame: .zero)
        self.axis = axis
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
}

extension UIView {
    convenience init(hContentHugging hHuggingPriority: UILayoutPriority = .required, vContentHugging vHuggingPriority: UILayoutPriority = .required, hCompressionResistancePriority hCompressionPriority: UILayoutPriority = .required, vCompressionResistancePriority vCompressionPriority: UILayoutPriority = .required) {
        self.init(frame: .zero)
        setContentHuggingPriority(hHuggingPriority, for: .horizontal)
        setContentHuggingPriority(vHuggingPriority, for: .vertical)
        setContentCompressionResistancePriority(hCompressionPriority, for: .horizontal)
        setContentCompressionResistancePriority(vCompressionPriority, for: .vertical)
    }
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
    
    static var separatorView: UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.backgroundColor = .separator
        view.clipsToBounds = true
        view.layer.cornerRadius = 1
        return view
    }
    
    
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(endEditingRecognizer())
    }


    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //tap.cancelsTouchesInView = false
        return tap
    }

    @objc private func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.firstResponder?.resignFirstResponder()
    }
    
    func presentAlert(title: String = "Error", message: String?) {
        // need to put the creation of UIAlertController in main thread to avoid warning
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Fuck", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}



extension Encodable {
    
    var JSONData: Data? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            return jsonData
        }
        catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
    
    var URLQueryItems: [URLQueryItem]? {
        let coder = JSONEncoder()
        do {
            let jsonData = try coder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments])
            guard let dict = jsonObject as? [String: Any?] else { print("cannot convert jsonObject to dictionary"); return nil }
            
            var items = [URLQueryItem]()
            for (key, value) in dict {
                if value != nil {
                    if let string = value as? String {
                        items.append(URLQueryItem(name: key, value: string))
                    } else if let int = value as? Int {
                        items.append(URLQueryItem(name: key, value: String(int)))
                    } else if let bool = value as? Bool {
                        items.append(URLQueryItem(name: key, value: String(bool)))
                    } else {
                        print("Warning: Unencoded data type found")
                        items.append(URLQueryItem(name: key, value: ""))
                    }
                }
            }
            return items
        } catch let err {
            print(err)
            return nil
        }
    }
}
