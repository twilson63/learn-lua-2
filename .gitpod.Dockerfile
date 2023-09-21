FROM gitpod/workspace-full

RUN curl -fsSL https://install_ao.g8way.io | bash
# RUN echo 'export AO_INSTALL=/home/gitpod/.ao' >> /home/gitpod/.bashrc && \
#  echo 'export PATH="$AO_INSTALL/bin:$PATH"' >> /home/gitpod/.bashrc && \
#  source /home/gitpod/.bashrc
