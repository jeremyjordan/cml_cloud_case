FROM dvcorg/cml-gpu-py3-cloud-runner

RUN apt-get update -y  &&\
    apt-get install python3-dev -y &&\
    apt install imagemagick -y

ADD . /workdir
RUN pip install -r /workdir/requirements.txt

ENTRYPOINT [ "/workdir/docker/entrypoint.sh" ]
