//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import TinyConstraints

private enum BKYourTimeWasButton: Int {
    case store
    case delete
}

public protocol BKYourTimeWasViewDelegate: AnyObject {
    func didStoreSelect(view: BKYourTimeWasView)
    func didDeleteSelect(view: BKYourTimeWasView)
}

public class BKYourTimeWasView: UIView {
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
    
    @IBOutlet weak var timerTitleLabel: UILabel! {
        didSet {
            timerTitleLabel.font = .abelRegular20
            timerTitleLabel.textColor = .black
            timerTitleLabel.text = BKSdkCoreLocalization.yourTimeWas.localize
        }
    }
    
    @IBOutlet weak var timerLabel: UILabel! {
        didSet {
            timerLabel.font = .abelRegular25
            timerLabel.textColor = .black
            timerLabel.text = self.defaultTimerText
        }
    }
    
    @IBOutlet weak var distanceTitleLabel: UILabel! {
        didSet {
            distanceTitleLabel.font = .abelRegular20
            distanceTitleLabel.textColor = .black
            distanceTitleLabel.text = BKSdkCoreLocalization.distance.localize
        }
    }
    
    @IBOutlet weak var distanceLabel: UILabel! {
        didSet {
            distanceLabel.font = .abelRegular25
            distanceLabel.textColor = .black
            distanceLabel.text = self.defaultDistanceText
        }
    }
    
    @IBOutlet weak var storeButton: UIButton! {
        didSet {
            storeButton.setTitle(
                BKSdkCoreLocalization.store.localize,
                for: .normal
            )
            
            storeButton.setTitleColor(
                .disableTextColor,
                for: .normal
            )
            storeButton.setTitleColor(
                .oragenColor,
                for: .selected
            )
            
            storeButton.tag = BKYourTimeWasButton.store.rawValue
            storeButton.titleLabel?.font = .abelRegular15
            storeButton.titleLabel?.textAlignment = .center
        }
    }
    
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.setTitle(
                BKSdkCoreLocalization.delete.localize,
                for: .normal
            )
            
            deleteButton.setTitleColor(
                .disableTextColor,
                for: .normal
            )
            deleteButton.setTitleColor(
                .oragenColor,
                for: .selected
            )
            
            deleteButton.tag = BKYourTimeWasButton.delete.rawValue
            deleteButton.titleLabel?.font = .abelRegular15
            deleteButton.titleLabel?.textAlignment = .center
        }
    }
    
    @IBOutlet weak var containerStackView: UIStackView! {
        didSet {
            self.containerStackView.addSubview(self.lineView)
            self.lineView.topToSuperview()
            self.lineView.bottomToSuperview()
            self.lineView.centerXToSuperview()
        }
    }
    
    //MARK: Properties
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .oragenColor
        view.width(1)
        
        return view
    }()
    
    //MARK: Variables
    public weak var delegate: BKYourTimeWasViewDelegate?
    private let defaultTimerText = "00 : 00 : 00"
    private let defaultDistanceText = "0.0 km"
    
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
        Bundle.module.loadNibNamed("BKYourTimeWasView", owner: self, options: nil)
        self.addSubview(self.rootView)
        self.rootView.frame = self.bounds
        self.rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func hmsFrom(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    //MARK: IBActions
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonType = BKYourTimeWasButton(rawValue: sender.tag) {
            if buttonType == .store {
                sender.isSelected = true
                self.delegate?.didStoreSelect(view: self)
            }
            else if buttonType == .delete {
                sender.isSelected = true
                
                self.delegate?.didDeleteSelect(view: self)
            }
        }
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
