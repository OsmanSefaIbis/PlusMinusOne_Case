import UIKit

protocol DelegateOfCountDownView: AnyObject {
    func didEndCountdown()
}

class CountDownView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let label = UILabel()
    private var countdownTimer: Timer?
    private let secondsInitial: Int = 10
    private var secondsRemaining: Int = 10
    weak var delegate: DelegateOfCountDownView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCircularProgressBar(frame: frame)
        configureLabel(frame: frame)
        startCountdown()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCircularProgressBar(frame: frame)
        configureLabel(frame: frame)
        startCountdown()
    }
    
    private func configureCircularProgressBar(frame: CGRect) {
        let centerX = frame.size.width / 2
        let centerY = frame.size.height / 2

        let circularPath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                        radius: min(frame.size.width, frame.size.height) / 2 - 5,
                                        startAngle: -CGFloat.pi / 2,
                                        endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
                                        clockwise: true)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.systemOrange.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 1.0

        layer.addSublayer(shapeLayer)
    }

    private func configureLabel(frame: CGRect) {
        let centerX = frame.size.width / 2
        let centerY = frame.size.height / 2

        label.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        label.center = CGPoint(x: centerX, y: centerY)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.systemOrange
        addSubview(label)
    }

    
    private func startCountdown() {
        
        secondsRemaining = secondsInitial
        updateLabel()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc private func updateCountdown() {
        secondsRemaining -= 1
        
        if secondsRemaining >= 0 {
            let progress = CGFloat(secondsRemaining) / CGFloat(secondsInitial)
            shapeLayer.strokeEnd = progress
        } else {
            delegate?.didEndCountdown()
            secondsRemaining = secondsInitial
            shapeLayer.strokeEnd = 1.0
        }

        updateLabel()
    }

    
    private func updateLabel() {
        label.text = "\(secondsRemaining)"
    }
}

