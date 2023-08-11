
import UIKit
protocol CellShareDelegate: AnyObject {
    func didTapShareButton(for cell: UITableViewCell)
}

class NotelistCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var favouriteImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var totalLikeLabel: UILabel!
    @IBOutlet var totalCommentLabel: UILabel!
    @IBOutlet var descriptionLabel: ExpandableLabel!
    @IBOutlet var rateButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var headLineLable: UILabel!
    
    var notelist: Notelist?
    weak var shareDelegate: CellShareDelegate?
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.collapsed = true
        descriptionLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageCircular()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    // MARK: - Button Action

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        shareDelegate?.didTapShareButton(for: self)
    }

    // Configure Cell
    func configureCell() {
        guard let notelist else { return }
        coverImage.setImage(with: notelist.coverPic.url)
        profileImage.setImage(with: notelist.userDetails.upload.url)
        userNameLabel.text = notelist.userDetails.name
        totalCommentLabel.text = "\(notelist.commentsCount)"
        totalLikeLabel.text = "\(notelist.count)"
        rateButton.setTitle("\(notelist.userRating)", for: .normal)
        if notelist.favoriteStatus == true {
            favouriteImage.image = UIImage(named: "Favourite")
        } else {
            favouriteImage.image = UIImage(named: "heart")
        }
        if notelist.status == true {
            likeImage.image = UIImage(named: "like")
        } else {
            likeImage.image = UIImage(named: "unlike")
        }
        descriptionLabel.setLessLinkWith(lessLink: "See Less", attributes: [.foregroundColor: UIColor.red], position: .left)
        layoutIfNeeded()
        descriptionLabel.shouldCollapse = true
        descriptionLabel.textReplacementType = .word
        descriptionLabel.numberOfLines = 2
        headLineLable.text = notelist.headLine.replaceSpecialCharacter
        descriptionLabel.text = notelist.description.replaceSpecialCharacter
    }
    
    // MARK: - Profile image
    
    func profileImageCircular() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
}
