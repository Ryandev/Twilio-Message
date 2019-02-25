
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class ComposeViewController: ViewControllerBase {
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!

    var viewModel: ComposeViewModel?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            _linkViewModel(viewModel)
        }
    }
    
    fileprivate func _linkViewModel(_ viewModel: ComposeViewModel ) {
        fromTextField.rx.text
            .orEmpty
            .bind(to: viewModel.from)
            .disposed(by: disposeBag)
        
        toTextField.rx.text
            .orEmpty
            .bind(to: viewModel.to)
            .disposed(by: disposeBag)
        
        bodyTextView.rx.text
            .orEmpty
            .bind(to: viewModel.body)
            .disposed(by: disposeBag)

        sendButton.rx
            .controlEvent(.touchUpInside)
            .asDriver(onErrorJustReturn: ())
            .drive(viewModel.sendSelected)
            .disposed(by: disposeBag)
        
        viewModel.messageSent
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                self?.view.window?.showToastSuccess(message: "Message sent!")
            }
            .disposed(by: disposeBag)

        viewModel.composeError
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                guard let errorMessage = event.element else { return }
                self?.view.window?.showToastError(message: errorMessage)
            }
            .disposed(by: disposeBag)

        viewModel.isSendingMessage
            .asObservable()
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (isBusy) in
                isBusy ? self?.view.window?.showBusyDialog() : self?.view.window?.hideBusyDialog()

                if isBusy {
                    self?.toTextField.resignFirstResponder()
                    self?.fromTextField.resignFirstResponder()
                    self?.bodyTextView.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
}

