from PIL import Image
import base64
# change size of image
def changeImageSize(picture,size):
    img_switch = Image.open(picture)
    img_deal = img_switch.resize(size, Image.ANTIALIAS)
    URL="/mnt/c/Users/xuzz/Desktop/resize.png"
    img_deal.save(URL)
# tranform base64data to image
def download(img_data,save_name):
    with open(save_name, "wb") as fh:
        fh.write(base64.decodebytes(img_data))
        sh.close()
