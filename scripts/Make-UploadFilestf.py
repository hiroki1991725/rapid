#! /usr/bin/python3.6

# import packages
import os
from pathlib import Path
import re

# define variables
SourceFolderName = "content"
SourcePath = Path(os.path.join("..",SourceFolderName))
TF_File = Path(os.path.join("..","terraform","UploadingFiles.tf"))
ResourceTemplate = '''
resource "aws_s3_bucket_object" "file_{count}" {{
  bucket = "${{aws_s3_bucket.index.bucket}}"
  key = "{key}"
  source = "{filePath}"
}}
'''


# define functions
def WriteResource():
    Key = re.sub(r"\.\.[/\\]","",str(i))
    f = open(TF_File,'a')
    f.write(ResourceTemplate.format(count=Counter, key=Key ,filePath=i))
    f.close


# Main
SourceFiles = list(SourcePath.glob("**/*.*"))       # define transporting files
f = open(TF_File,'w')                               # Create ".tf" file
for i in SourceFiles:                               # add resource records
    Counter = SourceFiles.index(i)+1
    WriteResource()
