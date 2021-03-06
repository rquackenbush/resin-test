FROM debian:jessie-slim

ENV MONO_VERSION 5.0.1.1

RUN apt-get update \
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian jessie/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official.list \
  && apt-get update \
  && apt-get install -y mono-devel ca-certificates-mono referenceassemblies-pcl \
  && rm -rf /var/lib/apt/lists/* /tmp/*

#Copy the source to the container
COPY test.exe /opt/test/test.exe  
 
#start up the application
ENTRYPOINT mono /opt/test/test.exe