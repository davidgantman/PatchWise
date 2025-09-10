# Inherit from the base image
FROM patchwise-base:latest

USER root

RUN pip3 install ply
RUN pip3 install GitPython
RUN pip3 install codespell

USER patchwise
