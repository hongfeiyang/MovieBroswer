//
//  PersonContainerController.swift
//  MovieToWatch
//
//  Created by Clark on 16/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonContainerController: BaseNavItemController {
    
    var introController = PersonIntroController()
    var detailController = PersonDetailController()
    var personId: Int! {
        didSet {
            let query = PersonDetailQuery(person_id: personId, append_to_response: [.movie_credits, .combined_credits])
            Network.getPersonDetail(query: query) { [weak self] (res) in
                switch res {
                case .success(let personDetail):
                    self?.introController.personDetail = personDetail
                    self?.detailController.personDetail = personDetail
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    let window = UIApplication.shared.windows[0]
    lazy var topPadding = window.safeAreaInsets.top
    lazy var bottomPadding = window.safeAreaInsets.bottom
    
    var detailControllerConstraints: AnchoredConstraints?
    lazy var detailControllerHeight: CGFloat = UIScreen.main.bounds.height - topPadding - profileImageViewCompactHeight
    lazy var profileImageViewFullHeight: CGFloat = UIScreen.main.bounds.height - topPadding - bottomPadding - self.introController.MOVIE_COLLECTION_VIEW_HEIGHT
    var profileImageViewCompactHeight: CGFloat = 90
    var profileImageViewCompactWidth: CGFloat = 60
    var profileImageViewCompactTrailingOffset: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(introController.view)
        addChild(introController)
        introController.didMove(toParent: self)
        introController.view.fillSuperview()
        introController.view.addGestureRecognizer(introControllerPanGestureRecogniser)
        
//        introController.profileImageView.layer.borderColor = UIColor.black.cgColor
//        introController.profileImageView.layer.borderWidth = 1
//        introController.nameLabelContainerView.layer.borderColor = UIColor.black.cgColor
//        introController.nameLabelContainerView.layer.borderWidth = 1
        
        view.addSubview(detailController.view)
        addChild(detailController)
        detailController.didMove(toParent: self)
        detailController.view.addGestureRecognizer(detailControllerPanGestureRecogniser)
        
        detailControllerConstraints = detailController.view.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topPadding, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: detailControllerHeight))
        detailController.view.addRoundedCorners(radius: 12, curve: .circular, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        detailController.view.addShadow(offset: .init(width: 1, height: -3), color: .label, radius: 6, opacity: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailControllerConstraints?.top?.constant = UIScreen.main.bounds.height
    }
    
    lazy var introControllerPanGestureRecogniser: UIPanGestureRecognizer = {
        let recogniser = UIPanGestureRecognizer()
        recogniser.addTarget(self, action: #selector(handlePanning(sender:)))
        return recogniser
    }()
    
    lazy var detailControllerPanGestureRecogniser: UIPanGestureRecognizer = {
        let recogniser = UIPanGestureRecognizer()
        recogniser.addTarget(self, action: #selector(handlePanning(sender:)))
        recogniser.delegate = self
        return recogniser
    }()
    
    private let popUpOffset = UIScreen.main.bounds.width
    private var detailControllerBeganOffset: CGFloat = 0
    private var animationProgress: CGFloat = 0
    private var state: State = .collapsed
    private enum State {
        case expanded
        case collapsed
        var change: State {
            switch self {
            case .expanded:
                return .collapsed
            case .collapsed:
                return .expanded
            }
        }
    }
    
    func toggle() {
        switch state {
        case .collapsed:
            showDetail()
        case .expanded:
            hideDetail()
        }
    }
    
    
    @objc func handlePanning(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            toggle()
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
            detailControllerBeganOffset = detailController.collectionView.contentOffset.y
        case .changed:
            if detailController.collectionView.contentOffset.y > 0 {
                return
            }
            let transition = sender.translation(in: view)
            let trueOffset = transition.y - detailControllerBeganOffset // true offset to adjust for continuous scroll from scrollview scrolling to top to dismiss animation
            var fraction = -trueOffset / popUpOffset
            if state == .expanded { fraction *= -1 }
            animator.fractionComplete = fraction + animationProgress
        case .ended:
            if detailController.collectionView.contentOffset.y > 0 {
                animator.stopAnimation(false)
                animator.finishAnimation(at: .start) // otherwise frame will not be reset
                return
            }
            let velocity = sender.velocity(in: view)
            let shouldComplete = state == .expanded ? velocity.y > 0 : velocity.y < 0
            if velocity.y == 0 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            animator.isReversed = shouldComplete ? false : true
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
    var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 0.55, curve: .easeInOut, animations: nil)
        animator.scrubsLinearly = false
        animator.isUserInteractionEnabled = false
        return animator
    }()

    private func showDetail() {
        self.view.layoutIfNeeded()
        introController.profileImageViewConstraints?.leading?.constant = UIScreen.main.bounds.width - profileImageViewCompactWidth - profileImageViewCompactTrailingOffset
        introController.profileImageViewConstraints?.height?.constant = profileImageViewCompactHeight
        introController.profileImageViewConstraints?.trailing?.constant = -profileImageViewCompactTrailingOffset
        detailControllerConstraints?.top?.constant = profileImageViewCompactHeight + topPadding
        let yScaleFactor = profileImageViewCompactHeight / introController.nameLabelContainerView.frame.height
        let xScaleFactor = (UIScreen.main.bounds.width - profileImageViewCompactWidth - profileImageViewCompactTrailingOffset) / introController.nameLabelContainerView.frame.width
        let scaleFactor = min(xScaleFactor, yScaleFactor)
        let xTranslationValue: CGFloat = (introController.nameLabelContainerView.frame.width * (scaleFactor-1) - profileImageViewCompactTrailingOffset) / 2
        let yTranslationValue = (introController.nameLabelContainerView.frame.height * (scaleFactor-1)) / 2
        let transform = CGAffineTransform(translationX: xTranslationValue, y: yTranslationValue).concatenating(.init(scaleX: scaleFactor, y: scaleFactor))
        animator.addAnimations {
            self.introController.collectionView.alpha = 0
            self.introController.stackView.alpha = 0
            self.introController.nameLabelContainerView.transform = transform
            self.view.layoutIfNeeded()
        }
        
        animator.addCompletion { (position) in
            switch position {
            case .start:
                // handle fail, which means reverting back to starting position
                self.introController.profileImageViewConstraints?.leading?.constant = 0
                self.introController.profileImageViewConstraints?.height?.constant = self.profileImageViewFullHeight
                self.introController.profileImageViewConstraints?.trailing?.constant = 0
                self.detailControllerConstraints?.top?.constant = UIScreen.main.bounds.height
            case .current:
                break
            case .end:
                self.state = self.state.change
            default:
                ()
            }
        }
        
        animator.startAnimation()
    }
    
    private func hideDetail() {
        
        self.view.layoutIfNeeded()
        introController.profileImageViewConstraints?.leading?.constant = 0
        introController.profileImageViewConstraints?.height?.constant = profileImageViewFullHeight
        introController.profileImageViewConstraints?.trailing?.constant = 0
        detailControllerConstraints?.top?.constant = UIScreen.main.bounds.height
        animator.addAnimations {
            self.introController.collectionView.alpha = 1
            self.introController.stackView.alpha = 1
            self.introController.nameLabelContainerView.transform = .identity
            self.view.layoutIfNeeded()
        }
        
        animator.addCompletion { (position) in
            switch position {
            case .start:
                self.introController.profileImageViewConstraints?.leading?.constant = UIScreen.main.bounds.width - self.profileImageViewCompactWidth - self.profileImageViewCompactTrailingOffset
                self.introController.profileImageViewConstraints?.height?.constant = self.profileImageViewCompactHeight
                self.introController.profileImageViewConstraints?.trailing?.constant = -self.profileImageViewCompactTrailingOffset
                self.detailControllerConstraints?.top?.constant = self.profileImageViewCompactHeight + self.topPadding
            case .current:
                break
            case .end:
                self.state = self.state.change
            default:
                ()
            }
        }
        animator.startAnimation()
    }
}


extension PersonContainerController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
