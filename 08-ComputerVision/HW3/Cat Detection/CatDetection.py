import cv2
import os
import matplotlib.pyplot as plt
import numpy as np
import glob

def get_image_path(filename):
    return os.path.join("images", filename)

def get_model_path(filename="haarcascade_frontalcatface_extended.xml"):
    return os.path.join("models", filename)

def get_output_folder():
    folder = "outputImages"
    if not os.path.exists(folder):
        os.makedirs(folder)
    return folder

def show_images(images_dict, columns=3, img_size=5):
    titles = list(images_dict.keys())
    imgs = list(images_dict.values())
    rows = (len(imgs) + columns - 1) // columns
    plt.figure(figsize=(img_size * columns, img_size * rows))
    for idx, (title, img) in enumerate(zip(titles, imgs)):
        plt.subplot(rows, columns, idx + 1)
        plt.imshow(img if len(img.shape) == 3 else img, cmap=None if len(img.shape) == 3 else 'gray')
        plt.title(title, fontsize=8)
        plt.axis('off')
    plt.tight_layout()
    plt.show()

def detect_cats_on_image(image_rgb, detector, rect_params):
    image_copy = image_rgb.copy()
    gray = cv2.cvtColor(image_copy, cv2.COLOR_RGB2GRAY)
    rects = detector.detectMultiScale(gray, **rect_params)
    for i, (x, y, w, h) in enumerate(rects):
        cv2.rectangle(image_copy, (x, y), (x + w, y + h), (0, 255, 0), 2)
        cv2.putText(image_copy, f'Cat #{i+1}', (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2, cv2.LINE_AA)
    return image_copy

def process_image(image_path, detector, rect_params, images_dict, output_folder):
    image_bgr = cv2.imread(image_path)
    image_rgb = cv2.cvtColor(image_bgr, cv2.COLOR_BGR2RGB)
    detected_image = detect_cats_on_image(image_rgb, detector, rect_params)
    filename = os.path.basename(image_path)
    images_dict[filename] = image_rgb
    images_dict[filename + " Detected"] = detected_image
    detected_bgr = cv2.cvtColor(detected_image, cv2.COLOR_RGB2BGR)
    cv2.imwrite(os.path.join(output_folder, "detected_" + filename), detected_bgr)

def main():
    model_path = get_model_path()
    detector = cv2.CascadeClassifier(model_path)
    rect_params = {"scaleFactor": 1.02, "minNeighbors": 2, "minSize": (180, 180)}

    output_folder = get_output_folder()
    images_dict = {}

    image_extensions = ("*.jpg", "*.jpeg", "*.png", "*.webp")
    image_files = []
    for ext in image_extensions:
        image_files.extend(glob.glob(os.path.join("images", ext)))

    for img_path in image_files:
        process_image(img_path, detector, rect_params, images_dict, output_folder)

    show_images(images_dict, columns=2, img_size=5)

if __name__ == "__main__":
    main()
