//
//  CheckBox.swift
//  
//
//  Created by Daniel Pérez Parreño on 15/5/22.
//

import UIKit

public protocol CheckboxViewDelegate {

    func checkboxViewSelected(view: CheckboxView)
    func checkboxViewDeselected(view: CheckboxView)
    func checkboxViewLinkPressed(view: CheckboxView)

}

public final class CheckboxView: UIView {

    // ---------------------------------
    // MARK: - Outlets
    // ---------------------------------

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    // ---------------------------------
    // MARK: - Properties
    // ---------------------------------

    private var delegate: CheckboxViewDelegate?

    public private(set) var state: CheckboxSate = .active
    public private(set) var id: Int?

    public enum CheckboxTitleSize {
        case medium, small

        var fontSize: Typography.FontsWithSize {
            switch self {
            case .medium:
                return .regularMedium
            case .small:
                return .regularSmall
            }
        }
    }

    public enum CheckboxSate {
        case active, selected, focus, disabled, disabledSelected

        var imageState: UIImage {
            switch self {
            case .active:
                return UIImage(named: "checkbox_active", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .selected:
                return UIImage(named: "checkbox_selected", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .focus:
                return UIImage(named: "checkbox_focus", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .disabled:
                return UIImage(named: "checkbox_disabled", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .disabledSelected:
                return UIImage(named: "checkbox_disabledSelected", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            }
        }
    }

    // ---------------------------------
    // MARK: - Init
    // ---------------------------------

    public class func instance(state: CheckboxSate, id: Int, title: String, titleSize: CheckboxTitleSize = .medium, subTitle: String = "", isLinkInteraction: Bool? = false, delegate: CheckboxViewDelegate?) -> CheckboxView {
        let view = UINib(nibName: "CheckboxView", bundle: Bundle.module).instantiate(withOwner: nil, options: nil)[0] as! CheckboxView

        view.delegate = delegate

        view.state = state
        view.setStateImageCheckbox(state: state)

        view.id = id
        if state == .disabled || state == .disabledSelected {
            view.titleLabel.dsConfigure(with: title, font: titleSize.fontSize, color: .dsGrayLight)
            view.subTitleLabel.dsConfigure(with: subTitle, font: .regularSmall, color: .dsGrayLight)
        } else {
            view.titleLabel.dsConfigure(with: title, font: titleSize.fontSize, color: .dsGrayDark)
            view.subTitleLabel.dsConfigure(with: subTitle, font: .regularSmall, color: .dsGrayPure)
        }

        if isLinkInteraction ?? false {
            let tap = UITapGestureRecognizer(target: view, action: #selector(self.linkPressed))
            view.titleLabel.isUserInteractionEnabled = true
            view.titleLabel.addGestureRecognizer(tap)

            view.titleLabel.dsConfigure(with: title, font: titleSize.fontSize, color: .dsBluePure)
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: title, attributes: underlineAttribute)
            view.titleLabel.attributedText = underlineAttributedString
        }

        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action:  #selector(view.onClickView)))

        return view
    }

    // ---------------------------------
    // MARK: - Private
    // ---------------------------------

    private func setStateImageCheckbox(state: CheckboxSate) {
        button.setImage(state.imageState, for: .normal)
    }

    private func checkboxClicked() {
        if state == .active || state == .focus {
            selected()
            delegate?.checkboxViewSelected(view: self)
        } else if state == .selected {
            active()
            delegate?.checkboxViewDeselected(view: self)
        }
    }

    // ---------------------------------
    // MARK: - Button actions
    // ---------------------------------

    @objc private func onClickView(sender : UITapGestureRecognizer) {
        checkboxClicked()
    }

    @IBAction func onClickButton(_ sender: UIButton) {
        checkboxClicked()
    }
    
    @objc func linkPressed(sender:UITapGestureRecognizer) {
        delegate?.checkboxViewLinkPressed(view: self)
    }

    // ---------------------------------
    // MARK: - Public
    // ---------------------------------

    public func configure(title: String, subTitle: String? = "" ) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }

    public func active() {
        state = .active
        setStateImageCheckbox(state: state)
    }

    public func selected() {
        state = .selected
        setStateImageCheckbox(state: state)
    }

    public func focus() {
        state = .focus
        setStateImageCheckbox(state: state)
    }

    public func disabled() {
        state = .disabled
        setStateImageCheckbox(state: state)
    }

    public func disabledSelected() {
        state = .disabledSelected
        setStateImageCheckbox(state: state)
    }

    public func isSelected() -> Bool {
        return self.state == .selected || self.state == .disabledSelected ? true : false
    }

}
