import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

slice_img = cv2.imread('scripts/clean_plates/slice_e.jpg')
# Clean the letter 'E' in the bottom-left corner
slice_img[400:445, 0:40] = slice_img[400:445, 40:80] # patch out 'E'

# Resize slice to fit 860 height
h, w, _ = slice_img.shape
target_h = 860
target_w = int(w * target_h / h)
resized = cv2.resize(slice_img, (target_w, target_h), interpolation=cv2.INTER_LANCZOS4)

canvas = np.zeros((1000, 1000, 3), dtype=np.uint8)
canvas[:] = (10, 12, 18)

x_offset = (1000 - target_w) // 2
canvas[70:70+target_h, x_offset:x_offset+target_w] = resized

pil_canvas = Image.fromarray(cv2.cvtColor(canvas, cv2.COLOR_BGR2RGB))
draw = ImageDraw.Draw(pil_canvas)

# Orientation markers
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

# Add clinical legend at bottom
draw.text((x_offset + 10, 890), "a: Anterior Uncal Herniation (Suprasellar / Ambient Cistern Effacement)", fill=(255, 215, 0))
draw.text((x_offset + 10, 910), "b: Midbrain Peduncle Compression | c: Contralateral Temporal Horn Entrapment", fill=(200, 215, 230))

pil_canvas.save('Assets.xcassets/plate_ct_uncal.imageset/plate_ct_uncal.jpg', 'JPEG', quality=95)
print('plate_ct_uncal updated successfully!')
