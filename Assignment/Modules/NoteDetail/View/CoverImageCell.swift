
import UIKit

class CoverImageCell: UITableViewCell {
    // MARK: Outlet

    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var commenLabel: UILabel!
    @IBOutlet var favouriteImage: UIImageView!
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var rateButton: UIButton!

    // MARK: Variabel

    var listDetails: Notelist?
    weak var shareDelegate: CellShareDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        shareDelegate?.didTapShareButton(for: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Configure Cell
    func coverDetailConfigureCell() {
        guard let listDetails else { return }
        coverImage.setImage(with: listDetails.coverPic.url)
        commenLabel.text = "\(listDetails.commentsCount)"
        likeLabel.text = "\(listDetails.count)"
        rateButton.setTitle("\(listDetails.userRating)", for: .normal)
        if listDetails.status == true {
            likeImage.image = UIImage(named: "like")
        } else {
            likeImage.image = UIImage(named: "unlike")
        }
        if listDetails.favoriteStatus == true {
            favouriteImage.image = UIImage(named: "Favourite")
        } else {
            favouriteImage.image = UIImage(named: "heart")
        }
    }
}
