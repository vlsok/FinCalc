import UIKit

class VATCalculationsVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var buttonExtract: UIButton!
    @IBOutlet var buttonCharge: UIButton!

    @IBOutlet var sumTextField: UITextField!
    @IBOutlet var sumTextFieldView: UIView!

    @IBOutlet var rateTextField: UITextField!
    @IBOutlet var rateTextFieldView: UIView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var isButtonExtractSelected = true
    var isButtonChargeSelected = false

    var isSavingOn: Bool = false
    var styleSheet = StyleSheet()
    var activeTextFieldView: UIView?
    var viewModel: VATCalculationsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scrollView.contentInset = UIEdgeInsets(top: 100.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveOrRemoveData()
    }
    
    override func keyboardWillChangeFrame(notification: Notification) {
        super.keyboardWillChangeFrame(notification: notification)
    }
    
    private func setup() {
        styleSheet.addTopInsetView(scrollView)
        
        setObservers()
        setTapGesturesRecognizers()
        
        viewModel = VATCalculationsViewModel()
        retrieveData()
        updateCalculationResults()
        
        setDelegates()
        setTargets()
        
        setStyles()
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(switchValueChanged(_:)), name: NSNotification.Name("SwitchStateChanged"), object: nil)
    }
    
    private func setTapGesturesRecognizers() {
        let firstTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sumTextFieldViewTapped))
        sumTextFieldView.addGestureRecognizer(firstTapGestureRecognizer)

        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rateTextFieldViewTapped))
        rateTextFieldView.addGestureRecognizer(secondTapGestureRecognizer)
    }
    
    private func saveOrRemoveData() {
        saveButtonState(buttonExtract, forFirstKey: "extractDataKey", buttonCharge, forSecondKey: "chargeDataKey", isSavingOn)
        
        saveOrRemoveValue(sumTextField, forKey: "sumDataKey", isSavingOn)
        saveOrRemoveValue(rateTextField, forKey: "rateDataKeySecond", isSavingOn)
        
        saveOrRemoveValue(resultLabel, forKey: "resultDataKeySecond", isSavingOn)
        
        UserDefaults.standard.set(isSavingOn, forKey: "isSavingOnKey")
    }
    
    private func retrieveData() {
        retrieveValue(sumTextField, forKey: "sumDataKey")
        retrieveValue(rateTextField, forKey: "rateDataKeySecond")
        
        retrieveValue(resultLabel, forKey: "resultDataKeySecond")
        
        isButtonExtractSelected = retrieveButtonState(buttonExtract, forKey: "extractDataKey")
        isButtonChargeSelected = retrieveButtonState(buttonCharge, forKey: "chargeDataKey")
        
        isSavingOn = UserDefaults.standard.bool(forKey: "isSavingOnKey")
    }
    
    private func updateCalculationResults() {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ru_RU")
        
        guard let sumText = sumTextField.text,
              let rateText = rateTextField.text,
              !sumText.isEmpty, !rateText.isEmpty,
              let sum = numberFormatter.number(from: sumText)?.doubleValue ?? numberFormatter.number(from: sumText.replacingOccurrences(of: ".", with: ","))?.doubleValue,
              let rate = numberFormatter.number(from: rateText)?.doubleValue ?? numberFormatter.number(from: rateText.replacingOccurrences(of: ".", with: ","))?.doubleValue else {
            resultLabel.text = "Здесь появятся результаты после того, как вы заполните все поля"
            return
        }
        
        if isButtonChargeSelected {
            viewModel.updateMode(.charge)
        } else {
            viewModel.updateMode(.extract)
        }
        
        viewModel.model = VATCalculationsModel(sum: sum, rate: rate)
    }

    
    private func setDelegates() {
        viewModel.delegate = self
        sumTextField.delegate = self
        rateTextField.delegate = self
    }
    
    private func setTargets() {
        sumTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        rateTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private func setStyles() {
        if isSavingOn {
            styleSheet.updateButtonSelectionStates(buttonExtract, buttonCharge, retrieveButtonState(buttonExtract, forKey: "extractDataKey"), retrieveButtonState(buttonCharge, forKey: "chargeDataKey"))
        } else {
            styleSheet.updateButtonSelectionStates(buttonExtract, buttonCharge, true, false)
        }
        
        styleSheet.checkModeForTextField(sumTextField)
        styleSheet.checkModeForTextField(rateTextField)
    }

    private func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == sumTextField {
            activeTextFieldView = sumTextFieldView
        } else if textField == rateTextField {
            activeTextFieldView = rateTextFieldView
        }

        styleSheet.checkModeForTextField(sumTextField)
        styleSheet.checkModeForTextField(rateTextField)

        activeTextFieldView?.layer.borderWidth = 0.5
        activeTextFieldView?.layer.borderColor = UIColor(named: "UIButton-borderColor")?.cgColor

        styleSheet.animateBorder(for: activeTextFieldView, isAdding: true)
    }

    private func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextFieldView?.layer.borderWidth = 0
        activeTextFieldView?.layer.borderColor = nil
        activeTextFieldView = nil

        styleSheet.animateBorder(for: activeTextFieldView, isAdding: true)
        
        saveOrRemoveData()
    }
    
    @objc
    func textFieldEditingChanged(_ textField: UITextField) {
        updateCalculationResults()
    }
    
    @objc
    func switchValueChanged(_ notification: Notification) {
        if let isOn = notification.userInfo?["isOn"] as? Bool {
            if isOn {
                isSavingOn = true
                saveOrRemoveData()
            } else {
                isSavingOn = false
                saveOrRemoveData()
            }
        }
    }

    @objc
    func sumTextFieldViewTapped() {
        sumTextField.becomeFirstResponder()
    }

    @objc
    func rateTextFieldViewTapped() {
        rateTextField.becomeFirstResponder()
    }

    @IBAction
    func buttonExtractTapped(_ sender: UIButton) {
        isButtonExtractSelected = true
        isButtonChargeSelected = false
        
        styleSheet.updateButtonSelectionStates(buttonExtract, buttonCharge, true, false)

        saveOrRemoveData()

        if sumTextField.text?.isEmpty == true || rateTextField.text?.isEmpty == true {
            viewModel.updateMode(.none)
        } else {
            viewModel.updateMode(.extract)
        }
    }

    @IBAction
    func buttonChargeTapped(_ sender: UIButton) {
        isButtonExtractSelected = false
        isButtonChargeSelected = true
        
        styleSheet.updateButtonSelectionStates(buttonExtract, buttonCharge, false, true)

        saveOrRemoveData()

        if sumTextField.text?.isEmpty == true || rateTextField.text?.isEmpty == true {
            viewModel.updateMode(.none)
        } else {
            viewModel.updateMode(.charge)
        }
    }

    
    @IBAction
    func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
