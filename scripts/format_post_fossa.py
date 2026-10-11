import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

# Load cropped posterior fossa CT
inner = cv2.imread('scripts/clean_plates/post_fossa_cropped.jpg')
# Resize to 860x860
inner_resized = cv2.resize(inner, (860, 860), interpolation=cv2.INTER_LANCZOS4)

# Canvas 1000x1000
canvas = np.zeros((1000, 1000, 3), dtype=np.uint8)
canvas[:] = (10, 12, 18) # obsidian dark bg
canvas[70:930, 70:930] = inner_resized

pil_canvas = Image.fromarray(cv2.cvtColor(canvas, cv2.COLOR_BGR2RGB))
draw = ImageDraw.Draw(pil_canvas)

# Draw orientation boxes
# ANT (top)
draw.rectangle([(460, 15), (540, 50)], outline=(0, 215, 255), width=2)
draw.text((478, 22), "ANT", fill=(0, 215, 255))

# POST (bottom)
draw.rectangle([(455, 945), (545, 980)], outline=(255, 165, 0), width=2)
draw.text((472, 952), "POST", fill=(255, 165, 0))

# R (left)
draw.rectangle([(15, 470), (50, 510)], outline=(180, 190, 210), width=2)
draw.text((27, 478), "R", fill=(255, 255, 255))

# L (right)
draw.rectangle([(950, 470), (985, 510)], outline=(180, 190, 210), width=2)
draw.text((963, 478), "L", fill=(255, 255, 255))

pil_canvas.save('Assets.xcassets/plate_ct_post_fossa.imageset/plate_ct_post_fossa.jpg', 'JPEG', quality=95)
print('plate_ct_post_fossa updated successfully!')
