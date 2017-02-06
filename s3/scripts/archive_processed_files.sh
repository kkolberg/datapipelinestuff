sudo yum -y upgrade aws-cli 
s3_config=$1
s3_object=$2

aws s3 cp $s3_config ./$s3_object.cfg

source ./$s3_object.cfg

echo "This is the input folder: $myS3InputLoc"
echo "This is the output folder: $myS3OutputLoc"
