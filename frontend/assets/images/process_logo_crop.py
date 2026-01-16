from PIL import Image
import os

def process_logo(input_path, output_path):
    print(f"Processing {input_path}...")
    try:
        img = Image.open(input_path)
        img = img.convert("RGBA")
        
        datas = img.getdata()
        
        new_data = []
        for item in datas:
            # Change all white pixels to transparent
            # Threshold: > 200 on all channels
            if item[0] > 200 and item[1] > 200 and item[2] > 200:
                new_data.append((255, 255, 255, 0))
            else:
                new_data.append(item)
        
        img.putdata(new_data)
        
        # Crop the image to the bounding box of non-transparent areas
        bbox = img.getbbox()
        if bbox:
            img = img.crop(bbox)
            print(f"Cropped to {bbox}")
        
        img.save(output_path, "PNG")
        print(f"Saved processed logo to {output_path}")
    except Exception as e:
        print(f"Error: {e}")

input_file = '/Users/surya/Documents/code-base/RushiPeetam/BharathiStores/frontend/assets/images/logo.jpg'
output_file = '/Users/surya/Documents/code-base/RushiPeetam/BharathiStores/frontend/assets/images/logo.png'

if os.path.exists(input_file):
    process_logo(input_file, output_file)
else:
    print("Input file not found!")
