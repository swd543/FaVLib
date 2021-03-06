## How to run

Please define the absolute path of the folder that you want virtuoso to map to, from there you will upload the files to virtuoso
export ABS_PATH=/media/apc/DATA1/Maastricht

run this command to run Virtuoso, it will also install it if it is not there


```shell
apt-get install cwltool
```


```shell
sudo docker run --rm --name virtuoso.2.7.1 \
    -p 8890:8890 -p 1111:1111 \
    -e DBA_PASSWORD=dba \
    -e SPARQL_UPDATE=true \
    -e DEFAULT_GRAPH=http://bio2rdf.com/bio2rdf_vocabulary: \
    -v ${ABS_PATH}/bio2rdf-github/virtuoso:/data \
    -d tenforce/virtuoso:1.3.2-virtuoso7.2.1
```


```shell
sudo docker build -t favlib .
```

```shell
sudo docker run -d --rm --link virtuoso.2.7.1:virtuoso.2.7.1 --name favlib -p 8888:8888 -v /media/apc/DATA1/Maastricht/favlib:/jupyter -v /tmp:/tmp favlib
```
```shell
sudo docker exec -it favlib cwltool --outdir=/jupyter/output/ workflow/main-workflow.cwl workflow/workflow-job.yml
```



## Using Docker Compose 
* First make sure Docker-Compose is installed!!

* Clone the current repository
```shell
git clone https://github.com/MaastrichtU-IDS/FaVLib.git
```
* Enter the repository
```shell
cd FavLib
```
* Edit the file .env to set the path of the folder that you want virtuoso to map to, from there you will upload the files to virtuoso. Also you will set the output folder of the workflow
```shell
cat .env
```

* Run the command
```shell
docker-compose up -d --build --force-recreate virtuoso.2.7.1 favlib

```
* Load the data (eg put  your data (named "rdf_output.nq") into ${VIRTUOSO_PATH}/dumps directory )
```shell
docker exec -it favlib_virtuoso.2.7.1_1 bash -c "cd /shared && ./load.sh ./dumps rdf_output.nq http://test-vad vload.log dba"
```

* Execute the workflow
```shell
docker-compose exec favlib cwltool --outdir=/jupyter/output/ workflow/main-workflow.cwl workflow/workflow-job.yml
```
* That's it!!
