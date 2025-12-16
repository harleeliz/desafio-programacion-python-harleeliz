#!/usr/bin/env bash
set -e

# ---- 1) Install Miniforge (Conda) if missing ----
if [ ! -d "/opt/conda" ]; then
  echo "Installing Miniforge..."
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64) MINIFORGE_ARCH="x86_64" ;;
    aarch64|arm64) MINIFORGE_ARCH="aarch64" ;;
    *) echo "Unsupported arch: $ARCH" && exit 1 ;;
  esac

  curl -L -o /tmp/miniforge.sh \
    "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${MINIFORGE_ARCH}.sh"

  bash /tmp/miniforge.sh -b -p /opt/conda
fi

# make conda available
source /opt/conda/etc/profile.d/conda.sh

# ---- 2) Create or update the ml env ----
if conda env list | awk '{print $1}' | grep -qx "ml"; then
  conda env update -n ml -f environment.yml
else
  conda env create -n ml -f environment.yml
fi

# ---- 3) Register Jupyter kernel ----
conda activate ml
python -m pip install --upgrade pip
python -m pip install ipykernel
python -m ipykernel install --user --name ml --display-name "Python (ml)"

echo "Ml env ready."