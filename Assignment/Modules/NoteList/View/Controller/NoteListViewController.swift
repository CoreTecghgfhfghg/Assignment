
import UIKit

class NoteListViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet var notelistTableView: UITableView!
    
    // MARK: - Private variables
    
    private var viewModel = NotelistViewModel()
    private var states: [Bool]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

private extension NoteListViewController {
    func configuration() {
        title = Constant.NoteList.notes
        observeEvent()
        getNoteList()
        notelistTableView.register(UINib(nibName: NotelistCell.xibName, bundle: nil), forCellReuseIdentifier: NotelistCell.cellIdentifier)
    }
    
    func getNoteList() {
        viewModel.fetchNoteList()
    }
    
    // Data binding event observe
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// Indicator show
                debugPrint("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                debugPrint("Stop loading...")
            case .dataLoaded:
                debugPrint("Data loaded...")
                self.states = [Bool](repeating: true, count: self.viewModel.notelist.count)
                DispatchQueue.main.async {
                    self.notelistTableView.reloadData()
                }
            case .error(let error):
                debugPrint(error as Any)
            }
        }
    }
}

// MARK: UITableView Delegate Methods

extension NoteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        states?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotelistCell.cellIdentifier) as? NotelistCell else {
            return UITableViewCell()
        }
        let product = viewModel.notelist[indexPath.row]
        cell.bounds = view.bounds
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        cell.notelist = product
        cell.descriptionLabel.delegate = self
        cell.configureCell()
        cell.descriptionLabel.collapsed = states?[indexPath.row] ?? true
        cell.shareDelegate = self
        cell.shareButton.tag = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
            vcObj.selectedDetails = self.viewModel.notelist[indexPath.row]
            self.navigationController?.pushViewController(vcObj, animated: true)
        }
    }
}

// MARK: ExpandableLabel Delegate

extension NoteListViewController: ExpandableLabelDelegate {
    func willExpandLabel(_ label: ExpandableLabel) {
        notelistTableView.beginUpdates()
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: notelistTableView)
        if let indexPath = notelistTableView.indexPathForRow(at: point) as IndexPath? {
            states?[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.notelistTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        notelistTableView.endUpdates()
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        notelistTableView.beginUpdates()
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: notelistTableView)
        if let indexPath = notelistTableView.indexPathForRow(at: point) as IndexPath? {
            states?[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.notelistTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        notelistTableView.endUpdates()
    }
}

extension NoteListViewController: CellShareDelegate {
    func didTapShareButton(for cell: UITableViewCell) {
        guard let indexPath = notelistTableView.indexPath(for: cell) else {
            return
        }
        let note = viewModel.notelist[indexPath.row]
        let subTitle = note.description.replaceSpecialCharacter
        let title = note.headLine.replaceSpecialCharacter
        let textToShare = "\(title)\n\(subTitle)"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
