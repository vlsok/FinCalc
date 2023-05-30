import UIKit

class CalculationsVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

    private lazy var firstViewController: VATCalculationsVC = {
        let storyboard = UIStoryboard(name: "Calculations", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "VATCalculationsVC") as! VATCalculationsVC

        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var secondViewController: PTCalculationsVC = {
        let storyboard = UIStoryboard(name: "Calculations", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "PTCalculationsVC") as! PTCalculationsVC

        self.add(asChildViewController: viewController)

        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)

        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    static func viewController() -> CalculationsVC {
        return UIStoryboard.init(name: "Calculations", bundle: nil).instantiateViewController(withIdentifier: "SegmentedView") as! CalculationsVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)

        containerView.addSubview(viewController.view)

        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if segmentControl.selectedSegmentIndex == 0 {
            let transition = CATransition()
            transition.duration = 0.25
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            containerView.layer.add(transition, forKey: kCATransition)

            remove(asChildViewController: secondViewController)

            add(asChildViewController: firstViewController)
        } else {
            let transition = CATransition()
            transition.duration = 0.25
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            containerView.layer.add(transition, forKey: kCATransition)

            remove(asChildViewController: firstViewController)

            add(asChildViewController: secondViewController)
        }
    }
    
    private func setupView() {
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
        } else {
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
        }
    }
    
    @objc
    private func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.direction == .left {
            if segmentControl.selectedSegmentIndex < segmentControl.numberOfSegments - 1 {
                segmentControl.selectedSegmentIndex += 1
                updateView()
            }
        } else if gestureRecognizer.direction == .right {
            if segmentControl.selectedSegmentIndex > 0 {
                segmentControl.selectedSegmentIndex -= 1
                updateView()
            }
        }
    }

    @IBAction
    func segmentValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }

}
