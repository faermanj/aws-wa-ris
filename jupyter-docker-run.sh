#/bin/bash

docker run -it --rm \
    -p 8888:8888 \
    -v ${PWD}/jupyter/:/home/jovyan/work \
    jupyter/minimal-notebook \
    start.sh jupyter lab --NotebookApp.notebook_dir=/home/jovyan/work
