
import UIKit

class ListDetailViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var detailTableView: UITableView!

    // MARK: - Private variables

    var selectedDetails: Notelist?
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

    func configuration() {
        title = Constant.NoteList.detail
        detailTableView.register(UINib(nibName: ProfileDetailCell.xibName, bundle: nil), forCellReuseIdentifier: ProfileDetailCell.cellIdentifier)
        detailTableView.register(UINib(nibName: CoverImageCell.xibName, bundle: nil), forCellReuseIdentifier: CoverImageCell.cellIdentifier)
        detailTableView.register(UINib(nibName: TagUserListCell.xibName, bundle: nil), forCellReuseIdentifier: TagUserListCell.cellIdentifier)
        detailTableView.register(UINib(nibName: UploadsImageCell.xibName, bundle: nil), forCellReuseIdentifier: UploadsImageCell.cellIdentifier)
    }
}

// MARK: UITableView Delegate Methods

extension ListDetailViewController: UITableViewDataSource, UITableViewDelegate, TagListViewDelegate,UploadsImageCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 400
        case 2:
            return UITableView.automaticDimension
        case 3:
            return 135
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailCell.cellIdentifier) as? ProfileDetailCell else {
                return UITableViewCell()
            }

            cell.listDetails = selectedDetails
            cell.profileConfigureCell()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoverImageCell.cellIdentifier) as? CoverImageCell else {
                return UITableViewCell()
            }
            cell.shareDelegate = self
            cell.listDetails = selectedDetails
            cell.coverDetailConfigureCell()
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TagUserListCell.cellIdentifier) as? TagUserListCell else {
                return UITableViewCell()
            }
            cell.tagListView.delegate = self

            for userName in selectedDetails!.tags {
                cell.tagListView.addTag(userName.name.replaceSpecialCharacter)
            }

            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UploadsImageCell.cellIdentifier) as? UploadsImageCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.collectionView.dataSource = cell
            cell.collectionView.delegate = cell
            cell.listDetails = selectedDetails
            return cell

        default:
            print("")
        }
        return UITableViewCell()
    }
    func didSelectImage(with imageUrl: String) {
        let vcObj = UploadImageViewerController(nibName: "UploadImageViewerController", bundle: nil)
        vcObj.imageUrlStr = imageUrl
          self.present(vcObj, animated: true, completion: nil)
      }
}

// MARK: Share detail  Methods
extension ListDetailViewController: CellShareDelegate {
    func didTapShareButton(for cell: UITableViewCell) {
        let subTitle = selectedDetails?.description.replaceSpecialCharacter
        let title = selectedDetails?.headLine.replaceSpecialCharacter
        let textToShare = "\(title ?? "")\n\(String(describing: subTitle ?? ""))"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
