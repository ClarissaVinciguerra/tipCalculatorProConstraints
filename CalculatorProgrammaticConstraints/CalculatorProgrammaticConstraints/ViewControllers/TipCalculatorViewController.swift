//
//  TipCalculatorViewController.swift
//  CalculatorProgrammaticConstraints
//
//  Created by Clarissa Vinciguerra on 10/13/20.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    // MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var buttons: [UIButton] {
        return [fifteenPercentButton, twentyPercentButton, twentyFivePercentButton]
    }
    
    // MARK: - Lifecycle Functions
    override func loadView() {
        super.loadView()
        addAllSubviews()
        setUpCheckTotalStackView()
        setUpCommentsTextView()
        setUpButtonStackView()
        setUpTipAndTotalStackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        activateButtons()
    }
    
    // MARK: - Actions
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)}
        
    }
    
    @objc func selectButton(sender: UIButton) {
        buttons.forEach { $0.setTitleColor(.lightGray, for: .normal) }
        guard let total = checkTotalTextField.text?.floatValue else { return }
        switch sender {
        case fifteenPercentButton:
            findTipAndTotal(checkAmount: total, percentage: 0.15)
        case twentyPercentButton:
            findTipAndTotal(checkAmount: total, percentage: 0.20)
        case twentyFivePercentButton:
            findTipAndTotal(checkAmount: total, percentage: 0.25)
        default:
            findTipAndTotal(checkAmount: total, percentage: 18.5)
        }
    }
    
    
    // MARK: - Helper Functions
    func addAllSubviews() {
        self.view.addSubview(checkTotalLabel)
        self.view.addSubview(checkTotalTextField)
        self.view.addSubview(checkTotalStackView)
        self.view.addSubview(commentsTextView)
        self.view.addSubview(fifteenPercentButton)
        self.view.addSubview(twentyPercentButton)
        self.view.addSubview(twentyFivePercentButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(tipLabel)
        self.view.addSubview(finalTotalLabel)
        self.view.addSubview(tipAndTotalStackView)
    }
    
    func setUpCheckTotalStackView() {
        checkTotalStackView.addArrangedSubview(checkTotalLabel)
        checkTotalStackView.addArrangedSubview(checkTotalTextField)
        checkTotalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        checkTotalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8).isActive = true
        checkTotalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8).isActive = true
    }
    
    func setUpCommentsTextView() {
        commentsTextView.anchor(top: checkTotalStackView.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: SpacingConstant.objectSpace, bottomPadding: 0, leadingPadding: 8, trailingPadding: -8, width: nil, height: 332)
    }
    
    func setUpButtonStackView() {
        buttonStackView.addArrangedSubview(fifteenPercentButton)
        buttonStackView.addArrangedSubview(twentyPercentButton)
        buttonStackView.addArrangedSubview(twentyFivePercentButton)
        buttonStackView.anchor(top: commentsTextView.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: SpacingConstant.objectSpace, bottomPadding: 0, leadingPadding: 8, trailingPadding: -8)
    }
    
    func setUpTipAndTotalStackView() {
        tipAndTotalStackView.addArrangedSubview(tipLabel)
        tipAndTotalStackView.addArrangedSubview(finalTotalLabel)
        tipAndTotalStackView.anchor(top: buttonStackView.bottomAnchor, bottom: nil, leading: nil, trailing: safeArea.trailingAnchor, topPadding: SpacingConstant.objectSpace, bottomPadding: 0, leadingPadding: 0, trailingPadding: -8)
    }
    
    func findTipAndTotal(checkAmount: Float, percentage: Float) {
        let tip = checkAmount * percentage
        let number: NSNumber = NSNumber(value: tip)
        let roundedTip = round(Double(truncating: number) * 100)/100
        tipLabel.text = "Tip: $\(roundedTip)"
        let finalTotal = checkAmount + Float(roundedTip)
        finalTotalLabel.text = "Final Total: $\(finalTotal)"
    }
    
    
    // MARK: Views
    let checkTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Check Total: $"
        return label
    }()
    
    let checkTotalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter amount here..."
        return textField
    }()
    
    let checkTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let commentsTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Leave comments here..."
        return textView
    }()
    
    let fifteenPercentButton: UIButton = {
        let percentButton = UIButton()
        percentButton.setTitle("15%", for: .normal)
        percentButton.contentHorizontalAlignment = .center
        percentButton.layer.masksToBounds = true
        percentButton.layer.cornerRadius = 5
        return percentButton
    }()
    
    let twentyPercentButton: UIButton = {
        let percentButton = UIButton()
        percentButton.setTitle("20%", for: .normal)
        percentButton.contentHorizontalAlignment = .center
        percentButton.layer.masksToBounds = true
        percentButton.layer.cornerRadius = 5
        return percentButton
    }()
    
    let twentyFivePercentButton: UIButton = {
        let percentButton = UIButton()
        percentButton.setTitle("25%", for: .normal)
        percentButton.contentHorizontalAlignment = .center
        percentButton.layer.masksToBounds = true
        percentButton.layer.cornerRadius = 5
        return percentButton
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let tipLabel: UILabel = {
        let label = UILabel()
        label.text = "  Tip amount: $"
        return label
    }()
    
    let finalTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Final total: $"
        return label
    }()
    
    let tipAndTotalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

} //EOC


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
