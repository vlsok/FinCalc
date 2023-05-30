import UIKit

class PTCalculationsVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var squareTextField: UITextField!
    @IBOutlet var squareTextFieldView: UIView!

    @IBOutlet var costTextField: UITextField!
    @IBOutlet var costTextFieldView: UIView!

    @IBOutlet var rateTextField: UITextField!
    @IBOutlet var rateTextFieldView: UIView!

    @IBOutlet var resultLabel: UILabel!
    
    var isSavingOn: Bool = false
    var styleSheet = StyleSheet()
    var activeTextFieldView: UIView?
    var viewModel: PTCalculationsViewModel!

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
        
        viewModel = PTCalculationsViewModel()
        retrieveData()
        
        setDelegates()
        setTargets()
        
        setStyles()
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(switchValueChanged(_:)), name: NSNotification.Name("SwitchStateChanged"), object: nil)
    }
    
    private func setTapGesturesRecognizers() {
        let firstTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(squareTextFieldViewTapped))
        squareTextFieldView.addGestureRecognizer(firstTapGestureRecognizer)

        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(costTextFieldViewTapped))
        costTextFieldView.addGestureRecognizer(secondTapGestureRecognizer)

        let thirdTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rateTextFieldViewTapped))
        rateTextFieldView.addGestureRecognizer(thirdTapGestureRecognizer)
    }
    
    private func saveOrRemoveData() {
        saveOrRemoveValue(squareTextField, forKey: "squareDataKey", isSavingOn)
        saveOrRemoveValue(costTextField, forKey: "costDataKey", isSavingOn)
        saveOrRemoveValue(rateTextField, forKey: "rateDataKey", isSavingOn)
        
        saveOrRemoveValue(resultLabel, forKey: "resultDataKey", isSavingOn)
        
        UserDefaults.standard.set(isSavingOn, forKey: "isSavingOnKey")
    }
    
    private func retrieveData() {
        retrieveValue(squareTextField, forKey: "squareDataKey")
        retrieveValue(costTextField, forKey: "costDataKey")
        retrieveValue(rateTextField, forKey: "rateDataKey")
        
        retrieveValue(resultLabel, forKey: "resultDataKey")
        
        isSavingOn = UserDefaults.standard.bool(forKey: "isSavingOnKey")
    }
    
    private func updateCalculationResults() {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ru_RU")
        
        guard let squareText = squareTextField.text,
              let costText = costTextField.text,
              let rateText = rateTextField.text,
              let square = numberFormatter.number(from: squareText)?.doubleValue ?? numberFormatter.number(from: squareText.replacingOccurrences(of: ".", with: ","))?.doubleValue,
              let cost = numberFormatter.number(from: costText)?.doubleValue ?? numberFormatter.number(from: costText.replacingOccurrences(of: ".", with: ","))?.doubleValue,
              let rate = numberFormatter.number(from: rateText)?.doubleValue ?? numberFormatter.number(from: rateText.replacingOccurrences(of: ".", with: ","))?.doubleValue else {
            resultLabel.text = "Здесь появятся результаты после того, как вы заполните все поля"
            return
        }
        
        viewModel.model = PTCalculationsModel(square: square, cost: cost, rate: rate)
    }
    
    private func setDelegates() {
        viewModel.delegate = self
        squareTextField.delegate = self
        costTextField.delegate = self
        rateTextField.delegate = self
    }
    
    private func setTargets() {
        squareTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        costTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        rateTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    private func setStyles() {
        styleSheet.checkModeForTextField(squareTextField)
        styleSheet.checkModeForTextField(costTextField)
        styleSheet.checkModeForTextField(rateTextField)
    }

    private func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == squareTextField {
            activeTextFieldView = squareTextFieldView
        } else if textField == costTextField {
            activeTextFieldView = costTextFieldView
        } else if textField == rateTextField {
            activeTextFieldView = rateTextFieldView
        }

        styleSheet.checkModeForTextField(squareTextField)
        styleSheet.checkModeForTextField(costTextField)
        styleSheet.checkModeForTextField(rateTextField)

        activeTextFieldView?.layer.borderWidth = 0.5
        activeTextFieldView?.layer.borderColor = UIColor(named: "UIButton-borderColor")?.cgColor
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextFieldView?.layer.borderWidth = 0
        activeTextFieldView?.layer.borderColor = nil
        activeTextFieldView = nil
        
        styleSheet.animateBorder(for: activeTextFieldView, isAdding: true)
        
        saveOrRemoveData()
    }

    @objc
    private func textFieldEditingChanged() {
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
    func squareTextFieldViewTapped() {
        squareTextField.becomeFirstResponder()
    }

    @objc
    func costTextFieldViewTapped() {
        costTextField.becomeFirstResponder()
    }

    @objc
    func rateTextFieldViewTapped() {
        rateTextField.becomeFirstResponder()
    }

    @IBAction
    func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
