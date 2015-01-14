import os
import glob
from PIL import Image, ImageFilter, ImageOps

# Get Images
image_extensions = ("*.jpg", "*.png", "*.gif")
images = []
for file_type in image_extensions:
    images.extend(glob.glob("unaltered/" + file_type))

# Process Images
for image_name in images:
    # Opens as image and converts to proper format
    image = Image.open(image_name)
    if image.mode not in ("L", "RGB"):
        image = image.convert("RGB")

    # Removes dir from image name
    save_name = image_name.replace("unaltered/", "")

    # Compresses file and saves as new image
    small = ImageOps.fit(image, (1920,1080), Image.ANTIALIAS)
    small.save("home_banner/" + save_name, 'JPEG', quality=60)
