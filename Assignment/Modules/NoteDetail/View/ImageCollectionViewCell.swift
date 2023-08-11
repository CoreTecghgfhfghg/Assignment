
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var uploadedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        uploadImageRound()
    }

    func uploadImageRound() {
        uploadedImage.layer.cornerRadius = 8
        uploadedImage.clipsToBounds = true
        uploadedImage.layer.borderWidth = 2.0 // Choose your desired border width
        uploadedImage.layer.borderColor = UIColor.blue.cgColor
    }
}
