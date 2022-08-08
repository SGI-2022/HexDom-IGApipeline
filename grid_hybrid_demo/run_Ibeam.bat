
:: This batch file checks grid_surf.k,
@echo on

:: OUTPUT
@echo Run segmentation
..\Segmentation.exe -i .\grid_surf.k -o .\grid_indexPatch_hexdom.k
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in grid_indexPatch_hexdom.k
@echo Before next step: perform further segmentation (Our result is in grid_indexPatch_hexdom_edit.k)
@pause

:: OUTPUT
@echo Create polycube structure
..\PolyCube.exe -i .\grid_indexPatch_hexdom_edit.k -o .\grid_initialpolycube.k
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in grid_initialpolycube.k 
@echo Before next step: manually build polycube (Our result is in grid_polycube_connect.k)
@pause

:: OUTPUT
@echo Generate hex mesh
..\HexGen.exe -i .\grid_indexPatch_hexdom_edit.k -p .\grid_polycube_connect.k -n 25 -s 2 -o .\grid_hexmesh.vtk
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in grid_hexmesh.vtk 
@pause

:: OUTPUT
@echo Improve hexahedral mesh quality
..\Quality.exe -I .\grid_hexmesh.vtk -m 2 -n 12 -p 0.01 -s 0
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in grid_hexmesh_smooth.vtk 
@pause

:: OUTPUT
@echo Generate prism mesh
..\PrismGen.exe -i .\prism_0000_tri_refined.k -o .\prism_0000_refined.vtk
..\PrismGen.exe -i .\prism_0001_tri_refined.k -o .\prism_0001_refined.vtk
..\PrismGen.exe -i .\prism_0002_tri_refined.k -o .\prism_0002_refined.vtk
..\PrismGen.exe -i .\prism_0003_tri_refined.k -o .\prism_0003_refined.vtk
..\PrismGen.exe -i .\prism_0004_tri_refined.k -o .\prism_0004_refined.vtk
..\PrismGen.exe -i .\prism_0005_tri.k -o .\prism_0005.vtk
..\PrismGen.exe -i .\prism_0006_tri.k -o .\prism_0006.vtk
..\PrismGen.exe -i .\prism_0007_tri_refined.k -o .\prism_0007_refined.vtk
..\PrismGen.exe -i .\prism_0008_tri_refined.k -o .\prism_0008_refined.vtk
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in prism_000X_refined.vtk (visualize with grid_hexmesh_smooth.vtk) 
@echo Before next step: manually extract surface triangle mesh for prism polycube sections. (Note that refinement might be needed, prism generation in the next step need sufficient nodes for interpolation)
@pause

:: OUTPUT
@echo Convert mesh from .vtk to .k format
@echo Press enter when the program seems to stop
..\vtk_to_k.exe .\grid_hexmesh_smooth.vtk .\grid_hexmesh_smooth.k
..\vtk_to_k.exe .\prism_0000_refined.vtk .\prism_0000_refined.k
..\vtk_to_k.exe .\prism_0001_refined.vtk .\prism_0001_refined.k
..\vtk_to_k.exe .\prism_0002_refined.vtk .\prism_0002_refined.k
..\vtk_to_k.exe .\prism_0003_refined.vtk .\prism_0003_refined.k
..\vtk_to_k.exe .\prism_0004_refined.vtk .\prism_0004_refined.k
..\vtk_to_k.exe .\prism_0005.vtk .\prism_0005.k
..\vtk_to_k.exe .\prism_0006.vtk .\prism_0006.k
..\vtk_to_k.exe .\prism_0007_refined.vtk .\prism_0007_refined.k
..\vtk_to_k.exe .\prism_0008_refined.vtk .\prism_0008_refined.k
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in all the newly generated .k files
@echo Before next step: Combine all prism.k files in LS-Prepost, then merge duplicated nodes (between prism and hexmesh, keep large node index because later on B-spline BEXT file is imported after prism elements)
@pause