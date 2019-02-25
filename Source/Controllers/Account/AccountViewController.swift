
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import UIKit
import RxSwift
import RxCocoa

class AccountViewController: ViewControllerBase {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: AccountViewModel?
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
    
    fileprivate func _linkViewModel(_ viewModel: AccountViewModel ) {
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier,
                                         cellType: AccountTableViewCell.self))
            { [weak self] row, element, cell in
                if let itemModel = self?.viewModel?.itemAtIndex(row) {
                    cell.update(account: itemModel)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map({ [weak self] (indexPath) -> AccountViewModelItem? in
                return self?.viewModel?.itemAtIndex(indexPath.row)
            })
            .asDriver(onErrorJustReturn: nil)
            .drive(viewModel.accountSelected)
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
        return String(describing: AccountTableViewCell.self)
    }
}
