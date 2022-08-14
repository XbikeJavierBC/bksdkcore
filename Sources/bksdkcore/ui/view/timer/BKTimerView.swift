//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import TinyConstraints

private enum BKTimerButton: Int {
    case start
    case stop
}

public protocol BKTimerViewDelegate: AnyObject {
    func didStartSelect()
    func didStopSelect()
}

public class BKTimerView: UIView {
    @IBOutlet var rootView: UIView! {
        didSet {
            rootView.backgroundColor = .clear
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
            timerTitleLabel.font = .abelRegular25
            timerTitleLabel.textColor = .black
            timerTitleLabel.text = "00 : 00 : 00"
        }
    }
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setTitle(
                BKSdkCoreLocalization.start.localize,
                for: .normal
            )
            
            startButton.setTitleColor(
                .disableTextColor,
                for: .normal
            )
            startButton.setTitleColor(
                .oragenColor,
                for: .selected
            )
            
            startButton.tag = BKTimerButton.start.rawValue
            startButton.titleLabel?.font = .abelRegular15
            startButton.titleLabel?.textAlignment = .center
        }
    }
    
    @IBOutlet weak var stopButton: UIButton! {
        didSet {
            stopButton.setTitle(
                BKSdkCoreLocalization.stop.localize,
                for: .normal
            )
            
            stopButton.setTitleColor(
                .disableTextColor,
                for: .normal
            )
            stopButton.setTitleColor(
                .oragenColor,
                for: .selected
            )
            
            stopButton.tag = BKTimerButton.stop.rawValue
            stopButton.titleLabel?.font = .abelRegular15
            stopButton.titleLabel?.textAlignment = .center
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
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .oragenColor
        view.width(1)
        
        return view
    }()
    
    public weak var delegate: BKTimerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.module.loadNibNamed("BKTimerView", owner: self, options: nil)
        self.addSubview(self.rootView)
        self.rootView.frame = self.bounds
        self.rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonType = BKTimerButton(rawValue: sender.tag) {
            if buttonType == .start {
                if !sender.isSelected {
                    sender.isSelected = true
                    self.delegate?.didStartSelect()
                }
            }
            else if buttonType == .stop {
                if self.startButton.isSelected {
                    self.startButton.isSelected = false
                    sender.isSelected = true
                    
                    self.delegate?.didStartSelect()
                }
            }
        }
    }
}
