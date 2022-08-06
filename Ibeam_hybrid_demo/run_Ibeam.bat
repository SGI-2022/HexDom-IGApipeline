
:: This batch file checks Ibeam_surf.k,
@echo on

:: OUTPUT
@echo Run segmentation
..\Segmentation.exe -i .\Ibeam_surf.k -o .\Ibeam_indexPatch_hexdom.k
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in Ibeam_indexPatch_hexdom.k
@echo Before next step: perform further segmentation (Our result is in Ibeam_indexPatch_hexdom_edit.k)
@pause

:: OUTPUT
@echo Create polycube structure
..\PolyCube.exe -i .\Ibeam_indexPatch_hexdom_edit.k -o .\Ibeam_initialpolycube.k
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in Ibeam_initialpolycube.k 
@echo Before next step: manually build polycube (Our result is in Ibeam_polycube_connect.k)
@pause

:: OUTPUT
@echo Generate hex mesh
..\HexGen.exe -i .\Ibeam_indexPatch_hexdom_edit.k -p .\Ibeam_polycube_connect.k -n 30 -s 2 -o .\Ibeam_hexmesh.vtk
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in Ibeam_hexmesh.vtk 
@pause

:: OUTPUT
@echo Improve hexahedral mesh quality
..\Quality.exe -I .\Ibeam_hexmesh.vtk -m 2 -n 4 -p 0.01 -s 0
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in Ibeam_hexmesh_smooth.vtk 
@pause

:: OUTPUT
@echo Generate prism mesh
..\PrismGen.exe -i .\prism_0000_tri_refined.k -o .\prism_0000_refined.vtk
..\PrismGen.exe -i .\prism_0001_tri_refined.k -o .\prism_0001_refined.vtk
..\PrismGen.exe -i .\prism_0002_tri_refined.k -o .\prism_0002_refined.vtk
..\PrismGen.exe -i .\prism_0003_tri_refined.k -o .\prism_0003_refined.vtk
..\PrismGen.exe -i .\prism_0004_tri_refined.k -o .\prism_0004_refined.vtk
@echo Done!
@echo -------------------------------------------------------------------
@echo Please check the result in prism_000X_refined.vtk (visualize with Ibeam_hexmesh_smooth.vtk) 
@pause
