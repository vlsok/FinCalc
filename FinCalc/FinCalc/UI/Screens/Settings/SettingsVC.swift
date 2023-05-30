import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var modeSwitcher: UISwitch!
    @IBOutlet var saveSwitcher: UISwitch!
    @IBOutlet var telegramLabel: UILabel!
    
    let styleSheet = StyleSheet()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        styleSheet.addTopInsetView(scrollView)
        
        setupTapGesturesRecognizer()
        setupTelegramLabel()
        
        setupIsModeSwitchOn()
        setupIsSaveSwitchOn()
    }
    
    private func setupTapGesturesRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        telegramLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupTelegramLabel() {
        telegramLabel.text = "Made by @ulaskiby"
        
        let attributedString = NSMutableAttributedString(string: telegramLabel.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Link-colorized") ?? UIColor.blue, range: NSRange(location: 8, length: 9))
        
        telegramLabel.attributedText = attributedString
        telegramLabel.isUserInteractionEnabled = true
    }
    
    private func setupIsModeSwitchOn() {
        UserDefaults.standard.register(defaults: ["isModeSwitchOn": true])
        
        let isModeSwitchOn = UserDefaults.standard.bool(forKey: "isModeSwitchOn")
        modeSwitcher.isOn = isModeSwitchOn
    }
    
    private func setupIsSaveSwitchOn() {
        UserDefaults.standard.register(defaults: ["isSaveSwitchOn": false])
        
        let isSaveSwitchOn = UserDefaults.standard.bool(forKey: "isSaveSwitchOn")
        saveSwitcher.isOn = isSaveSwitchOn
    }
    
    @objc
    func labelTapped() {
        if let url = URL(string: "https://t.me/ulaskiby") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction
    func switchModeValueChanged(_ sender: UISwitch) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let userInterfaceStyle: UIUserInterfaceStyle = sender.isOn ? UIScreen.main.traitCollection.userInterfaceStyle : .light
            keyWindow.overrideUserInterfaceStyle = userInterfaceStyle
        }
        
        UserDefaults.standard.set(sender.isOn, forKey: "isModeSwitchOn")

        let userInterfaceStyle: UIUserInterfaceStyle = sender.isOn ? UIScreen.main.traitCollection.userInterfaceStyle : .light
        UserDefaults.standard.set(userInterfaceStyle.rawValue, forKey: "userInterfaceStyle")
        
        NotificationCenter.default.post(name: Notification.Name("ModeSwitchValueChanged"), object: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.4

            UIView.transition(with: windowScene.windows.first!,
                              duration: duration,
                              options: options,
                              animations: {
                                  if sender.isOn {
                                      windowScene.windows.forEach { window in
                                          window.overrideUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle
                                      }
                                  } else {
                                      windowScene.windows.forEach { window in
                                          if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                                              window.overrideUserInterfaceStyle = .dark
                                          } else {
                                              window.overrideUserInterfaceStyle = .light
                                          }
                                          
                                      }
                                  }
                              },
                              completion: nil)
        }
    }

    @IBAction
    func switchSaverValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isSaveSwitchOn")
        
        let switchState = ["isOn": sender.isOn]
        NotificationCenter.default.post(name: NSNotification.Name("SwitchStateChanged"), object: nil, userInfo: switchState)
    }
}
