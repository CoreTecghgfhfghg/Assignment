

import UIKit

class UploadsImageCell: UITableViewCell {
    //MARK Outlet
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK Variable
    var listDetails: Notelist?
    var delegate: UploadsImageCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UploadsImageCell: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDetails?.uploads.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.uploadedImage.setImage(with: listDetails?.uploads[indexPath.row].url ?? "")
        cell.isUserInteractionEnabled = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if let imageUrl = listDetails?.uploads[indexPath.row].url {
             delegate?.didSelectImage(with: imageUrl)
         }
     }
 }


protocol UploadsImageCellDelegate: AnyObject {
    func didSelectImage(with imageUrl: String)
}
