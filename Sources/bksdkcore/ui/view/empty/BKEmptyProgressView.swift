//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

public class BKEmptyProgressView: UIView {
    //MARK: IBOutlets
    @IBOutlet var rootView: UIView! {
        didSet {
            rootView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var progressEmptyImageView: UIImageView! {
        didSet {
            progressEmptyImageView.image = UIImage(
                named: "empty_sad_bubbles_logo",
                find: .sdk
            )
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.font = .abelRegular30
            messageLabel.textColor = .white
            messageLabel.text = BKSdkCoreLocalization.sorryNoProgressList.localize
        }
    }
    
    //MARK: Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    //MARK: Functions
    private func commonInit() {
        Bundle.module.loadNibNamed("BKEmptyProgressView", owner: self, options: nil)
        self.addSubview(self.rootView)
        self.rootView.frame = self.bounds
        self.rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
