//
//  DialogViewController.swift
//  
//
//  Created by Daniel Pérez Parreño on 15/5/22.
//

import UIKit

public protocol DialogViewControllerDelegate {
    
    func tapPrincipalButton()
    func tapSecondaryButton()
    func tapCloseButton()
    
}

public final class DialogViewController: UIViewController {

    // ---------------------------------
    // MARK: - Outlets
    // ---------------------------------

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var fakeFullSCreenView: UIView!
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    @IBOutlet weak var closeModalButton: UIButton!
    @IBOutlet weak var closeFullScreenButton: UIButton!

    // ---------------------------------
    // MARK: - Variables and constants
    // ---------------------------------

    public var image: UIImage?
    public var principalTitle: String?
    public var subtitle: String?
    public var textPrimaryButton: String?
    public var textSecondaryButton: String?
    public var hideCloseButton: Bool?

    public var fullScreen: Bool?

    public var delegate: DialogViewControllerDelegate?

    // ---------------------------------
    // MARK: - Init
    // ---------------------------------

    /// Set a modal to display
    /// - Parameters:
    ///   - image: modal image
    ///   - title: modal title
    ///   - subtitle: modal subTitle
    ///   - titlePrimaryButton: title for the main button of the modal
    ///   - titleSecondaryButton: title for the secondary button of the modal
    ///   - fullScreen: true if the modal will be displayed full screen
    ///   - hideCloseButton: true if to hide the close button and force the user to check an option
    ///   - delegate: indicate which controller will implement the delegate methods
    public init(image: UIImage? = nil, title: String, subtitle: String? = nil, titlePrimaryButton: String, titleSecondaryButton: String? = nil, fullScreen: Bool? = false, hideCloseButton: Bool? = true, delegate: DialogViewControllerDelegate) {
        super.init(nibName: "DialogViewController", bundle: Bundle.module)
        
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve

        self.delegate = delegate
        
        self.fullScreen = fullScreen
        
        self.image = image
        self.principalTitle = title
        self.subtitle = subtitle
        self.textPrimaryButton = titlePrimaryButton
        self.textSecondaryButton = titleSecondaryButton
        self.hideCloseButton = hideCloseButton
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    // ---------------------------------
    // MARK: - Button actions
    // ---------------------------------

    @IBAction func primaryButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.delegate?.tapPrincipalButton()
        })
    }

    @IBAction func secondaryButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.delegate?.tapSecondaryButton()
        })
    }

    @IBAction func closeModalButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.delegate?.tapCloseButton()
        })
    }

    @IBAction func closeFullScreenButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.delegate?.tapCloseButton()
        })
    }

    // ---------------------------------
    // MARK: - Private methods
    // ---------------------------------

    private func setView() {

        /// FullScreen
        fakeFullSCreenView.isHidden = fullScreen == true ? false : true

        /// Border
        contenView.boderRadius(radius: .large)

        /// Image
        if image == nil {
            imageView.isHidden = true
        } else {
            imageView.image = image
        }

        /// Title
        titleLabel.dsConfigure(with: principalTitle, font: .boldMedium, color: .dsGrayDark)

        /// Subtitles
        if let subtitle = subtitle {
            subtitleLabel.dsConfigure(with: subtitle, font: .regularSmall, color: .dsGrayPure)
        } else {
            subtitleLabel.isHidden = true
        }

        /// Primary Button
        primaryButton.dsConfigure(text: textPrimaryButton, style: .primary, state: .enabled, width: 240)

        /// Secondary Button
        if let titleSecondaryButton = textSecondaryButton {
            secondaryButton.dsConfigure(text: titleSecondaryButton, style: .secondary, state: .enabled, width: 240)
        } else {
            secondaryButton.isHidden = true
        }

        /// Close Buttons
        if !(hideCloseButton ?? true) {
            closeModalButton.isHidden = fullScreen == true ? true : false
            closeFullScreenButton.isHidden = fullScreen == true ? false : true
        } else {
            closeModalButton.isHidden = true
            closeFullScreenButton.isHidden = true
        }

    }

}
