//
//  RadioButton.swift
//  
//
//  Created by Daniel Pérez Parreño on 15/5/22.
//

import UIKit

public protocol RadioButtonViewDelegate {

    func radioButtonViewOnClick(view: RadioButtonView)

}

public final class RadioButtonView: UIView {

    // ---------------------------------
    // MARK: - Outlets
    // ---------------------------------

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var spaceLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    // ---------------------------------
    // MARK: - Properties
    // ---------------------------------

    private var delegate: RadioButtonViewDelegate?
    
    private var size: RadioButtonSize = .large
    public private(set) var state: RadioButtonSate = .active
    public private(set) var id: Int?
    
    public enum RadioButtonSize {
        case large, small
        
        var constraintSize: CGFloat {
            switch self {
            case .large:
                return 24
            case .small:
                return 16
            }
        }
    }
    
    public enum RadioButtonSate {
        case active, selected, focus, disabled, disabledSelected
        
        var imageState: UIImage {
            switch self {
            case .active:
                return UIImage(named: "radioButton_active", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .selected:
                return UIImage(named: "radioButton_selected", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .focus:
                return UIImage(named: "radioButton_focus", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .disabled:
                return UIImage(named: "radioButton_disabled", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            case .disabledSelected:
                return UIImage(named: "radioButton_disabledSelected", in: Bundle.module, compatibleWith: nil) ?? UIImage()
            }
        }
    }

    // ---------------------------------
    // MARK: - Init
    // ---------------------------------

    /// Instantiate and configure RadioButtonView
    /// - Parameters:
    ///   - state: set the RadioButton state
    ///   - size: set RadioButtonView size
    ///   - id: set id for identifier
    ///   - title: title for the RadioButton
    ///   - subTitle: subTitle for the RadioButton
    ///   - delegate: indicate which controller will implement the delegate methods
    /// - Returns: a configured RadioButton ready to display and use
    public class func instance(state: RadioButtonSate, size: RadioButtonSize = .large, id: Int, title: String, subTitle: String = "", delegate: RadioButtonViewDelegate?) -> RadioButtonView {
        let view = UINib(nibName: "RadioButtonView", bundle: Bundle.module).instantiate(withOwner: nil, options: nil)[0] as! RadioButtonView

        view.delegate = delegate

        view.state = state
        view.setStateImageRadioButton(state: state)

        view.buttonWidthConstraint.constant = size.constraintSize
        view.buttonHeightConstraint.constant = size.constraintSize
        view.spaceLabelWidthConstraint.constant = size.constraintSize

        view.id = id
        if state == .disabled || state == .disabledSelected {
            view.titleLabel.dsConfigure(with: title, font: .regularMedium, color: .dsGrayLight)
            view.subTitleLabel.dsConfigure(with: subTitle, font: .regularSmall, color: .dsGrayLight)
        } else {
            view.titleLabel.dsConfigure(with: title, font: .regularMedium, color: .dsGrayDark)
            view.subTitleLabel.dsConfigure(with: subTitle, font: .regularSmall, color: .dsGrayPure)
        }

        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action:  #selector(view.onClickView)))

        return view
    }

    // ---------------------------------
    // MARK: - Private
    // ---------------------------------

    private func setStateImageRadioButton(state: RadioButtonSate) {
        button.setImage(state.imageState, for: .normal)
    }

    private func radioButtonSelected() {
        if state != .disabled && state != .disabledSelected && state != .selected {
            selected()
            delegate?.radioButtonViewOnClick(view: self)
        }
    }

    // ---------------------------------
    // MARK: - Button actions
    // ---------------------------------

    @objc private func onClickView(sender : UITapGestureRecognizer) {
        radioButtonSelected()
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        radioButtonSelected()
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
        setStateImageRadioButton(state: state)
    }

    public func selected() {
        state = .selected
        setStateImageRadioButton(state: state)
    }

    public func focus() {
        state = .focus
        setStateImageRadioButton(state: state)
    }

    public func disabled() {
        state = .disabled
        setStateImageRadioButton(state: state)
    }

    public func disabledSelected() {
        state = .disabledSelected
        setStateImageRadioButton(state: state)
    }

    public func disabledAllSelectedRadioButtonViews(radioButtonViews: [RadioButtonView]) {
        radioButtonViews.forEach{(view) in
            if view.state == .selected && view != self {
                view.active()
            }
        }
    }

}
