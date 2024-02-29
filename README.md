Este es un script desarrollado en Matlab. Es necesario, primero alinear las imágenes T1, a la comisura 0, desde la interfaz de SPM, el cual es un toolbox que ya debe estar 
previamente instalado. Luego, ejecutarlo, pero antes colocarlo dentro de las imágenes nifti, y haberlas agregado en el vector "subjName", justo como en el ejemplo. 
Es importante mencionar que, SPM no admite trabajar con imágenes comprimidas ".gz", es decir, no podrá trabajar con "nii.gz".

Una vez que termine el análisis de preprocesamiento, alineado y segmentación del cerebelo del resto del encéfalo, también segmentara GM, WM y CSF, y podrá podrá realizar un "FSL randomise", para realizar un análisis de Voxel-Based Morphometry, 
que involucre sólo involucre cerebelo, p. ej. «randomise -i GM_mod_merg_s3 -m Cerebellum_GM_mask -o fslvbm -d design.mat -t design.con -T -n 10000»


Al finalizar, incluso hacer uso de la representación en 2D del cerebelo, llamada "flatmap", p. ej:

Data=suit_map2surf('PX.nii.gz','space','SUIT','stats',@minORmax);
suit_plotflatmap(Data, 'cmap', hot, 'cscale', [.1,.7], 'threshold', .3);


 
![flatmap](https://github.com/jokasta57/SUIT_pipeline_cerebelo/assets/16157859/e19ad9d6-966a-471b-9280-12a3bf252137)
