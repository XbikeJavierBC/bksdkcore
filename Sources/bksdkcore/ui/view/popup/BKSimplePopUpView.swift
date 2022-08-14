//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import TinyConstraints

public protocol BKSimplePopUpViewDelegate: AnyObject {
    func didAceptSelect(view: BKSimplePopUpView)
}

public class BKSimplePopUpView: UIView {
    //MARK: IBOutlets
    @IBOutlet var rootView: UIView! {
        didSet {
            rootView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 15
            containerView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.font = .abelRegular20
            messageLabel.textColor = .black
            messageLabel.text = BKSdkCoreLocalization.progressStored.localize
        }
    }
    
    @IBOutlet weak var okButton: UIButton! {
        didSet {
            okButton.setTitle(
                BKSdkCoreLocalization.ok.localize,
                for: .normal
            )
            
            okButton.setTitleColor(
                .disableTextColor,
                for: .normal
            )
            okButton.setTitleColor(
                .oragenColor,
                for: .selected
            )
            
            okButton.titleLabel?.font = .abelRegular15
            okButton.titleLabel?.textAlignment = .center
        }
    }
    
    //MARK: Variables
    public weak var delegate: BKSimplePopUpViewDelegate?
    
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
        Bundle.module.loadNibNamed("BKSimplePopUpView", owner: self, options: nil)
        self.addSubview(self.rootView)
        self.rootView.frame = self.bounds
        self.rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    //MARK: IBActions
    @IBAction func okButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        self.delegate?.didAceptSelect(view: self)
    }
    
    public func show() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let statusBarHeiht = UIApplication.shared.statusBarFrame.height
        var frameWindow = window.frame
        frameWindow.origin.y = frameWindow.origin.y - statusBarHeiht
        frameWindow.size.height = frameWindow.size.height + statusBarHeiht
        
        if self.superview == nil {
            self.alpha = 0.0
            self.frame = frameWindow
            window.addSubview(self)
            
            UIView.animate(
                withDuration: 0.33,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.alpha = 1.0
                },
                completion: nil
            )
        }
    }
    
    public func hide() {
        self.okButton.isSelected = false
        
        if self.superview == nil {
            return
        }
        
        UIView.animate(
            withDuration: 0.33,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.alpha = 0.0
            },
            completion: { _ in
                self.alpha = 1.0
                self.removeFromSuperview()
            }
        )
    }
}
