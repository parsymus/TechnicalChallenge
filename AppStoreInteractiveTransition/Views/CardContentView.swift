//
//  CardContentView.swift
//  AppStoreHomeInteractiveTransition
//
//  Created by Wirawit Rueopas on 3/4/2561 BE.
//  Copyright © 2561 Wirawit Rueopas. All rights reserved.
//

import UIKit

//Added by Laurent
protocol CardCloseDelegate: class {
    func closeBtnClicked()
}

@IBDesignable final class CardContentView: UIView, NibLoadable {

    var viewModel: CardContentViewModel? {
        didSet {
            if let vm = viewModel {
                primaryLabel.text = vm.primary
                secondaryLabel.text = vm.secondary
                detailLabel.text = vm.description
                imageView.image = vm.image
                iconImageView.image = vm.appIcon
                closeButton.isHidden = !vm.isFullScreen
            }
        }
    }

    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var imageToTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToLeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToTrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToBottomAnchor: NSLayoutConstraint!

    /* Laurent: I Added a delegate to inform the ViewController
     the close button has been pressed */
    weak var closeDelegate: CardCloseDelegate?
    
    @IBAction func closeCard(_ sender: UIButton) {
        closeDelegate?.closeBtnClicked()
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return self.imageView.image
        }

        set(image) {
            self.imageView.image = image
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        commonSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonSetup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }

    private func commonSetup() {
        // *Make the background image stays still at the center while we animationg,
        // else the image will get resized during animation.
        imageView.contentMode = .center
        setFontState(isHighlighted: false)
    }

    // This "connects" highlighted (pressedDown) font's sizes with the destination card's font sizes
    func setFontState(isHighlighted: Bool) {
        if isHighlighted {
            primaryLabel.font = UIFont.systemFont(ofSize: 36 * GlobalConstants.cardHighlightedFactor, weight: .bold)
            secondaryLabel.font = UIFont.systemFont(ofSize: 18 * GlobalConstants.cardHighlightedFactor, weight: .semibold)
        } else {
            primaryLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
            secondaryLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }
}
