#!/bin/bash
#SBATCH --job-name=selfphish-nb
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --time=08:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G

set -euo pipefail

# Acesssar diretório com notebook
cd notebooks

# Inicializar o Conda
eval "$(conda shell.bash hook)"
conda activate projeto_pi

jupyter kernelspec list

# Mostrar informações do ambiente
python --version
# python -c "import torch; print('PyTorch:', torch.__version__); print('CUDA:', torch.cuda.is_available())"

# Criar a pasta de resultados
mkdir -p outputs

# Executar o notebook e salvar uma cópia com as saídas
jupyter nbconvert \
    --to notebook \
    --execute V1_ProjetoImagemIA.ipynb \
    --output V1_ProjetoImagemIA_executed.ipynb \
    --output-dir outputs \
    --ExecutePreprocessor.kernel_name=selfphish-deepinv \
    --ExecutePreprocessor.timeout=3600

echo "Execução do notebook concluída."
