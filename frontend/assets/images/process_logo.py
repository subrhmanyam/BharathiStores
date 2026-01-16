from PIL import Image
import os

def remove_white_background(input_path, output_path):
    print(f"Processing {input_path}...")
    try:
        img = Image.open(input_path)
        img = img.convert("RGBA")
        
        datas = img.getdata()
        
        new_data = []
        for item in datas:
            # Change all white (also shades of whites)
            # Find all pixels that are "close" to white (255, 255, 255)
            if item[0] > 200 and item[1] > 200 and item[2] > 200:
                new_data.append((255, 255, 255, 0))
            else:
                new_data.append(item)
        
        img.putdata(new_data)
        img.save(output_path, "PNG")
        print(f"Saved transparent logo to {output_path}")
    except Exception as e:
        print(f"Error: {e}")

input_file = '/Users/surya/Documents/code-base/RushiPeetam/BharathiStores/frontend/assets/images/logo.jpg'
output_file = '/Users/surya/Documents/code-base/RushiPeetam/BharathiStores/frontend/assets/images/logo_transparent.png'

if os.path.exists(input_file):
    remove_white_background(input_file, output_file)
else:
    print("Input file not found!")
