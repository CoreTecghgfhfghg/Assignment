

import UIKit

class UploadImageViewerController: UIViewController {
    @IBOutlet weak var fullImage: UIImageView!
    var imageUrlStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullImage.setImage(with:imageUrlStr)
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
