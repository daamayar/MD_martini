# **Molecular Dynamics Simulations with MARTINI**
This repository contains files and configurations for running molecular dynamics simulations of peptide-HLA complexes using the MARTINI coarse-grained force field.

# **Directory Structure**
- AKP6_WT : Contains output simulation files
    - PDB files (.pdb) : Atomic structure files
    - DCD files (.dcd) : Trajectory data
    - LOG files (.log) : Simulation logs
    - RST files (.rst) : Restart files
- martini : Contains MARTINI force field configuration files

# **Scripts**
- martinize.sh : Script to generate the structure topology using the Martini force field (script generated during the notebook execution)
- pdb4amber.sh : Script to prepare PDB files for simulations (script generated during the notebook execution)

# **Notebooks**
Martini_MD_simulations.ipynb : Jupyter notebook for MARTINI simulations, back-mapping and basic analysis.

# **Docker**
A Docker image is provided to ensure reproducibility:
    - martini.dockerfile : Dockerfile with all necessary dependencies

# **Usage**
- Prepare your protein structure removing waters and renaming HSD to HIS residues.
- Set parameters in the notebook (file and directory names, simulation parameters, etc).
- Run the notebook following the notebook instructions.

# **Contact**
Diego Amaya ramirez <diego.amaya-ramirez@inria.fr> 

# **Acknowledgements**
This project is based on the implementations described in the paper "***Making it rain: Cloud-based molecular simulations for everyone***" ([link here](https://doi.org/10.1021/acs.jcim.1c00998)).

# **License**
MIT license

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.