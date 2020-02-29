//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/14/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

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
    
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
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
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
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
            print(err.localizedDescription)
            return nil
        }
    }
}
