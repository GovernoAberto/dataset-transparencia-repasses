import os, zipfile

for item in os.listdir("download"):
    if item.endswith(".zip"):
        zip_ref = zipfile.ZipFile("download/" + item)
        zip_ref.extractall("download")
        zip_ref.close()