
import UIKit

class ProfileDetailCell: UITableViewCell {
    // MARK: Outlet

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    // MARK: Variabel

    var listDetails: Notelist?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Configure Cell
    func profileConfigureCell() {
        guard let listDetails else { return }
        profileImage.setImage(with: listDetails.userDetails.upload.url)
        userNameLabel.text = listDetails.userDetails.name
        addressLabel.text = listDetails.address.replaceSpecialCharacter
        headlineLabel.text = listDetails.headLine.replaceSpecialCharacter
        descriptionLabel.text = listDetails.description.replaceSpecialCharacter
    }
    // MARK: - Profile Circular image
    
    func profileImageCircular() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
}
