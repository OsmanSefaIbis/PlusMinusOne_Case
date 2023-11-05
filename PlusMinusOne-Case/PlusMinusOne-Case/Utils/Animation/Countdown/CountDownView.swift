import UIKit

class CircularTimerView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let label = UILabel()
    
    private var countdownTimer: Timer?
    private var secondsRemaining: Int = 5
    private let secondsInitial: Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularProgressBar(frame: frame)
        createLabel(frame: frame)
        startCountdown()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularProgressBar(frame: frame)
        createLabel(frame: frame)
        startCountdown()
    }
    
    private func createCircularProgressBar(frame: CGRect) {
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

    private func createLabel(frame: CGRect) {
        let centerX = frame.size.width / 2
        let centerY = frame.size.height / 2

        label.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        label.center = CGPoint(x: centerX, y: centerY)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
            secondsRemaining = secondsInitial
            shapeLayer.strokeEnd = 1.0
        }

        updateLabel()
    }

    
    private func updateLabel() {
        label.text = "\(secondsRemaining)"
    }
}

