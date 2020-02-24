//
//  CardAnimator.swift
//  MovieToWatch
//
//  Created by Clark on 17/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CardPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    var originFrame = CGRect.zero
    weak var cell: CardViewCell!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.view(forKey: .to) else {print("there is no toView"); return}
        
        let containerView = transitionContext.containerView
        let initialFrame = originFrame
        let finalFrame = toView.frame
        
        containerView.addSubview(toView)
        toView.translatesAutoresizingMaskIntoConstraints = false
        
        let cardWidthConstraint = toView.widthAnchor.constraint(equalToConstant: initialFrame.width)
        let cardHeightConstraint = toView.heightAnchor.constraint(equalToConstant: initialFrame.height)
        let cardTopAnchorConstraint = toView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: originFrame.origin.y)
        let cardCenterXAnchorConstraint = toView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: originFrame.midX - containerView.frame.midX)
        
        let toViewConstraints = [
            cardTopAnchorConstraint,
            cardCenterXAnchorConstraint,
            cardWidthConstraint,
            cardHeightConstraint,
        ]
        NSLayoutConstraint.activate(toViewConstraints)
        toView.layer.cornerRadius = CGFloat(Constants.CARD_CORNER_RADIUS)
        
        containerView.layoutIfNeeded()
        cell.isHidden = true
        // animate expansion to fill out the space
        UIView.animate(withDuration: duration/2, animations: {
            cardWidthConstraint.constant = finalFrame.width
            cardHeightConstraint.constant = finalFrame.height
            cardCenterXAnchorConstraint.constant = 0
            containerView.layoutIfNeeded()
        })
        
        
        // animate spring upwards
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveLinear], animations: {
            cardTopAnchorConstraint.constant = 0
            containerView.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: duration) {
            toView.layer.cornerRadius = 0
            containerView.layoutIfNeeded()
        }
        
        transitionContext.completeTransition(true)
    }
}


class CardDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.6
    var originFrame = CGRect.zero
    weak var cell: CardViewCell!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else {fatalError("There is no fromView in card dismiss animator")}
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? MovieDetailViewController else {fatalError("There is no fromVC in card dismiss animator")}

        fromView.translatesAutoresizingMaskIntoConstraints = false
        containerView.removeConstraints(containerView.constraints)
        fromView.removeConstraints(fromView.constraints)
        containerView.addSubview(fromView)
        
        let centerXAnchor = fromView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let widthAnchor = fromView.widthAnchor.constraint(equalToConstant: containerView.frame.width)
        let heightAnchor = fromView.heightAnchor.constraint(equalToConstant: containerView.frame.height)
        let centerYAnchor = fromView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        [centerXAnchor, centerYAnchor, widthAnchor, heightAnchor].forEach {
            $0.isActive = true
        }
        
        fromView.clipsToBounds = true // for corner radius animation

        containerView.layoutIfNeeded()

        UIView.animate(withDuration: duration/2) {
            fromVC.collectionView.setContentOffset(.zero, animated: false)
            //fromVC.collectionView.scrollToItem(at: .init(row: 0, section: 0), at: .bottom, animated: false)
        }

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            centerYAnchor.constant = self.originFrame.midY - containerView.frame.midY
            widthAnchor.constant = self.originFrame.width
            heightAnchor.constant = self.originFrame.height
            //centerXAnchor.constant = self.originFrame.midX - containerView.frame.midX
            fromView.layer.cornerRadius = CGFloat(Constants.CARD_CORNER_RADIUS)
            containerView.layoutIfNeeded()
        }) { (finished) in
            self.cell.isHidden = false
            fromView.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
        
        
    }
}
