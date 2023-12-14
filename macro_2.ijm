setThreshold(118, 255);
setOption("BlackBackground", true);
//run("Threshold...");
run("Convert to Mask");

roiManager("reset");
run("Clear Results");

run("Shape Filter", "area=0.01-Infinity area_convex_hull=0-Infinity perimeter=0-Infinity perimeter_convex_hull=0-Infinity feret_diameter=0-Infinity min._feret_diameter=0-Infinity max._inscr._circle_diameter=0-Infinity area_eq._circle_diameter=0-Infinity long_side_min._bounding_rect.=0-Infinity short_side_min._bounding_rect.=0-Infinity aspect_ratio=1-Infinity area_to_perimeter_ratio=0-Infinity circularity=0-Infinity elongation=0-1 convexity=0-1 solidity=0-1 num._of_holes=0-Infinity thinnes_ratio=0-1 contour_temperatur=0-1 orientation=0-180 fractal_box_dimension=0-2 option->box-sizes=2,3,4,6,8,12,16,32,64 add_to_manager draw_holes black_background fill_results_table exclude_on_edges");
run("Undo");
roiManager("Show All");
roiManager("UseNames", "true");

nb_Obj = roiManager("count");

for (i = 0; i < nb_Obj; i++){

	roiManager("select", i);
	areaConvHull=getResult("Area Conv. Hull",i);
	maximumInscriptedCircleDiameter=getResult("Maximum inscriped circle diameter",i);
	areaPeri= getResult("Area/Peri.",i);
	minFeret = getResult("Min. Feret", i);
	trou = getResult("Num. of Holes",i);
	
	if( areaConvHull >= 0.1125 && areaConvHull <= 0.4378){
		setResult("Label",i,"Clé");
		roiManager("Rename","Clé");
	}
	else{
		if( areaConvHull <= 0.0265 && areaConvHull >=0.0198 && trou >=1 && trou <= 6){
			setResult("Label",i,"De "+trou);
			roiManager("Rename","De "+trou);
		}
	
	
	else{
		if( maximumInscriptedCircleDiameter >= 0.041 && maximumInscriptedCircleDiameter <= 0.133   &&  trou==1){
			setResult("Label",i,"Rondelle");
			roiManager("Rename","Rondelle");
		}
	
	else{
		if( areaPeri<0.07865 && areaPeri > 0.042 ||( minFeret >=0.325 && minFeret<= 0.374) && trou == 0 ){
			setResult("Label",i,"Piece");
			roiManager("Rename","Piece");
		}
	
	else{
		if(minFeret > 0.2808 && minFeret<0.325 && trou == 0){
			setResult("Label",i,"Etalon");
			roiManager("Rename","Etalon");
		}

	else{
		setResult("Label",i,"Inconnu");
		roiManager("Rename","Inconnu");
						}
				}
			}
			
		}
		
	}
}

roiManager("Show All with labels");
run("Revert");

