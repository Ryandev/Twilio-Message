
import UIKit

extension UIView
{
    @IBInspectable var borderColor: UIColor
    {
        set(newValue)
        {
            self.layer.borderColor = newValue.cgColor
        }

        get
        {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
    }

    @IBInspectable var borderRadius: CGFloat
    {
        set(newValue)
        {
            self.layer.cornerRadius = newValue
        }
    
        get
        {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat
    {
        set(newValue)
        {
            self.layer.borderWidth = newValue
        }

        get
        {
            return self.layer.borderWidth
        }
    }
}
