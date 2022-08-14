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
    //MARK: IBOutlets
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
            timerTitleLabel.text = self.defaultTimerText
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
    
    //MARK: Properties
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .oragenColor
        view.width(1)
        
        return view
    }()
    
    //MARK: Variables
    public weak var delegate: BKTimerViewDelegate?
    
    private var timer = Timer()
    private var counter = 0
    private var currentDate = Date()
    
    private let defaultTimerText = "00 : 00 : 00"
    
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
        Bundle.module.loadNibNamed("BKTimerView", owner: self, options: nil)
        self.addSubview(self.rootView)
        self.rootView.frame = self.bounds
        self.rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func startTimer() {
        self.currentDate = Date()
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func timerAction() {
        self.counter = Int(Date().timeIntervalSince(self.currentDate))
        let (h,m,s) = self.hmsFrom(seconds: self.counter)
        
        let hours   = self.getStringFrom(seconds: h)
        let minutes = self.getStringFrom(seconds: m)
        let seconds = self.getStringFrom(seconds: s)
        
        self.timerTitleLabel.text = "\(hours) : \(minutes) : \(seconds)"
    }
    
    private func stopTimer() {
        self.timer.invalidate()
    }
    
    private func restartComponents() {
        self.timer.invalidate()
        self.counter = 0
        self.timerTitleLabel.text = self.defaultTimerText
    }
    
    private func hmsFrom(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    //MARK: IBActions
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonType = BKTimerButton(rawValue: sender.tag) {
            if buttonType == .start {
                if !sender.isSelected {
                    sender.isSelected = true
                    self.restartComponents()
                    self.startTimer()
                    self.delegate?.didStartSelect()
                }
            }
            else if buttonType == .stop {
                if self.startButton.isSelected {
                    self.startButton.isSelected = false
                    sender.isSelected = true
                    
                    self.stopTimer()
                    self.delegate?.didStartSelect()
                }
            }
        }
    }
}
