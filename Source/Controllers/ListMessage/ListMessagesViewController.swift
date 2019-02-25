
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import UIKit
import RxSwift

class ListMessageViewController: ViewControllerBase {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ListMessageViewModel?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        if let viewModel = viewModel {
            _linkViewModel(viewModel)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.refresh()
    }
    
    fileprivate func _linkViewModel(_ viewModel: ListMessageViewModel ) {
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier,
                                         cellType: ListMessageTableViewCell.self))
            { [weak self] row, element, cell in
                if let itemModel = self?.viewModel?.itemAtIndex(row) {
                    cell.update(itemModel)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map({ [weak self] (indexPath) -> ListMessageViewModelItem? in
                return self?.viewModel?.itemAtIndex(indexPath.row)
            })
            .asDriver(onErrorJustReturn: nil)
            .drive(viewModel.messageSelected)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.items
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (item) in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        composeButton.rx
            .tap
            .subscribe { [weak self] _ in
                self?.viewModel?.composeSelected.onNext(nil)
            }
            .disposed(by: disposeBag)
        self.navigationItem.rightBarButtonItem = composeButton

        viewModel.listError
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                guard let errorMessage = event.element else { return }
                self?.view.window?.showToastError(message: errorMessage)
            }
            .disposed(by: disposeBag)
        
        viewModel.isBusy
            .asObservable()
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (isBusy) in
                isBusy ? self?.view.window?.showBusyDialog() : self?.view.window?.hideBusyDialog()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate var cellIdentifier: String {
        return String(describing: ListMessageTableViewCell.self)
    }
}
