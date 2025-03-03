# Run commands : 
# g5k-setup-nvidia-docker -t
# docker build -t martini_img:latest -f martini.dockerfile .
# docker run --restart always --gpus all --name martini_inst -e PYTHONUNBUFFERED=1 -d -it -v ~/capsid_new/melanoma/MD:/app -p 5679:5679 -p 2222:22 martini_img
# docker exec -it martini_inst 

FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt-get update && \
    apt-get install -y wget bzip2 git python3-pip openssl  && \
    rm -rf /var/lib/apt/lists/*

# Install Mambaforge (provides mamba and conda)
RUN wget -O Mambaforge.sh https://github.com/conda-forge/miniforge/releases/download/4.10.3-0/Mambaforge-Linux-x86_64.sh && \
    bash Mambaforge.sh -b && \
    rm Mambaforge.sh

ENV PATH="/root/mambaforge/bin:${PATH}"

# Install ambertools from conda-forge using mamba
RUN mamba install -c conda-forge ambertools -y

# Install openmm using mamba
RUN mamba install openmm -y

# Install mdtraj via conda-forge using mamba
RUN mamba install -c conda-forge mdtraj -y

# Install additional Python packages via pip
RUN pip install git+https://github.com/pablo-arantes/biopandas && \
    pip install --upgrade MDAnalysis==2.4.2 && \
    pip install vermouth && \
    pip install git+https://github.com/pablo-arantes/martini_openmm && \
    pip install git+https://github.com/Tsjerk/simopt && \
    pip install git+https://github.com/pablo-arantes/Insane && \
    pip install py3Dmol && \
    pip install six && \
    pip install seaborn 

# Install Jupyter Notebook and IPython kernel
RUN pip install notebook ipykernel && \
    python -m ipykernel install --name python3 --display-name "Python 3 (Martini)" --user

RUN mamba create --name cg2all pip cudatoolkit=11.3 dgl=1.0 -c dglteam/label/cu113 -y && \
    /bin/bash -c "source /root/mambaforge/etc/profile.d/conda.sh && \
    conda activate cg2all && \
    pip install git+http://github.com/huhlim/cg2all"

# Create Jupyter config directory and configuration
RUN mkdir -p /root/.jupyter && \
    echo "c.MultiKernelManager.default_kernel_name = 'python3'" > /root/.jupyter/jupyter_notebook_config.py

# Create kernel specification
RUN mkdir -p /root/.local/share/jupyter/kernels/python3 && \
    echo '{                                          \
        "argv": [                                    \
            "python3",                               \
            "-m",                                    \
            "ipykernel_launcher",                    \
            "-f",                                    \
            "{connection_file}"                      \
        ],                                          \
        "display_name": "Python 3 (Martini)",       \
        "language": "python",                        \
        "env": {                                    \
            "PATH": "/root/mambaforge/bin:$PATH"    \
        }                                           \
    }' > /root/.local/share/jupyter/kernels/python3/kernel.json

# Set up SSH server
RUN apt-get update && \
apt-get install -y openssh-server && \
mkdir /var/run/sshd && \
echo 'root:password' | chpasswd && \
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 8888 22

# Start SSH server and Jupyter Notebook
CMD ["/bin/bash", "-c", "service ssh start && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"]