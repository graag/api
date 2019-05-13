cur_dir=$PWD
volume=$1
directory=$2

cd $directory

echo "Creating volume $volume from dir $directory"

docker volume create $1

if [ -z "$directory" ]; then
    echo "$directory not found"
    exit 0
fi

container_id=$(docker run -d -v $volume:/volume python)
echo "Started container: $container_id"
for file in $(ls)
do
    echo "Copying $file"
    docker cp $file $container_id:/volume
done
docker rm -f $container_id
cd $cur_dir