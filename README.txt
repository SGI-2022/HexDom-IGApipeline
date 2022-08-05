# Hybrid IGE-FEA mesh generation and simulation

## File folder structures
[grid_hybrid_demo]: contains all the necessary input files to generate hybrid IGA-FEA mesh and simulation files for grid geometry.
	[grid_simulation]: contains input files to generate LS-Dyna simulation file.
		[grid_LSDyna_Results]: contains simulation results from LS-Dyna (visualize d3eigv)
[Ibeam_hybrid_demo]: contains all the necessary input files to generate hybrid IGA-FEA mesh and simulation files for Ibeam geometry.
	[Ibeam_simulation]: contains input files to generate LS-Dyna simulation file.
		[Ibeam_LSDyna_Results]: contains simulation results from LS-Dyna (visualize d3eigv)
And all necessary execution files

## How to run
1. Run .bat file in each demo folder to generate mesh files
2. Once finished .bat file, use Hex2Spline to generate Bspline mesh (BEXT) from generated hex vtk file (some sharp features need to be defined to get better representation).
3. Merge all prism_xxxx.k files together as grid_prisms.k using LS-Prepost (in grid_simulation folder)
4. Merge duplicate points (keep larger node index) between prism and hexmesh to get grid_merged.k using LS-Prepost (in grid_simulation folder)
5. Add simulation settings and import commands to import BEXT file in .k files (grid_IGA.k)
6. Run simulation using LS-Dyna

EDIT (06/28/2022)
In each case folder (XX_hybrid_demo), there are multiple files used as inputs.
1. Step 1 Segmentation.exe takes initial triangular surface mesh "XX_surf.k" as input, and output CVT surface segmentation mesh "XX_indexPatch_hexdom.k", and "XX_indexPatch_hexdom_edited.k" is the manually modified version of step 1 output CVT mesh.
2. Step 2 PolyCube.exe takes "XX_indexPatch_hexdom_edited.k" as input and generates corresponding polycube surface shells "XX_initialpolycube.k", and "XX_polycube_connect.k" is the manually connected polycube structure.
3. Step 3 HexGen.exe takes 2 inputs: segmented surface mesh "XX_indexPatch_hexdom_edited.k" and polycube structure "XX_polycube_connect.k" to generate all hex mesh "XX_hexmesh.vtk".
4. Step 4 Quality.exe improves "XX_hexmesh.vtk" mesh quality and save results as "XX_hexmesh_smooth.vtk".
5. Additional optional step PrismGen.exe is used to generate prism mesh for hybrid mesh simulation. Takes surface triangular mesh "prism_xxxx_tri_refined.k" as input and save output as "prism_XXXX_refined.vtk"

* .k .d3eigv can be viewed using LS-Prepost
* .vtk can be viewed using Paraview
Both software can be download for free online