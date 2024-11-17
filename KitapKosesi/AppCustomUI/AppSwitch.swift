import UIKit

class AppSwitch: UISwitch {
    
    // Switch değişikliklerinde çağrılacak işlem
    private var action: ((Bool) -> Void)?
    
    // Custom initializer
    init(isOn: Bool = false, action: ((Bool) -> Void)? = nil) {
        self.action = action
        super.init(frame: .zero)
        self.isOn = isOn
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Switch'in görünüm özelleştirmesi
        self.onTintColor = .textColor
        self.thumbTintColor = .primaryColor
        self.tintColor = .secondaryColor
        
        
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.85)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 50)

        ])

        
        // Hedef aksiyon ekle
        self.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
    }
    
    // Zorunlu initializer (Storyboard uyumluluğu için)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Switch'in durum değişikliğini yakala
    @objc private func switchToggled() {
        // İşlem varsa çağır
        action?(self.isOn)
    }
    
    // Dışarıdan işlem eklemek için bir metot
    func setAction(_ action: @escaping (Bool) -> Void) {
        self.action = action
    }
}
