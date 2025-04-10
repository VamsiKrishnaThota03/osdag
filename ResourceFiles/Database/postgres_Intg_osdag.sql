/* PRAGMA foreign_keys=OFF; */

/*
#########################################################
# Author : Atharva Pingale ( FOSSEE Summer Fellow '23 ) #
#########################################################
*/ 

BEGIN TRANSACTION;


CREATE TABLE IF NOT EXISTS public."Design" (
	"id" SERIAL PRIMARY KEY,
	"cookie_id" VARCHAR(32),
	"module_id" VARCHAR(200),
	"input_values" JSONB,
	"logs" TEXT,
	"output_values" JSONB,
	"design_status" BOOLEAN,
	"cad_design_status" BOOLEAN
);

CREATE TABLE IF NOT EXISTS public."UserAccount" (
	"id" SERIAL PRIMARY KEY,
	"username" TEXT,
	"password" TEXT,
	"email" TEXT,
	"allInputValueFiles" TEXT[]
	/* An array of username that can store multiple users */ 
	/* each password will be matched to username in JSONB */ 
	/* each email will be mapped to one username in JSONB */ 
	/* allReports will mappings of the username and the report names ( unique ) */ 
	/* each report is mapped to a unique user */ 
);

CREATE TABLE IF NOT EXISTS public."Bolt" (
	"id" SERIAL PRIMARY KEY,
	"Bolt_diameter"	TEXT
);
INSERT INTO public."Bolt" VALUES(1,'8');
INSERT INTO public."Bolt" VALUES(2,'10');
INSERT INTO public."Bolt" VALUES(3,'12');
INSERT INTO public."Bolt" VALUES(4,'16');
INSERT INTO public."Bolt" VALUES(5,'20');
INSERT INTO public."Bolt" VALUES(6,'24');
INSERT INTO public."Bolt" VALUES(7,'30');
INSERT INTO public."Bolt" VALUES(8,'36');
INSERT INTO public."Bolt" VALUES(9,'42');
INSERT INTO public."Bolt" VALUES(10,'48');
INSERT INTO public."Bolt" VALUES(11,'56');
INSERT INTO public."Bolt" VALUES(12,'64');
INSERT INTO public."Bolt" VALUES(13,'14');
INSERT INTO public."Bolt" VALUES(14,'18');
INSERT INTO public."Bolt" VALUES(15,'22');
INSERT INTO public."Bolt" VALUES(16,'27');
INSERT INTO public."Bolt" VALUES(17,'33');
INSERT INTO public."Bolt" VALUES(18,'39');
INSERT INTO public."Bolt" VALUES(19,'45');
INSERT INTO public."Bolt" VALUES(20,'52');
INSERT INTO public."Bolt" VALUES(21,'60');
CREATE TABLE IF NOT EXISTS public."Anchor_Bolt" (
	"id" SERIAL PRIMARY KEY,
	"Diameter"	TEXT
);
INSERT INTO public."Anchor_Bolt" VALUES(1,'M8');
INSERT INTO public."Anchor_Bolt" VALUES(2,'M10');
INSERT INTO public."Anchor_Bolt" VALUES(3,'M12');
INSERT INTO public."Anchor_Bolt" VALUES(4,'M16');
INSERT INTO public."Anchor_Bolt" VALUES(5,'M20');
INSERT INTO public."Anchor_Bolt" VALUES(6,'M24');
INSERT INTO public."Anchor_Bolt" VALUES(7,'M30');
INSERT INTO public."Anchor_Bolt" VALUES(8,'M36');
INSERT INTO public."Anchor_Bolt" VALUES(9,'M42');
INSERT INTO public."Anchor_Bolt" VALUES(10,'M48');
INSERT INTO public."Anchor_Bolt" VALUES(11,'M56');
INSERT INTO public."Anchor_Bolt" VALUES(12,'M64');
INSERT INTO public."Anchor_Bolt" VALUES(13,'M72');
CREATE TABLE IF NOT EXISTS public."Angle_Pitch" (
	"id" SERIAL PRIMARY KEY,
	"Nominal_Leg"	INTEGER,
	"Max_Bolt_Dia"	INTEGER,
	"Bolt_lines"	INTEGER,
	"S1"	INTEGER,
	"S2"	INTEGER,
	"S3"	INTEGER
);
INSERT INTO public."Angle_Pitch" VALUES(1,50,12,1,28,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(2,60,16,1,35,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(3,65,20,1,35,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(4,70,20,1,40,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(5,75,20,1,45,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(6,80,20,1,45,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(7,90,24,1,50,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(8,100,24,1,55,NULL,NULL);
INSERT INTO public."Angle_Pitch" VALUES(9,120,16,2,45,50,NULL);
INSERT INTO public."Angle_Pitch" VALUES(10,125,20,2,45,50,NULL);
INSERT INTO public."Angle_Pitch" VALUES(11,150,20,2,55,55,NULL);
INSERT INTO public."Angle_Pitch" VALUES(13,200,30,2,75,75,NULL);
INSERT INTO public."Angle_Pitch" VALUES(12,200,20,3,55,55,55);
CREATE TABLE IF NOT EXISTS public."Material" (
	"id" SERIAL PRIMARY KEY,
	"Grade"	TEXT,
	"Yield Stress (< 20)"	INTEGER,
	"Yield Stress (20 -40)"	INTEGER,
	"Yield Stress (> 40)"	INTEGER,
	"Ultimate Tensile Stress"	INTEGER,
	"Elongation "	INTEGER
);
CREATE SEQUENCE custom_materials_id_seq START 100;
CREATE TABLE IF NOT EXISTS public."CustomMaterials" (
	"id" INTEGER PRIMARY KEY DEFAULT nextval('custom_materials_id_seq'),
	"email" TEXT,
	"Grade"	TEXT,
	"Yield Stress (< 20)"	INTEGER,
	"Yield Stress (20 -40)"	INTEGER,
	"Yield Stress (> 40)"	INTEGER,
	"Ultimate Tensile Stress"	INTEGER,
	"Elongation "	INTEGER
);
INSERT INTO public."Material" VALUES(1, 'E 165 (Fe 290)',165,165,165,290,23);
INSERT INTO public."Material" VALUES(2, 'E 250 (Fe 410 W)A',250,240,230,410,23);
INSERT INTO public."Material" VALUES(3, 'E 250 (Fe 410 W)B',250,240,230,410,23);
INSERT INTO public."Material" VALUES(4, 'E 250 (Fe 410 W)C',250,240,230,410,23);
INSERT INTO public."Material" VALUES(5, 'E 300 (Fe 440)',300,290,280,440,22);
INSERT INTO public."Material" VALUES(6, 'E 350 (Fe 490)',350,330,320,490,22);
INSERT INTO public."Material" VALUES(7, 'E 410 (Fe 540)',410,390,380,540,20);
INSERT INTO public."Material" VALUES(8, 'E 450 (Fe 570)D',450,430,420,570,20);
INSERT INTO public."Material" VALUES(9, 'E 450 (Fe 590) E',450,430,420,590,20);
INSERT INTO public."Material" VALUES(10, 'Cus_400_500_600_1400',400,500,600,1400,20);
CREATE TABLE IF NOT EXISTS public."Bolt_fy_fu" (
	"id" SERIAL PRIMARY KEY,
	"Property_Class"	NUMERIC,
	"Diameter_min"	INTEGER,
	"Diameter_max"	INTEGER,
	"fy"	NUMERIC,
	"fu"	NUMERIC
);
INSERT INTO public."Bolt_fy_fu" VALUES(1,4.6,0,100,240,400);
INSERT INTO public."Bolt_fy_fu" VALUES(2,4.8,0,100,340,420);
INSERT INTO public."Bolt_fy_fu" VALUES(3,5.6,0,100,300,500);
INSERT INTO public."Bolt_fy_fu" VALUES(4,5.8,0,100,420,520);
INSERT INTO public."Bolt_fy_fu" VALUES(5,3.6,0,100,190,330);
INSERT INTO public."Bolt_fy_fu" VALUES(6,6.8,0,100,480,600);
INSERT INTO public."Bolt_fy_fu" VALUES(7,8.8,0,16,640,800);
INSERT INTO public."Bolt_fy_fu" VALUES(8,8.8,16,100,660,830);
INSERT INTO public."Bolt_fy_fu" VALUES(9,9.8,0,100,720,900);
INSERT INTO public."Bolt_fy_fu" VALUES(10,10.9,0,100,940,1040);
INSERT INTO public."Bolt_fy_fu" VALUES(11,12.9,0,100,1100,1220);
CREATE TABLE IF NOT EXISTS public."UnequalAngle" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR(50),
	"Mass"	NUMERIC(10 , 2),
	"Area"	NUMERIC(10 , 2),
	"a"	NUMERIC(10 , 2),
	"b"	NUMERIC(10 , 2),
	"t"	NUMERIC(10 , 2),
	"R1"	NUMERIC(10 , 2),
	"R2"	NUMERIC(10 , 2),
	"Cz"	NUMERIC(10 , 2),
	"Cy"	NUMERIC(10 , 2),
	"Iz"	NUMERIC(10 , 2),
	"Iy"	NUMERIC(10 , 2),
	"Alpha"	NUMERIC(10 , 2),
	"Iu_max"	NUMERIC(10 , 2),
	"Iv_min"	NUMERIC(10 , 2),
	"rz"	NUMERIC(10 , 2),
	"ry"	NUMERIC(10 , 2),
	"ru_max"	NUMERIC(10 , 2),
	"rv_min"	NUMERIC(10 , 2),
	"Zz"	NUMERIC(10 , 2),
	"Zy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"Source"	VARCHAR(100),
	"It"	NUMERIC(10 , 2)
);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(1,'∠ 30 ⅹ 20ⅹ 3',1.14,1.45,30.0,20.0,3.0,4.5,0.0,0.51,0.99,1.29,0.46,1.05,1.47,0.27,0.94,0.56,1.01,0.43,0.64,0.31,1.16,0.56,'IS808_Rev',0.042000000000000001776);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(2,'∠ 30 ⅹ 20ⅹ 4',1.48,1.88,30.0,20.0,4.0,4.5,0.0,0.55,1.04,1.63,0.57,0.4,1.85,0.34,0.93,0.55,0.99,0.43,0.83,0.39,1.48,0.73,'IS808_Rev',0.098000000000000024868);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(3,'∠ 30 ⅹ 20ⅹ 5',1.8,2.29,30.0,20.0,5.0,4.5,0.0,0.58,1.07,1.93,0.67,0.39,2.19,0.41,0.92,0.54,0.98,0.42,1.0,0.47,1.79,0.9,'IS808_Rev',0.18700000000000001065);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(4,'∠ 40 ⅹ 25ⅹ 3',1.5,1.91,40.0,25.0,3.0,5.0,0.0,0.59,1.32,3.11,0.94,0.37,3.48,0.57,1.27,0.7,1.35,0.54,1.16,0.49,2.08,0.9,'IS808_Rev',0.055);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(5,'∠ 40 ⅹ 25ⅹ 4',1.96,2.49,40.0,25.0,4.0,5.0,0.0,0.63,1.36,3.97,1.19,0.36,4.44,0.72,1.26,0.69,1.33,0.54,1.5,0.64,2.69,1.18,'IS808_Rev',0.13);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(6,'∠ 40 ⅹ 25ⅹ 5',2.4,3.05,40.0,25.0,5.0,5.0,0.0,0.67,1.4,4.76,1.42,0.36,5.31,0.87,1.25,0.68,1.32,0.53,1.83,0.77,3.27,1.45,'IS808_Rev',0.25);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(7,'∠ 40 ⅹ 25ⅹ 6',2.82,3.59,40.0,25.0,6.0,5.0,0.0,0.7,1.44,5.5,1.62,0.35,6.1,1.02,1.24,0.67,1.3,0.53,2.15,0.9,3.81,1.72,'IS808_Rev',0.42400000000000002131);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(8,'∠ 45 ⅹ 30ⅹ 3',1.74,2.21,45.0,30.0,3.0,5.0,0.0,0.71,1.44,4.57,1.65,0.41,5.26,0.96,1.44,0.86,1.54,0.66,1.49,0.72,2.7,1.29,'IS808_Rev',0.064000000000000003552);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(9,'∠ 45 ⅹ 30ⅹ 4',2.27,2.89,45.0,30.0,4.0,5.0,0.0,0.74,1.48,5.87,2.1,0.41,6.75,1.22,1.42,0.85,1.53,0.65,1.95,0.93,3.5,1.69,'IS808_Rev',0.15099999999999999644);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(10,'∠ 45 ⅹ 30ⅹ 5',2.79,3.55,45.0,30.0,5.0,5.0,0.0,0.78,1.52,7.08,2.51,0.4,8.11,1.48,1.41,0.84,1.51,0.64,2.38,1.13,4.27,2.08,'IS808_Rev',0.29099999999999997868);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(11,'∠ 45 ⅹ 30ⅹ 6',3.29,4.19,45.0,30.0,6.0,5.0,0.0,0.82,1.56,8.21,2.89,0.4,9.37,1.73,1.4,0.83,1.49,0.64,2.79,1.32,5.0,2.46,'IS808_Rev',0.49599999999999999644);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(12,'∠ 50 ⅹ30ⅹ 3',1.86,2.37,50.0,30.0,3.0,5.5,0.0,0.67,1.64,6.13,1.69,0.35,6.79,1.03,1.61,0.84,1.69,0.66,1.83,0.73,3.28,1.31,'IS808_Rev',0.069000000000000003552);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(13,'∠ 50 ⅹ30ⅹ 4',2.44,3.1,50.0,30.0,4.0,5.5,0.0,0.71,1.69,7.89,2.15,0.34,8.73,1.32,1.59,0.83,1.68,0.65,2.38,0.94,4.26,1.72,'IS808_Rev',0.16200000000000001065);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(14,'∠ 50 ⅹ30ⅹ 5',2.99,3.81,50.0,30.0,5.0,5.5,0.0,0.75,1.73,9.53,2.58,0.34,10.5,1.59,1.58,0.82,1.66,0.65,2.92,1.15,5.19,2.13,'IS808_Rev',0.31200000000000001065);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(15,'∠ 50 ⅹ30ⅹ 6',3.54,4.5,50.0,30.0,6.0,5.5,0.0,0.79,1.77,11.1,2.97,0.33,12.2,1.86,1.57,0.81,1.64,0.64,3.43,1.34,6.09,2.52,'IS808_Rev',0.53200000000000002842);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(16,'∠ 60ⅹ 40ⅹ 5',3.79,4.83,60.0,40.0,5.0,6.0,0.0,0.98,1.97,17.5,6.28,0.41,20.2,3.65,1.91,1.14,2.04,0.87,4.35,2.08,7.83,3.77,'IS808_Rev',0.39500000000000001776);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(17,'∠ 60ⅹ 40ⅹ 6',4.49,5.72,60.0,40.0,6.0,6.0,0.0,1.02,2.01,20.5,7.29,0.41,23.5,4.26,1.89,1.13,2.03,0.86,5.13,2.45,9.21,4.47,'IS808_Rev',0.67600000000000015631);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(18,'∠ 60ⅹ 40ⅹ 8',5.84,7.44,60.0,40.0,8.0,6.0,0.0,1.09,2.08,25.9,9.12,0.4,29.6,5.45,1.87,1.11,1.99,0.86,6.62,3.14,11.8,5.83,'IS808_Rev',1.57);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(19,'∠ 65 ⅹ45ⅹ 5',4.18,5.33,65.0,45.0,5.0,6.0,0.0,1.1,2.09,22.8,9.02,0.44,26.7,5.12,2.07,1.3,2.24,0.98,5.16,2.65,9.33,4.77,'IS808_Rev',0.43700000000000001065);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(20,'∠ 65 ⅹ45ⅹ 6',4.96,6.32,65.0,45.0,6.0,6.0,0.0,1.14,2.13,26.7,10.5,0.44,31.2,5.99,2.06,1.29,2.22,0.97,6.1,3.12,11.0,5.66,'IS808_Rev',0.74800000000000004263);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(21,'∠ 65 ⅹ45ⅹ 8',6.47,8.24,65.0,45.0,8.0,6.0,0.0,1.21,2.2,33.9,13.2,0.43,39.5,7.66,2.03,1.27,2.19,0.96,7.89,4.02,14.1,7.39,'IS808_Rev',1.74);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(22,'∠ 70 ⅹ45ⅹ 5',4.39,5.59,70.0,45.0,5.0,6.5,0.0,1.06,2.29,28.0,9.2,0.39,31.8,5.42,2.24,1.28,2.39,0.98,5.95,2.68,10.7,4.82,'IS808_Rev',0.4580000000000000071);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(23,'∠ 70 ⅹ45ⅹ 6',5.21,6.63,70.0,45.0,6.0,6.5,0.0,1.1,2.33,32.8,10.7,0.39,37.2,6.34,2.23,1.27,2.37,0.98,7.04,3.15,12.6,5.72,'IS808_Rev',0.78399999999999998578);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(24,'∠ 70 ⅹ45ⅹ 8',6.79,8.65,70.0,45.0,8.0,6.5,0.0,1.18,2.41,41.8,13.5,0.38,47.2,8.1,2.2,1.25,2.34,0.97,9.12,4.06,16.3,7.5,'IS808_Rev',1.82);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(25,'∠ 70 ⅹ45ⅹ 10',8.31,10.5,70.0,45.0,10.0,6.5,0.0,1.25,2.49,50.0,16.0,0.37,56.2,9.81,2.17,1.23,2.3,0.96,11.0,4.91,19.7,9.22,'IS808_Rev',3.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(26,'∠ 75 ⅹ 50ⅹ 5',4.78,6.09,75.0,50.0,5.0,6.5,0.0,1.18,2.41,35.1,12.7,0.41,40.5,7.32,2.4,1.44,2.58,1.1,6.9,3.32,12.4,5.95,'IS808_Rev',0.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(27,'∠ 75 ⅹ 50ⅹ 6',5.68,7.23,75.0,50.0,6.0,6.5,0.0,1.22,2.45,41.2,14.8,0.41,47.5,8.57,2.39,1.43,2.56,1.09,8.17,3.92,14.7,7.07,'IS808_Rev',0.85600000000000004973);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(28,'∠ 75 ⅹ 50ⅹ 8',7.42,9.45,75.0,50.0,8.0,6.5,0.0,1.29,2.53,52.7,18.7,0.41,60.5,10.9,2.36,1.41,2.53,1.08,10.6,5.05,19.0,9.25,'IS808_Rev',1.99);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(29,'∠ 75 ⅹ 50ⅹ 10',9.1,11.5,75.0,50.0,10.0,6.5,0.0,1.37,2.61,63.2,22.3,0.4,72.2,13.3,2.34,1.39,2.5,1.07,12.9,6.13,23.1,11.3,'IS808_Rev',3.83);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(30,'∠ 80ⅹ  50ⅹ 5',4.99,6.36,80.0,50.0,5.0,7.0,0.0,1.14,2.62,42.0,12.9,0.37,47.3,7.68,2.57,1.43,2.73,1.1,7.81,3.34,14.0,5.99,'IS808_Rev',0.52);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(31,'∠ 80ⅹ  50ⅹ 6',5.92,7.55,80.0,50.0,6.0,7.0,0.0,1.18,2.66,49.4,15.1,0.37,55.5,8.99,2.56,1.41,2.71,1.09,9.25,3.95,16.5,7.13,'IS808_Rev',0.89199999999999999289);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(32,'∠ 80ⅹ  50ⅹ 8',7.74,9.87,80.0,50.0,8.0,7.0,0.0,1.26,2.74,63.2,19.1,0.37,70.8,11.5,2.53,1.39,2.68,1.08,12.0,5.09,21.4,9.36,'IS808_Rev',2.08);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(33,'∠ 80ⅹ  50ⅹ 10',9.5,12.1,80.0,50.0,10.0,7.0,0.0,1.33,2.82,76.0,22.7,0.36,84.7,13.9,2.5,1.37,2.65,1.07,14.6,6.18,26.0,11.5,'IS808_Rev',4.0);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(34,'∠ 90 ⅹ 60ⅹ 6',6.88,8.76,90.0,60.0,6.0,7.5,0.0,1.42,2.9,72.8,26.3,0.41,84.0,15.2,2.88,1.73,3.1,1.32,11.9,5.74,21.5,10.2,'IS808_Rev',1.03);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(35,'∠ 90 ⅹ 60ⅹ 8',9.01,11.4,90.0,60.0,8.0,7.5,0.0,1.49,2.98,93.6,33.5,0.41,107.0,19.5,2.86,1.71,3.06,1.3,15.5,7.44,27.9,13.4,'IS808_Rev',2.42);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(36,'∠ 90 ⅹ 60ⅹ 10',11.08,14.1,90.0,60.0,10.0,7.5,0.0,1.57,3.06,113.0,40.1,0.41,129.0,23.6,2.83,1.69,3.03,1.29,19.0,9.05,34.1,16.6,'IS808_Rev',4.66);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(37,'∠ 90 ⅹ 60ⅹ 12',13.09,16.6,90.0,60.0,12.0,7.5,0.0,1.64,3.13,131.0,46.2,0.4,149.0,27.6,2.8,1.66,3.0,1.29,22.3,10.6,39.9,19.7,'IS808_Rev',7.94);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(38,'∠100 ⅹ 65ⅹ 6',7.6,9.68,100.0,65.0,6.0,8.0,0.0,1.5,3.22,100.0,34.0,0.4,114.0,19.8,3.22,1.88,3.44,1.43,14.8,6.8,26.6,12.1,'IS808_Rev',1.14);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(39,'∠100 ⅹ 65ⅹ 8',9.97,12.7,100.0,65.0,8.0,8.0,0.0,1.57,3.3,129.0,43.5,0.4,147.0,25.5,3.19,1.85,3.4,1.42,19.3,8.8,34.6,15.9,'IS808_Rev',2.67);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(40,'∠100 ⅹ 65ⅹ 10',12.28,15.6,100.0,65.0,10.0,8.0,0.0,1.65,3.38,156.0,52.2,0.39,177.0,30.9,3.16,1.83,3.37,1.4,23.6,10.8,42.3,19.7,'IS808_Rev',5.16);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(41,'∠100 ⅹ 75ⅹ 6',8.08,10.3,100.0,75.0,6.0,8.5,0.0,1.82,3.05,105.0,51.2,0.5,128.0,27.6,3.19,2.23,3.54,1.64,15.1,9.0,27.4,16.0,'IS808_Rev',1.21);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(42,'∠100 ⅹ 75ⅹ 8',10.61,13.5,100.0,75.0,8.0,8.5,0.0,1.89,3.13,135.0,65.7,0.5,165.0,35.5,3.17,2.21,3.5,1.62,19.7,11.7,35.8,21.0,'IS808_Rev',2.85);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(43,'∠100 ⅹ 75ⅹ 10',13.07,16.6,100.0,75.0,10.0,8.5,0.0,1.97,3.21,164.0,79.2,0.5,200.0,43.0,3.14,2.18,3.47,1.61,24.2,14.3,43.8,25.9,'IS808_Rev',5.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(44,'∠100 ⅹ 75ⅹ 12',15.48,19.7,100.0,75.0,12.0,8.5,0.0,2.04,3.28,191.0,91.7,0.5,232.0,50.4,3.11,2.16,3.43,1.6,28.5,16.8,51.4,30.6,'IS808_Rev',9.38);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(45,'∠ 125 ⅹ 75ⅹ 6',9.27,11.8,125.0,75.0,6.0,9.0,0.0,1.62,4.08,194.0,54.3,0.35,215.0,32.7,4.05,2.14,4.27,1.66,23.1,9.2,41.3,16.4,'IS808_Rev',1.39);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(46,'∠ 125 ⅹ 75ⅹ 8',12.19,15.5,125.0,75.0,8.0,9.0,0.0,1.7,4.17,251.0,69.7,0.35,279.0,42.1,4.03,2.12,4.24,1.65,30.2,12.0,53.9,21.6,'IS808_Rev',3.27);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(47,'∠ 125 ⅹ 75ⅹ 10',15.05,19.1,125.0,75.0,10.0,9.0,0.0,1.78,4.26,306.0,84.1,0.35,339.0,51.0,4.0,2.09,4.21,1.63,37.2,14.7,66.2,26.7,'IS808_Rev',6.33);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(48,'∠125 ⅹ 95 ⅹ 6',10.14,12.9,125.0,95.0,6.0,9.0,4.8,2.24,3.72,205.0,103.0,0.52,254.0,55.0,3.99,2.83,4.44,2.06,23.4,14.3,42.9,25.5,'IS808_Rev',1.54);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(49,'∠125 ⅹ 95ⅹ 8',13.37,17.0,125.0,95.0,8.0,9.0,4.8,2.32,3.8,268.0,134.0,0.52,331.0,71.4,3.97,2.81,4.41,2.05,30.9,18.8,56.4,33.7,'IS808_Rev',3.61);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(50,'∠125 ⅹ 95ⅹ 10',16.54,21.0,125.0,95.0,10.0,9.0,4.8,2.4,3.89,328.0,164.0,0.51,404.0,87.3,3.94,2.79,4.38,2.04,38.1,23.1,69.4,41.7,'IS808_Rev',7.0);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(51,'∠125 ⅹ 95ⅹ 12',19.65,25.0,125.0,95.0,12.0,9.0,4.8,2.48,3.97,384.0,191.0,0.51,473.0,102.0,3.92,2.77,4.35,2.02,45.1,27.3,82.0,49.5,'IS808_Rev',11.9);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(52,'∠150 ⅹ 115ⅹ 8',16.27,20.7,150.0,115.0,8.0,11.0,4.8,2.76,4.48,474.0,244.0,0.52,589.0,128.0,4.78,3.43,5.34,2.49,45.1,27.9,82.4,50.0,'IS808_Rev',4.38);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(53,'∠150 ⅹ 115ⅹ 10',20.14,25.6,150.0,115.0,10.0,11.0,4.8,2.84,4.57,581.0,298.0,0.52,722.0,157.0,4.76,3.41,5.31,2.48,55.8,34.5,101.0,61.9,'IS808_Rev',8.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(54,'∠150 ⅹ 115ⅹ 12',23.96,30.5,150.0,115.0,12.0,11.0,4.8,2.92,4.65,684.0,350.0,0.52,849.0,185.0,4.74,3.39,5.28,2.47,66.2,40.8,120.0,73.5,'IS808_Rev',14.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(55,'∠150 ⅹ 115ⅹ 16',31.4,40.0,150.0,115.0,16.0,11.0,4.8,3.07,4.81,878.0,446.0,0.52,1080.0,239.0,4.69,3.34,5.21,2.44,86.2,53.0,156.0,96.1,'IS808_Rev',33.9);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(56,'∠200ⅹ 100ⅹ 10',22.93,29.2,200.0,100.0,10.0,12.0,4.8,2.03,6.98,1220.0,214.0,0.26,1300.0,137.0,6.48,2.71,6.68,2.17,94.3,26.9,165.0,48.7,'IS808_Rev',9.66);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(57,'∠200ⅹ 100ⅹ 12',27.29,34.7,200.0,100.0,12.0,12.0,4.8,2.11,7.07,1440.0,251.0,0.26,1530.0,161.0,6.46,2.69,6.65,2.15,112.0,31.9,196.0,58.3,'IS808_Rev',16.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(58,'∠200ⅹ 100ⅹ 16',35.84,45.6,200.0,100.0,16.0,12.0,4.8,2.27,7.23,1870.0,319.0,0.25,1980.0,207.0,6.4,2.65,6.59,2.13,146.0,41.3,255.0,77.5,'IS808_Rev',38.7);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(59,'∠200ⅹ 150ⅹ 10',26.92,34.2,200.0,150.0,10.0,13.5,4.8,3.55,6.02,1400.0,688.0,0.51,1720.0,368.0,6.41,4.48,7.1,3.28,100.0,60.2,183.0,107.0,'IS808_Rev',11.3);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(60,'∠200ⅹ 150ⅹ 12',32.07,40.8,200.0,150.0,12.0,13.5,4.8,3.63,6.11,1660.0,812.0,0.51,2040.0,433.0,6.39,4.46,7.07,3.26,119.0,71.4,218.0,127.0,'IS808_Rev',19.4);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(61,'∠200ⅹ 150ⅹ 16',42.18,53.7,200.0,150.0,16.0,13.5,4.8,3.79,6.27,2150.0,1040.0,0.5,2630.0,560.0,6.33,4.41,7.01,3.23,156.0,93.2,285.0,167.0,'IS808_Rev',45.6);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(62,'∠200ⅹ 150ⅹ 20',52.04,66.2,200.0,150.0,20.0,13.5,4.8,3.94,6.42,2610.0,1260.0,0.5,3190.0,682.0,6.28,4.36,6.94,3.21,192.0,114.0,349.0,206.0,'IS808_Rev',88.0);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(63,'∠ 40 ⅹ20ⅹ3',1.37,1.74,40.0,20.0,3.0,4.0,0.0,0.45,1.43,2.9,0.49,0.25,3.04,0.32,1.28,0.53,1.32,0.43,1.11,0.32,1.95,0.59,'IS808_Rev',0.050999999999999996447);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(64,'∠ 40 ⅹ20ⅹ4',1.79,2.27,40.0,20.0,4.0,4.0,0.0,0.49,1.47,3.7,0.62,0.25,3.86,0.41,1.27,0.52,1.3,0.42,1.45,0.41,2.52,0.78,'IS808_Rev',0.11899999999999999467);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(65,'∠ 40 ⅹ20ⅹ5',2.19,2.78,40.0,20.0,5.0,4.0,0.0,0.52,1.51,4.4,0.73,0.24,4.62,0.49,1.25,0.51,1.29,0.42,1.76,0.49,3.05,0.97,'IS808_Rev',0.22900000000000000355);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(66,'∠ 60 ⅹ30ⅹ5',3.4,4.33,60.0,30.0,5.0,6.0,0.0,0.69,2.16,15.9,2.7,0.25,16.8,1.76,1.92,0.79,1.97,0.64,4.14,1.17,7.24,2.21,'IS808_Rev',0.35400000000000000355);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(67,'∠ 60 ⅹ30ⅹ6',4.02,5.12,60.0,30.0,6.0,6.0,0.0,0.73,2.21,18.5,3.11,0.25,19.6,2.06,1.9,0.78,1.96,0.63,4.88,1.37,8.5,2.64,'IS808_Rev',0.60400000000000000355);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(68,'∠ 60 ⅹ40ⅹ7',5.17,6.59,60.0,40.0,7.0,6.0,0.0,1.06,2.05,23.3,8.23,0.4,26.6,4.86,1.88,1.12,2.01,0.86,5.89,2.8,10.5,5.16,'IS808_Rev',1.06);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(69,' ∠65 ⅹ50ⅹ5',4.38,5.58,65.0,50.0,5.0,6.0,0.0,1.26,2.0,23.6,12.2,0.52,29.3,6.48,2.06,1.48,2.29,1.08,5.25,3.27,9.53,5.85,'IS808_Rev',0.4580000000000000071);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(70,'∠65 ⅹ50ⅹ6',5.19,6.62,65.0,50.0,6.0,6.0,0.0,1.3,2.04,27.6,14.2,0.52,34.3,7.59,2.04,1.47,2.28,1.07,6.2,3.85,11.2,6.93,'IS808_Rev',0.78399999999999998578);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(71,'∠65 ⅹ50ⅹ7',6.0,7.64,65.0,50.0,7.0,6.0,0.0,1.34,2.08,31.5,16.2,0.52,39.0,8.67,2.03,1.45,2.26,1.07,7.13,4.42,12.9,7.99,'IS808_Rev',1.23);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(72,'∠65 ⅹ50ⅹ8',6.78,8.64,65.0,50.0,8.0,6.0,0.0,1.38,2.12,35.2,18.0,0.52,43.4,9.72,2.02,1.44,2.24,1.06,8.03,4.97,14.5,9.03,'IS808_Rev',1.82);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(73,'∠ 70ⅹ 50ⅹ5',4.57,5.83,70.0,50.0,5.0,6.0,0.0,1.22,2.21,29.0,12.5,0.46,34.5,6.92,2.23,1.46,2.43,1.09,6.05,3.3,10.9,5.9,'IS808_Rev',0.47900000000000000355);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(74,'∠ 70ⅹ 50ⅹ6',5.43,6.92,70.0,50.0,6.0,6.0,0.0,1.26,2.25,34.0,14.5,0.46,40.4,8.11,2.22,1.45,2.42,1.08,7.16,3.89,12.9,7.0,'IS808_Rev',0.82);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(75,'∠ 70ⅹ 50ⅹ7',6.27,7.99,70.0,50.0,7.0,6.0,0.0,1.3,2.29,38.8,16.5,0.46,46.0,9.26,2.2,1.44,2.4,1.08,8.23,4.46,14.8,8.08,'IS808_Rev',1.29);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(76,'∠ 70ⅹ 50ⅹ8',7.09,9.04,70.0,50.0,8.0,6.0,0.0,1.33,2.33,43.4,18.4,0.46,51.4,10.3,2.19,1.43,2.38,1.07,9.28,5.01,16.7,9.14,'IS808_Rev',1.91);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(77,'∠75 ⅹ50ⅹ7',6.57,8.37,75.0,50.0,7.0,7.0,0.0,1.26,2.49,47.1,16.8,0.41,54.2,9.8,2.37,1.42,2.54,1.08,9.41,4.49,16.9,8.17,'IS808_Rev',1.34);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(78,'∠80 ⅹ40ⅹ5',4.6,5.86,80.0,40.0,5.0,7.0,0.0,0.86,2.82,39.0,6.74,0.26,41.4,4.36,2.58,1.07,2.66,0.86,7.53,2.14,13.1,3.94,'IS808_Rev',0.47900000000000000355);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(79,'∠80 ⅹ40ⅹ6',5.45,6.95,80.0,40.0,6.0,7.0,0.0,0.89,2.86,45.7,7.84,0.25,48.5,5.09,2.57,1.06,2.64,0.86,8.9,2.52,15.5,4.7,'IS808_Rev',0.82);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(80,'∠80 ⅹ40ⅹ7',6.29,8.02,80.0,40.0,7.0,7.0,0.0,0.93,2.91,52.2,8.87,0.25,55.3,5.8,2.55,1.05,2.63,0.85,10.2,2.89,17.8,5.47,'IS808_Rev',1.29);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(81,'∠80 ⅹ40ⅹ8',7.12,9.07,80.0,40.0,8.0,7.0,0.0,0.97,2.95,58.4,9.84,0.25,61.7,6.5,2.54,1.04,2.61,0.85,11.5,3.25,20.1,6.24,'IS808_Rev',1.91);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(82,'∠ 80ⅹ 60ⅹ6',6.42,8.18,80.0,60.0,6.0,8.0,0.0,1.5,2.48,52.6,25.5,0.5,64.3,13.8,2.54,1.77,2.8,1.3,9.5,5.7,17.3,10.1,'IS808_Rev',0.96400000000000005684);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(83,'∠ 80ⅹ 60ⅹ7',7.42,9.45,80.0,60.0,7.0,8.0,0.0,1.54,2.52,60.1,29.1,0.5,73.4,15.8,2.52,1.75,2.79,1.29,11.0,6.5,19.9,11.7,'IS808_Rev',1.52);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(84,'∠ 80ⅹ 60ⅹ8',8.4,10.7,80.0,60.0,8.0,8.0,0.0,1.57,2.56,67.4,32.5,0.5,82.2,17.7,2.51,1.74,2.77,1.29,12.4,7.3,22.4,13.3,'IS808_Rev',2.25);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(85,'∠ 90ⅹ 65 ⅹ 6',7.13,9.08,90.0,65.0,6.0,8.0,0.0,1.57,2.81,74.8,33.1,0.47,89.7,18.3,2.87,1.91,3.14,1.42,12.1,6.7,21.9,12.0,'IS808_Rev',1.07);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(86,'∠ 90ⅹ 65 ⅹ7',8.24,10.5,90.0,65.0,7.0,8.0,0.0,1.61,2.85,85.7,37.8,0.47,102.0,20.9,2.86,1.9,3.13,1.41,13.9,7.7,25.2,13.9,'IS808_Rev',1.69);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(87,'∠ 90ⅹ 65 ⅹ8',9.34,11.9,90.0,65.0,8.0,8.0,0.0,1.65,2.89,96.3,42.3,0.47,115.0,23.5,2.84,1.89,3.11,1.4,15.8,8.7,28.5,15.7,'IS808_Rev',2.5);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(88,'∠ 90ⅹ 65 ⅹ10',11.49,14.6,90.0,65.0,10.0,8.0,0.0,1.73,2.97,116.0,50.7,0.47,138.0,28.4,2.82,1.86,3.08,1.39,19.3,10.6,34.8,19.3,'IS808_Rev',4.83);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(89,'∠100 ⅹ50 ⅹ 6',6.92,8.81,100.0,50.0,6.0,9.0,0.0,1.06,3.51,91.9,15.9,0.26,97.5,10.3,3.23,1.34,3.33,1.08,14.2,4.0,24.8,7.4,'IS808_Rev',1.03);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(90,'∠100 ⅹ50 ⅹ 7',7.99,10.1,100.0,50.0,7.0,9.0,0.0,1.1,3.56,105.0,18.1,0.26,111.0,11.7,3.21,1.33,3.31,1.07,16.3,4.6,28.6,8.6,'IS808_Rev',1.63);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(91,'∠100 ⅹ50 ⅹ 8',9.05,11.5,100.0,50.0,8.0,9.0,0.0,1.14,3.6,118.0,20.2,0.25,125.0,13.1,3.2,1.32,3.29,1.07,18.5,5.2,32.2,9.8,'IS808_Rev',2.42);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(92,'∠100 ⅹ50 ⅹ10',11.13,14.1,100.0,50.0,10.0,9.0,0.0,1.21,3.68,142.0,24.0,0.25,150.0,15.9,3.17,1.3,3.26,1.06,22.6,6.3,39.3,12.2,'IS808_Rev',4.66);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(93,'∠100 ⅹ65 ⅹ7',8.85,11.2,100.0,65.0,7.0,10.0,0.0,1.53,3.25,115.0,38.9,0.4,131.0,22.8,3.2,1.86,3.41,1.42,17.1,7.8,30.7,14.1,'IS808_Rev',1.8);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(94,'∠120ⅹ80 ⅹ8',12.26,15.6,120.0,80.0,8.0,11.0,0.0,1.89,3.85,230.0,83.2,0.41,265.0,48.1,3.84,2.31,4.12,1.75,28.3,13.6,51.0,24.4,'IS808_Rev',3.27);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(95,'∠120ⅹ80 ⅹ10',15.12,19.2,120.0,80.0,10.0,11.0,0.0,1.96,3.94,280.0,100.0,0.41,322.0,58.3,3.81,2.28,4.09,1.74,34.8,16.6,62.6,30.1,'IS808_Rev',6.33);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(96,'∠120ⅹ80 ⅹ12',17.91,22.8,120.0,80.0,12.0,11.0,0.0,2.04,4.02,327.0,116.0,0.41,375.0,68.1,3.79,2.26,4.06,1.73,41.0,19.6,73.7,35.7,'IS808_Rev',10.8);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(97,'∠125ⅹ75 ⅹ12',17.91,22.8,125.0,75.0,12.0,11.0,0.0,1.85,4.32,358.0,97.5,0.34,396.0,59.8,3.97,2.07,4.17,1.62,43.9,17.3,78.1,31.8,'IS808_Rev',10.8);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(98,'∠135ⅹ65 ⅹ8',12.18,15.5,135.0,65.0,8.0,11.0,4.8,1.35,4.79,292.0,45.5,0.24,308.0,29.7,4.34,1.71,4.46,1.38,33.6,8.8,59.0,16.4,'IS808_Rev',3.27);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(99,'∠135ⅹ65 ⅹ10',15.04,19.1,135.0,65.0,10.0,11.0,4.8,1.43,4.88,357.0,55.0,0.24,376.0,36.1,4.32,1.69,4.43,1.37,41.4,10.8,72.5,20.5,'IS808_Rev',6.33);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(100,'∠135ⅹ65 ⅹ12',17.84,22.7,135.0,65.0,12.0,11.0,4.8,1.51,4.97,418.0,63.9,0.24,440.0,42.3,4.29,1.68,4.4,1.36,49.0,12.8,85.4,24.6,'IS808_Rev',10.8);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(101,'∠150ⅹ75 ⅹ9',15.39,19.6,150.0,75.0,9.0,11.0,4.8,1.58,5.28,457.0,78.8,0.26,485.0,50.7,4.83,2.01,4.98,1.61,47.1,13.3,82.8,24.5,'IS808_Rev',5.24);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(102,'∠150ⅹ75 ⅹ15',24.85,31.6,150.0,75.0,15.0,11.0,4.8,1.81,5.53,715.0,120.0,0.25,755.0,79.1,4.75,1.95,4.89,1.58,75.5,21.1,131.0,40.7,'IS808_Rev',23.6);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(103,'∠150ⅹ90ⅹ10',18.22,23.2,150.0,90.0,10.0,12.0,4.8,2.04,5.0,536.0,147.0,0.35,594.0,89.1,4.81,2.52,5.06,1.96,53.6,21.2,96.2,38.4,'IS808_Rev',7.66);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(104,'∠150ⅹ90ⅹ12',21.64,27.5,150.0,90.0,12.0,12.0,4.8,2.12,5.09,630.0,172.0,0.34,698.0,104.0,4.78,2.5,5.03,1.95,63.6,25.0,113.0,45.8,'IS808_Rev',13.1);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(105,'∠150ⅹ90ⅹ15',26.66,33.9,150.0,90.0,15.0,12.0,4.8,2.24,5.21,764.0,206.0,0.34,843.0,126.0,4.74,2.47,4.98,1.93,78.0,30.6,139.0,56.7,'IS808_Rev',25.3);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(106,'∠200ⅹ100ⅹ15',33.86,43.1,200.0,100.0,15.0,15.0,4.8,2.23,7.17,1770.0,303.0,0.25,1870.0,196.0,6.41,2.65,6.6,2.13,138.0,39.0,241.0,72.9,'IS808_Rev',32.0);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(107,'∠200ⅹ150ⅹ15',39.75,50.6,200.0,150.0,15.0,15.0,4.8,3.75,6.22,2030.0,988.0,0.5,2490.0,530.0,6.34,4.42,7.02,3.24,147.0,87.8,268.0,157.0,'IS808_Rev',37.6);
INSERT INTO public."UnequalAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(108,'∠200ⅹ150ⅹ18',47.21,60.1,200.0,150.0,18.0,15.0,4.8,3.86,6.34,2390.0,1150.0,0.5,2920.0,623.0,6.3,4.38,6.97,3.22,175.0,103.0,317.0,187.0,'IS808_Rev',64.5);

CREATE TABLE IF NOT EXISTS public."EqualAngle"(
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR(50),
	"Mass"	NUMERIC(10 , 2),
	"Area"	NUMERIC(10 , 2),
	"a"	NUMERIC(10 , 2),
	"b"	NUMERIC(10 , 2),
	"t"	NUMERIC(10 , 2),
	"R1"	NUMERIC(10 , 2),
	"R2"	NUMERIC(10 , 2),
	"Cz"	NUMERIC(10 , 2),
	"Cy"	NUMERIC(10 , 2),
	"Iz"	NUMERIC(10 , 2),
	"Iy"	NUMERIC(10 , 2),
	"Alpha"	NUMERIC(10 , 2),
	"Iu_max"	NUMERIC(10 , 2),
	"Iv_min"	NUMERIC(10 , 2),
	"rz"	NUMERIC(10 , 2),
	"ry"	NUMERIC(10 , 2),
	"ru_max"	NUMERIC(10 , 2),
	"rv_min"	NUMERIC(10 , 2),
	"Zz"	NUMERIC(10 , 2),
	"Zy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"Source"	VARCHAR(50),
	"It"	NUMERIC(10 , 2) 
);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(1,'∠ 20ⅹ 20ⅹ 3',0.9,1.14,20.0,20.0,3.0,4.0,0.0,0.6,0.6,0.4,0.4,0.79,0.64,0.17,0.59,0.59,0.75,0.39,0.29,0.29,0.52,0.53,'IS808_Rev',0.033000000000000007105);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(2,'∠ 20ⅹ 20ⅹ 4',1.16,1.47,20.0,20.0,4.0,4.0,0.0,0.64,0.64,0.5,0.5,0.79,0.79,0.22,0.58,0.58,0.73,0.39,0.37,0.37,0.66,0.67,'IS808_Rev',0.075999999999999996447);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(3,'∠ 25ⅹ 25ⅹ 3',1.14,1.45,25.0,25.0,3.0,4.5,0.0,0.73,0.73,0.83,0.83,0.79,1.3,0.35,0.75,0.75,0.95,0.49,0.46,0.46,0.83,0.84,'IS808_Rev',0.042000000000000001776);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(4,'∠ 25ⅹ 25ⅹ 4',1.48,1.88,25.0,25.0,4.0,4.5,0.0,0.76,0.76,1.04,1.04,0.79,1.63,0.44,0.74,0.74,0.93,0.48,0.6,0.6,1.07,1.09,'IS808_Rev',0.098000000000000024868);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(5,'∠ 25ⅹ 25ⅹ 5',1.8,2.29,25.0,25.0,5.0,4.5,0.0,0.8,0.8,1.23,1.23,0.79,1.92,0.54,0.73,0.73,0.92,0.48,0.72,0.72,1.3,1.31,'IS808_Rev',0.18700000000000001065);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(6,'∠ 30ⅹ 30ⅹ 3',1.38,1.76,30.0,30.0,3.0,5.0,0.0,0.85,0.85,1.47,1.47,0.79,2.32,0.62,0.91,0.91,1.15,0.59,0.68,0.68,1.22,1.23,'IS808_Rev',0.050999999999999996447);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(7,'∠ 30ⅹ 30ⅹ 4',1.8,2.29,30.0,30.0,4.0,5.0,0.0,0.89,0.89,1.86,1.86,0.79,2.94,0.78,0.9,0.9,1.13,0.58,0.88,0.88,1.58,1.6,'IS808_Rev',0.11899999999999999467);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(8,'∠ 30ⅹ 30ⅹ 5',2.2,2.8,30.0,30.0,5.0,5.0,0.0,0.93,0.93,2.22,2.22,0.79,3.49,0.95,0.89,0.89,1.12,0.58,1.07,1.07,1.92,1.94,'IS808_Rev',0.22900000000000000355);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(9,'∠ 35ⅹ 35ⅹ 3',1.62,2.06,35.0,35.0,3.0,5.0,0.0,0.97,0.97,2.38,2.38,0.79,3.77,0.99,1.07,1.07,1.35,0.69,0.94,0.94,1.69,1.7,'IS808_Rev',0.06);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(10,'∠ 35ⅹ 35ⅹ 4',2.11,2.69,35.0,35.0,4.0,5.0,0.0,1.01,1.01,3.04,3.04,0.79,4.81,1.27,1.06,1.06,1.34,0.69,1.22,1.22,2.19,2.21,'IS808_Rev',0.14);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(11,'∠ 35ⅹ 35ⅹ 5',2.59,3.3,35.0,35.0,5.0,5.0,0.0,1.05,1.05,3.65,3.65,0.79,5.76,1.54,1.05,1.05,1.32,0.68,1.49,1.49,2.68,2.69,'IS808_Rev',0.27);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(12,'∠ 35ⅹ 35ⅹ 6',3.06,3.89,35.0,35.0,6.0,5.0,0.0,1.09,1.09,4.2,4.2,0.79,6.61,1.8,1.04,1.04,1.3,0.68,1.74,1.74,3.14,3.15,'IS808_Rev',0.46);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(13,'∠ 40ⅹ 40ⅹ 3',1.86,2.37,40.0,40.0,3.0,5.5,0.0,1.09,1.09,3.61,3.61,0.79,5.72,1.51,1.23,1.23,1.55,0.8,1.24,1.24,2.22,2.24,'IS808_Rev',0.069000000000000003552);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(14,'∠ 40ⅹ 40ⅹ 4',2.44,3.1,40.0,40.0,4.0,5.5,0.0,1.13,1.13,4.63,4.63,0.79,7.34,1.93,1.22,1.22,1.54,0.79,1.62,1.62,2.9,2.92,'IS808_Rev',0.16200000000000001065);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(15,'∠ 40ⅹ 40ⅹ 5',2.99,3.81,40.0,40.0,5.0,5.5,0.0,1.17,1.17,5.58,5.58,0.79,8.83,2.33,1.21,1.21,1.52,0.78,1.97,1.97,3.55,3.57,'IS808_Rev',0.31200000000000001065);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(16,'∠ 40ⅹ 40ⅹ 6',3.54,4.5,40.0,40.0,6.0,5.5,0.0,1.21,1.21,6.46,6.46,0.79,10.2,2.73,1.2,1.2,1.5,0.78,2.32,2.32,4.17,4.19,'IS808_Rev',0.53200000000000002842);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(17,'∠ 45ⅹ 45ⅹ 3',2.1,2.67,45.0,45.0,3.0,5.5,0.0,1.22,1.22,5.2,5.2,0.79,8.2,2.17,1.39,1.39,1.76,0.9,1.58,1.58,2.84,2.86,'IS808_Rev',0.078000000000000015987);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(18,'∠ 45ⅹ 45ⅹ 4',2.75,3.5,45.0,45.0,4.0,5.5,0.0,1.26,1.26,6.7,6.7,0.79,10.6,2.78,1.38,1.38,1.74,0.89,2.07,2.07,3.71,3.73,'IS808_Rev',0.1830000000000000071);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(19,'∠ 45ⅹ 45ⅹ 5',3.39,4.31,45.0,45.0,5.0,5.5,0.0,1.3,1.3,8.1,8.1,0.79,12.8,3.37,1.37,1.37,1.72,0.88,2.53,2.53,4.55,4.57,'IS808_Rev',0.35400000000000000355);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(20,'∠ 45ⅹ 45ⅹ 6',4.01,5.1,45.0,45.0,6.0,5.5,0.0,1.34,1.34,9.42,9.42,0.79,14.9,3.94,1.36,1.36,1.71,0.88,2.98,2.98,5.36,5.38,'IS808_Rev',0.60400000000000000355);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(21,'∠ 50ⅹ 50ⅹ 3',2.34,2.99,50.0,50.0,3.0,6.0,0.0,1.34,1.34,7.21,7.21,0.79,11.4,3.01,1.55,1.55,1.96,1.0,1.97,1.97,3.53,3.55,'IS808_Rev',0.086999999999999992894);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(22,'∠ 50ⅹ 50ⅹ 4',3.08,3.92,50.0,50.0,4.0,6.0,0.0,1.38,1.38,9.32,9.32,0.79,14.8,3.86,1.54,1.54,1.94,0.99,2.57,2.57,4.62,4.64,'IS808_Rev',0.20400000000000000355);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(23,'∠ 50ⅹ 50ⅹ 5',3.79,4.83,50.0,50.0,5.0,6.0,0.0,1.42,1.42,11.3,11.3,0.79,17.9,4.69,1.53,1.53,1.93,0.99,3.16,3.16,5.67,5.7,'IS808_Rev',0.39500000000000001776);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(24,'∠ 50ⅹ 50ⅹ 6',4.49,5.72,50.0,50.0,6.0,6.0,0.0,1.46,1.46,13.2,13.2,0.79,20.8,5.48,1.52,1.52,1.91,0.98,3.72,3.72,6.69,6.71,'IS808_Rev',0.67600000000000015631);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(25,'∠ 55ⅹ 55ⅹ 4',3.4,4.33,55.0,55.0,4.0,6.5,0.0,1.5,1.5,12.5,12.5,0.79,19.9,5.2,1.7,1.7,2.14,1.1,3.14,3.14,5.63,5.66,'IS808_Rev',0.22600000000000002309);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(26,'∠ 55ⅹ 55ⅹ 5',4.19,5.34,55.0,55.0,5.0,6.5,0.0,1.54,1.54,15.2,15.2,0.79,24.2,6.31,1.69,1.69,2.13,1.09,3.85,3.85,6.92,6.95,'IS808_Rev',0.43700000000000001065);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(27,'∠ 55ⅹ 55ⅹ 6',4.97,6.33,55.0,55.0,6.0,6.5,0.0,1.58,1.58,17.8,17.8,0.79,28.2,7.39,1.68,1.68,2.11,1.08,4.55,4.55,8.17,8.2,'IS808_Rev',0.74800000000000004263);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(28,'∠ 55ⅹ 55ⅹ 8',6.48,8.25,55.0,55.0,8.0,6.5,0.0,1.66,1.66,22.5,22.5,0.79,35.6,9.48,1.65,1.65,2.08,1.07,5.87,5.87,10.5,10.6,'IS808_Rev',1.74);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(29,'∠ 60ⅹ 60ⅹ 4',3.71,4.73,60.0,60.0,4.0,6.5,0.0,1.63,1.63,16.4,16.4,0.79,26.0,6.8,1.86,1.86,2.35,1.2,3.76,3.76,6.74,6.77,'IS808_Rev',0.24699999999999993072);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(30,'∠ 60ⅹ 60ⅹ 5',4.58,5.84,60.0,60.0,5.0,6.5,0.0,1.67,1.67,20.0,20.0,0.79,31.7,8.26,1.85,1.85,2.33,1.19,4.62,4.62,8.3,8.32,'IS808_Rev',0.47900000000000000355);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(31,'∠ 60ⅹ 60ⅹ 6',5.44,6.93,60.0,60.0,6.0,6.5,0.0,1.71,1.71,23.4,23.4,0.79,37.1,9.69,1.84,1.84,2.31,1.18,5.46,5.46,9.81,9.84,'IS808_Rev',0.82);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(32,'∠ 60ⅹ 60ⅹ 8',7.1,9.05,60.0,60.0,8.0,6.5,0.0,1.78,1.78,29.8,29.8,0.79,47.1,12.4,1.81,1.81,2.28,1.17,7.06,7.06,12.7,12.7,'IS808_Rev',1.91);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(33,'∠ 65ⅹ 65ⅹ 4',4.03,5.13,65.0,65.0,4.0,6.5,0.0,1.75,1.75,21.0,21.0,0.79,33.4,8.69,2.02,2.02,2.55,1.3,4.43,4.43,7.95,7.98,'IS808_Rev',0.26800000000000001598);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(34,'∠ 65ⅹ 65ⅹ 5',4.98,6.34,65.0,65.0,5.0,6.5,0.0,1.79,1.79,25.7,25.7,0.79,40.8,10.6,2.01,2.01,2.54,1.29,5.45,5.45,9.8,9.83,'IS808_Rev',0.52);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(35,'∠ 65ⅹ 65ⅹ 6',5.91,7.53,65.0,65.0,6.0,6.5,0.0,1.83,1.83,30.1,30.1,0.79,47.8,12.4,2.0,2.0,2.52,1.28,6.45,6.45,11.5,11.6,'IS808_Rev',0.89199999999999999289);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(36,'∠ 65ⅹ 65ⅹ 8',7.73,9.85,65.0,65.0,8.0,6.5,0.0,1.91,1.91,38.4,38.4,0.79,60.8,16.0,1.97,1.97,2.48,1.27,8.36,8.36,15.0,15.0,'IS808_Rev',2.08);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(37,'∠ 70ⅹ 70ⅹ 5',5.38,6.86,70.0,70.0,5.0,7.0,0.0,1.92,1.92,32.3,32.3,0.79,51.3,13.3,2.17,2.17,2.74,1.39,6.36,6.36,11.4,11.4,'IS808_Rev',0.56200000000000009947);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(38,'∠ 70ⅹ 70ⅹ 6',6.39,8.15,70.0,70.0,6.0,7.0,0.0,1.96,1.96,38.0,38.0,0.79,60.3,15.6,2.16,2.16,2.72,1.39,7.53,7.53,13.5,13.5,'IS808_Rev',0.96400000000000005684);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(39,'∠ 70ⅹ 70ⅹ 8',8.37,10.6,70.0,70.0,8.0,7.0,0.0,2.03,2.03,48.5,48.5,0.79,76.9,20.1,2.13,2.13,2.69,1.37,9.77,9.77,17.5,17.6,'IS808_Rev',2.25);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(40,'∠ 70ⅹ 70ⅹ 10',10.29,13.1,70.0,70.0,10.0,7.0,0.0,2.11,2.11,58.3,58.3,0.79,92.1,24.4,2.11,2.11,2.65,1.37,11.9,11.9,21.4,21.5,'IS808_Rev',4.33);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(41,'∠ 75ⅹ 75ⅹ 5',5.77,7.36,75.0,75.0,5.0,7.0,0.0,2.04,2.04,40.0,40.0,0.79,63.6,16.5,2.33,2.33,2.94,1.5,7.3,7.3,13.2,13.2,'IS808_Rev',0.60400000000000000355);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(42,'∠ 75ⅹ 75ⅹ 6',6.86,8.75,75.0,75.0,6.0,7.0,0.0,2.08,2.08,47.1,47.1,0.79,74.8,19.4,2.32,2.32,2.92,1.49,8.7,8.7,15.6,15.6,'IS808_Rev',1.03);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(43,'∠ 75ⅹ 75ⅹ 8',9.0,11.4,75.0,75.0,8.0,7.0,0.0,2.16,2.16,60.3,60.3,0.79,95.7,24.9,2.29,2.29,2.89,1.47,11.3,11.3,20.3,20.4,'IS808_Rev',2.42);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(44,'∠ 75ⅹ 75ⅹ 10',11.07,14.1,75.0,75.0,10.0,7.0,0.0,2.23,2.23,72.6,72.6,0.79,114.0,30.3,2.27,2.27,2.85,1.47,13.8,13.8,24.8,24.9,'IS808_Rev',4.66);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(45,'∠ 80ⅹ 80ⅹ 6',7.36,9.38,80.0,80.0,6.0,8.0,0.0,2.2,2.2,57.6,57.6,0.79,91.4,23.7,2.48,2.48,3.12,1.59,9.9,9.9,17.8,17.9,'IS808_Rev',1.1);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(46,'∠ 80ⅹ 80ⅹ 8',9.65,12.3,80.0,80.0,8.0,8.0,0.0,2.28,2.28,74.0,74.0,0.79,117.0,30.5,2.45,2.45,3.09,1.58,12.9,12.9,23.3,23.3,'IS808_Rev',2.59);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(47,'∠ 80ⅹ 80ⅹ 10',11.88,15.1,80.0,80.0,10.0,8.0,0.0,2.36,2.36,89.2,89.2,0.79,141.0,37.1,2.43,2.43,3.05,1.57,15.8,15.8,28.4,28.5,'IS808_Rev',5.0);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(48,'∠ 80ⅹ 80ⅹ 12',14.05,17.9,80.0,80.0,12.0,8.0,0.0,2.43,2.43,103.0,103.0,0.79,163.0,43.5,2.4,2.4,3.02,1.56,18.5,18.5,33.4,33.5,'IS808_Rev',8.52);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(49,'∠ 90ⅹ 90ⅹ 6',8.32,10.6,90.0,90.0,6.0,8.5,0.0,2.45,2.45,83.0,83.0,0.79,131.0,34.2,2.8,2.8,3.53,1.8,12.7,12.7,22.8,22.8,'IS808_Rev',1.25);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(50,'∠ 90ⅹ 90ⅹ 8',10.92,13.9,90.0,90.0,8.0,8.5,0.0,2.53,2.53,107.0,107.0,0.79,170.0,44.1,2.77,2.77,3.5,1.78,16.5,16.5,29.7,29.8,'IS808_Rev',2.93);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(51,'∠ 90ⅹ 90ⅹ 10',13.47,17.1,90.0,90.0,10.0,8.5,0.0,2.6,2.6,129.0,129.0,0.79,205.0,53.6,2.75,2.75,3.46,1.77,20.2,20.2,36.4,36.5,'IS808_Rev',5.66);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(52,'∠ 90ⅹ 90ⅹ 12',15.95,20.3,90.0,90.0,12.0,8.5,0.0,2.68,2.68,150.0,150.0,0.79,238.0,62.8,2.72,2.72,3.42,1.76,23.8,23.8,42.9,43.0,'IS808_Rev',9.67);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(53,'∠ 100 ⅹ 100ⅹ 6',9.26,11.8,100.0,100.0,6.0,8.5,0.0,2.7,2.7,115.0,115.0,0.79,182.0,47.2,3.12,3.12,3.94,2.0,15.7,15.7,28.3,28.3,'IS808_Rev',1.39);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(54,'∠ 100 ⅹ 100ⅹ 8',12.18,15.5,100.0,100.0,8.0,8.5,0.0,2.78,2.78,148.0,148.0,0.79,236.0,61.0,3.1,3.1,3.9,1.98,20.6,20.6,37.0,37.1,'IS808_Rev',3.27);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(55,'∠ 100 ⅹ 100ⅹ 10',15.04,19.1,100.0,100.0,10.0,8.5,0.0,2.85,2.85,180.0,180.0,0.79,286.0,74.3,3.07,3.07,3.87,1.97,25.3,25.3,45.4,45.5,'IS808_Rev',6.33);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(56,'∠ 100 ⅹ 100ⅹ 12',17.83,22.7,100.0,100.0,12.0,8.5,0.0,2.93,2.93,210.0,210.0,0.79,333.0,87.2,3.04,3.04,3.83,1.96,29.8,29.8,53.6,53.7,'IS808_Rev',10.8);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(57,'∠ 110 ⅹ 110ⅹ 8',13.4,17.0,110.0,110.0,8.0,10.0,4.8,3.0,3.0,196.0,196.0,0.79,312.0,80.7,3.39,3.39,4.28,2.17,24.6,24.6,44.6,44.7,'IS808_Rev',3.61);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(58,'∠ 110 ⅹ 110ⅹ 10',16.58,21.1,110.0,110.0,10.0,10.0,4.8,3.09,3.09,240.0,240.0,0.79,381.0,98.6,3.37,3.37,4.25,2.16,30.4,30.4,54.9,55.0,'IS808_Rev',7.0);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(59,'∠ 110 ⅹ 110ⅹ 12',19.68,25.0,110.0,110.0,12.0,10.0,4.8,3.17,3.17,281.0,281.0,0.79,446.0,116.0,3.35,3.35,4.22,2.15,35.9,35.9,64.9,65.1,'IS808_Rev',11.9);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(60,'∠ 110 ⅹ 110ⅹ 16',25.71,32.7,110.0,110.0,16.0,10.0,4.8,3.32,3.32,357.0,357.0,0.79,565.0,149.0,3.3,3.3,4.15,2.14,46.5,46.5,84.1,84.2,'IS808_Rev',27.8);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(61,'∠ 130ⅹ 130ⅹ 8',15.92,20.2,130.0,130.0,8.0,10.0,4.8,3.5,3.5,330.0,330.0,0.79,526.0,135.0,4.04,4.04,5.1,2.58,34.8,34.8,63.0,63.1,'IS808_Rev',4.3);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(62,'∠ 130ⅹ130ⅹ 10',19.72,25.1,130.0,130.0,10.0,10.0,4.8,3.59,3.59,405.0,405.0,0.79,644.0,165.0,4.02,4.02,5.07,2.57,43.1,43.1,77.8,77.9,'IS808_Rev',8.33);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(63,'∠ 130ⅹ130ⅹ 12',23.45,29.8,130.0,130.0,12.0,10.0,4.8,3.67,3.67,476.0,476.0,0.79,757.0,195.0,3.99,3.99,5.04,2.56,51.0,51.0,92.2,92.3,'IS808_Rev',14.2);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(64,'∠ 130ⅹ130ⅹ 16',30.74,39.1,130.0,130.0,16.0,10.0,4.8,3.82,3.82,609.0,609.0,0.79,966.0,252.0,3.94,3.94,4.97,2.54,66.3,66.3,119.0,120.0,'IS808_Rev',33.3);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(65,'∠150ⅹ 150ⅹ 10',22.93,29.2,150.0,150.0,10.0,12.0,4.8,4.08,4.08,633.0,633.0,0.79,1000.0,259.0,4.66,4.66,5.87,2.98,58.0,58.0,104.0,104.0,'IS808_Rev',9.66);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(66,'∠150ⅹ 150ⅹ 12',27.29,34.7,150.0,150.0,12.0,12.0,4.8,4.16,4.16,746.0,746.0,0.79,1180.0,305.0,4.63,4.63,5.84,2.96,68.8,68.8,124.0,124.0,'IS808_Rev',16.5);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(67,'∠150ⅹ 150ⅹ 16',35.84,45.6,150.0,150.0,16.0,12.0,4.8,4.31,4.31,958.0,958.0,0.79,1520.0,394.0,4.58,4.58,5.78,2.94,89.7,89.7,162.0,162.0,'IS808_Rev',38.7);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(68,'∠150ⅹ 150ⅹ 20',44.12,56.2,150.0,150.0,20.0,12.0,4.8,4.46,4.46,1150.0,1150.0,0.79,1830.0,480.0,4.53,4.53,5.71,2.92,109.0,109.0,198.0,198.0,'IS808_Rev',74.6);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(69,'∠200 ⅹ 200ⅹ 12',36.85,46.9,200.0,200.0,12.0,15.0,4.8,5.39,5.39,1820.0,1820.0,0.79,2900.0,746.0,6.24,6.24,7.87,3.99,125.0,125.0,225.0,225.0,'IS808_Rev',22.3);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(70,'∠200 ⅹ 200ⅹ 16',48.53,61.8,200.0,200.0,16.0,15.0,4.8,5.56,5.56,2360.0,2360.0,0.79,3760.0,967.0,6.19,6.19,7.8,3.96,163.0,163.0,295.0,295.0,'IS808_Rev',52.4);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(71,'∠200 ⅹ 200ⅹ 20',59.96,76.3,200.0,200.0,20.0,15.0,4.8,5.71,5.71,2870.0,2870.0,0.79,4560.0,1180.0,6.13,6.13,7.73,3.93,201.0,201.0,362.0,363.0,'IS808_Rev',101.0);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(72,'∠200 ⅹ 200ⅹ 25',73.9,94.1,200.0,200.0,25.0,15.0,4.8,5.9,5.9,3470.0,3470.0,0.79,5500.0,1430.0,6.07,6.07,7.65,3.91,246.0,246.0,443.0,444.0,'IS808_Rev',195.0);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(73,'∠50 ⅹ 50ⅹ 7',5.17,6.59,50.0,50.0,7.0,6.0,0.0,1.5,1.5,14.9,14.9,0.79,23.6,6.27,1.51,1.51,1.89,0.98,4.26,4.26,7.67,7.7,'IS808_Rev',1.06);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(74,'∠50 ⅹ 50ⅹ 8',5.84,7.44,50.0,50.0,8.0,6.0,0.0,1.54,1.54,16.6,16.6,0.79,26.2,7.03,1.49,1.49,1.88,0.97,4.79,4.79,8.62,8.65,'IS808_Rev',1.57);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(75,'∠55 ⅹ 55 x10',7.92,10.0,55.0,55.0,10.0,6.5,0.0,1.73,1.73,26.8,26.8,0.79,42.1,11.5,1.63,1.63,2.04,1.07,7.11,7.11,12.8,12.8,'IS808_Rev',3.33);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(76,'∠60 ⅹ 60 ⅹ 10',8.71,11.0,60.0,60.0,10.0,6.5,0.0,1.86,1.86,35.5,35.5,0.79,55.9,15.1,1.79,1.79,2.25,1.17,8.57,8.57,15.4,15.4,'IS808_Rev',3.66);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(77,'∠65 ⅹ 65ⅹ 10',9.49,12.0,65.0,65.0,10.0,6.5,0.0,1.98,1.98,45.9,45.9,0.79,72.5,19.4,1.95,1.95,2.45,1.27,10.1,10.1,18.3,18.3,'IS808_Rev',4.0);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(78,'∠ 70 ⅹ 70ⅹ 7',7.39,9.42,70.0,70.0,7.0,7.0,0.0,2.0,2.0,43.4,43.4,0.79,68.8,17.9,2.15,2.15,2.7,1.38,8.66,8.66,15.5,15.6,'IS808_Rev',1.52);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(79,'∠ 100 ⅹ 100ⅹ 7',10.73,13.6,100.0,100.0,7.0,8.5,0.0,2.74,2.74,132.0,132.0,0.79,210.0,54.2,3.11,3.11,3.92,1.99,18.2,18.2,32.7,32.7,'IS808_Rev',2.2);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(80,'∠ 100 ⅹ 100ⅹ 15',21.91,27.9,100.0,100.0,15.0,8.5,0.0,3.04,3.04,252.0,252.0,0.79,398.0,106.0,3.01,3.01,3.78,1.95,36.2,36.2,65.3,65.4,'IS808_Rev',20.8);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(81,'∠ 120 ⅹ 120ⅹ 8',14.66,18.6,120.0,120.0,8.0,10.0,4.8,3.25,3.25,258.0,258.0,0.79,410.0,105.0,3.72,3.72,4.69,2.38,29.5,29.5,53.4,53.5,'IS808_Rev',3.95);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(82,'∠ 120 ⅹ 120ⅹ 10',18.15,23.1,120.0,120.0,10.0,10.0,4.8,3.34,3.34,315.0,315.0,0.79,501.0,129.0,3.69,3.69,4.66,2.36,36.4,36.4,65.9,66.0,'IS808_Rev',7.66);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(83,'∠ 120 ⅹ 120ⅹ 12',21.57,27.4,120.0,120.0,12.0,10.0,4.8,3.42,3.42,370.0,370.0,0.79,588.0,152.0,3.67,3.67,4.63,2.35,43.1,43.1,78.0,78.1,'IS808_Rev',13.1);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(84,'∠ 120 ⅹ 120ⅹ 15',26.58,33.8,120.0,120.0,15.0,10.0,4.8,3.53,3.53,447.0,447.0,0.79,709.0,185.0,3.64,3.64,4.58,2.34,52.8,52.8,95.5,95.6,'IS808_Rev',25.3);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(85,'∠ 130 ⅹ 130ⅹ 9',17.82,22.7,130.0,130.0,9.0,10.0,4.8,3.55,3.55,368.0,368.0,0.79,586.0,150.0,4.03,4.03,5.08,2.57,39.0,39.0,70.5,70.6,'IS808_Rev',6.09);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(86,'∠150 ⅹ 150ⅹ 15',33.72,42.9,150.0,150.0,15.0,12.0,4.8,4.28,4.28,907.0,907.0,0.79,1440.0,372.0,4.6,4.6,5.79,2.95,84.6,84.6,152.0,152.0,'IS808_Rev',32.0);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(87,'∠150 ⅹ 150ⅹ 18',40.01,50.9,150.0,150.0,18.0,12.0,4.8,4.39,4.39,1050.0,1050.0,0.79,1680.0,437.0,4.56,4.56,5.74,2.93,99.8,99.8,180.0,180.0,'IS808_Rev',54.8);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(88,'∠180 ⅹ 180ⅹ 15',41.09,52.3,180.0,180.0,15.0,18.0,4.8,5.0,5.0,1610.0,1610.0,0.79,2550.0,663.0,5.55,5.55,6.99,3.56,123.0,123.0,223.0,223.0,'IS808_Rev',38.8);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(89,'∠180 ⅹ 180ⅹ 18',48.79,62.1,180.0,180.0,18.0,18.0,4.8,5.12,5.12,1880.0,1880.0,0.79,2990.0,778.0,5.51,5.51,6.94,3.54,146.0,146.0,264.0,264.0,'IS808_Rev',66.4);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(90,'∠180 ⅹ 180ⅹ 20',53.85,68.6,180.0,180.0,20.0,18.0,4.8,5.2,5.2,2060.0,2060.0,0.79,3270.0,853.0,5.49,5.49,6.91,3.53,161.0,161.0,290.0,291.0,'IS808_Rev',90.6);
INSERT INTO public."EqualAngle"("id" , "Designation" , "Mass" , "Area" , "a" , "b" , "t" , "R1" , "R2" , "Cz" , "Cy" , "Iz" , "Iy" , "Alpha" , "Iu_max" , "Iv_min" , "rz" , "ry" , "ru_max" , "rv_min" , "Zz" , "Zy" , "Zpz" , "Zpy" , "Source" , "It") VALUES(91,'∠200 ⅹ 200ⅹ 24',71.31,90.8,200.0,200.0,24.0,18.0,4.8,5.85,5.85,3350.0,3350.0,0.79,5320.0,1390.0,6.08,6.08,7.65,3.91,237.0,237.0,427.0,428.0,'IS808_Rev',173.0);
CREATE TABLE IF NOT EXISTS public."Columns" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR(50),
	"Mass"	NUMERIC(10 , 2),
	"Area"	NUMERIC(10 , 2),
	"D"	NUMERIC(10 , 2),
	"B"	NUMERIC(10 , 2),
	"tw"	NUMERIC(10 , 2),
	"T"	INTEGER,
	"FlangeSlope"	INTEGER DEFAULT (null),
	"R1"	NUMERIC(10 , 2),
	"R2"	NUMERIC(10 , 2),
	"Iz"	NUMERIC(10 , 2),
	"Iy"	NUMERIC(10 , 2),
	"rz"	NUMERIC(10 , 2),
	"ry"	NUMERIC(10 , 2),
	"Zz"	NUMERIC(10 , 2),
	"Zy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"It"	NUMERIC(10 , 2),
	"Iw"	NUMERIC(10 , 2),
	"Source"	VARCHAR(100),
	"Type"	VARCHAR(100)
);
INSERT INTO public."Columns" VALUES(1,'HB 150',27.06,34.4,150.0,150.0,5.4,9,94,8.0,4.0,1450.0,431.0,6.49,3.53,194.0,57.5,215.0,92.7,10.1,25100.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(2,'HB 150*',30.15,38.4,150.0,150.0,8.4,9,94,8.0,4.0,1510.0,435.0,6.27,3.36,201.0,58.0,228.0,94.7,12.6,25100.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(3,'HB 150*',33.66,42.9,150.0,150.0,11.8,9,94,8.0,4.0,1570.0,439.0,6.06,3.2,210.0,58.6,243.0,97.6,17.4,25100.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(4,'HB 200',37.31,47.5,200.0,200.0,6.1,9,94,9.0,4.5,3600.0,967.0,8.71,4.51,360.0,96.7,397.0,159.0,14.9,109000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(5,'HB 200*',39.73,50.6,200.0,200.0,7.8,9,94,9.0,4.5,3690.0,971.0,8.54,4.38,369.0,97.1,411.0,160.0,16.6,109000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(6,'HB 225',43.12,54.9,225.0,225.0,6.5,9.1,94,10.0,5.0,5280.0,1350.0,9.8,4.96,469.0,120.0,515.0,200.0,18.3,201000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(7,'HB 225*',46.52,59.2,225.0,225.0,8.6,9.1,94,10.0,5.0,5430.0,1360.0,9.57,4.79,483.0,121.0,538.0,203.0,20.8,201000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(8,'HB 250',50.98,64.9,250.0,250.0,6.9,9.7,94,10.0,5.0,7730.0,1960.0,10.9,5.49,619.0,156.0,678.0,262.0,24.5,364000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(9,'HB 250*',54.41,69.3,250.0,250.0,8.8,9.7,94,10.0,5.0,7930.0,1970.0,10.6,5.33,634.0,157.0,704.0,264.0,27.2,364000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(10,'HB 300',58.74,74.8,300.0,250.0,7.6,10.6,94,11.0,5.5,12500.0,2190.0,12.9,5.41,836.0,175.0,921.0,291.0,32.4,577000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(11,'HB 300*',62.67,79.8,300.0,250.0,9.4,10.6,94,11.0,5.5,12800.0,2200.0,12.6,5.25,858.0,176.0,956.0,294.0,36.2,577000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(12,'HB 350',67.42,85.9,350.0,250.0,8.3,11.6,94,12.0,6.0,19100.0,2450.0,14.9,5.34,1090.0,196.0,1210.0,324.0,42.8,864000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(13,'HB 350*',72.03,91.7,350.0,250.0,10.1,11.6,94,12.0,6.0,19600.0,2460.0,14.6,5.17,1120.0,196.0,1260.0,328.0,48.3,864000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(14,'HB 400',77.43,98.6,400.0,250.0,9.1,12.7,94,14.0,7.0,28000.0,2720.0,16.8,5.25,1400.0,218.0,1560.0,360.0,57.8,1240000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(15,'HB 400*',81.83,104.0,400.0,250.0,10.6,12.7,94,14.0,7.0,28700.0,2730.0,16.6,5.12,1430.0,218.0,1610.0,364.0,63.9,1240000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(16,'HB 450',87.22,111.0,450.0,250.0,9.8,13.7,94,15.0,7.5,39200.0,2980.0,18.7,5.18,1740.0,238.0,1950.0,394.0,73.5,1690000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(17,'HB 450*',92.19,117.0,450.0,250.0,11.3,13.7,94,15.0,7.5,40100.0,2990.0,18.4,5.04,1780.0,239.0,2020.0,398.0,81.5,1690000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(18,'PBP 200 X 43.85',43.85,55.8,200.0,205.0,9.3,9.3,90,10.0,0.0,3990.0,1330.0,8.46,4.89,399.0,130.0,447.0,199.0,17.9,121000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(19,'PBP 200 X 53.49',53.49,68.1,204.0,207.0,11.3,11.3,90,10.0,0.0,4970.0,1670.0,8.54,4.96,487.0,161.0,551.0,248.0,31.9,155000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(20,'PBP 220 X 57.28',57.28,72.9,210.0,225.0,11.0,11,90,18.0,0.0,5730.0,2090.0,8.87,5.36,546.0,186.0,614.0,286.0,37.6,206000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(21,'PBP 260 X 75.01',75.01,95.5,249.0,265.0,12.0,12,90,24.0,0.0,10600.0,3730.0,10.5,6.25,854.0,281.0,958.0,435.0,64.3,522000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(22,'PBP 260 X 87.3',87.3,111.0,253.0,267.0,14.0,14,90,24.0,0.0,12500.0,4450.0,10.6,6.33,993.0,333.0,1120.0,516.0,96.6,634000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(23,'PBP 300 X 76.92',76.92,97.9,299.0,306.0,10.8,10.8,90,15.0,0.0,16000.0,5160.0,12.7,7.26,1070.0,337.0,1180.0,515.0,43.5,1070000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(24,'PBP 300 X 88.46',88.46,112.0,302.0,308.0,12.4,12.4,90,15.0,0.0,18500.0,6040.0,12.8,7.32,1220.0,392.0,1370.0,600.0,65.0,1260000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(25,'PBP 300 X 95',95.0,121.0,304.0,309.0,13.3,13.3,90,15.0,0.0,20000.0,6540.0,12.8,7.36,1320.0,423.0,1470.0,649.0,79.8,1380000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(26,'PBP 300 X 109.54',109.54,139.0,308.0,311.0,15.3,15.3,90,15.0,0.0,23400.0,7680.0,12.9,7.42,1520.0,494.0,1710.0,758.0,120.0,1640000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(27,'PBP 300 X 124.2',124.2,158.0,312.0,313.0,17.3,17.3,90,15.0,0.0,26900.0,8850.0,13.0,7.48,1720.0,565.0,1950.0,870.0,173.0,1910000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(28,'PBP 300 X 150.01',150.01,191.0,319.0,316.0,20.8,20.8,90,15.0,0.0,33200.0,10900.0,13.2,7.57,2080.0,693.0,2380.0,1070.0,300.0,2430000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(29,'PBP 300 X 180.12',180.12,229.0,327.0,320.0,24.8,24.8,90,15.0,0.0,41000.0,13500.0,13.3,7.69,2500.0,849.0,2900.0,1310.0,510.0,3090000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(30,'PBP 300 X 184.12',184.12,234.0,328.0,321.0,25.3,25.3,90,15.0,0.0,42000.0,13900.0,13.3,7.72,2560.0,871.0,2970.0,1350.0,542.0,3190000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(31,'PBP 300 X 222.58',222.58,283.0,338.0,326.0,30.3,30.3,90,15.0,0.0,52500.0,17500.0,13.6,7.87,3100.0,1070.0,3640.0,1670.0,936.0,4140000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(32,'PBP 320 X 88.48',88.48,112.0,303.0,304.0,12.0,12,90,27.0,0.0,18700.0,5630.0,12.8,7.07,1230.0,370.0,1370.0,572.0,78.8,1180000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(33,'PBP 320 X 102.84',102.84,131.0,307.0,306.0,14.0,14,90,27.0,0.0,22000.0,6700.0,12.9,7.15,1430.0,438.0,1610.0,677.0,117.0,1430000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(34,'PBP 320 X 117.33',117.33,149.0,311.0,308.0,16.0,16,90,27.0,0.0,25400.0,7810.0,13.0,7.23,1630.0,507.0,1840.0,785.0,167.0,1690000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(35,'PBP 320 X 146.69',146.69,186.0,319.0,312.0,20.0,20,90,27.0,0.0,32600.0,10100.0,13.2,7.37,2040.0,651.0,2330.0,1010.0,309.0,2260000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(36,'PBP 320 X 184.1',184.1,234.0,329.0,317.0,25.0,25,90,27.0,0.0,42200.0,13300.0,13.4,7.54,2560.0,841.0,2970.0,1310.0,586.0,3060000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(37,'PBP 360 X 152.2',152.2,193.0,356.0,376.0,18.0,17.9,90,15.0,0.0,43800.0,15800.0,15.0,9.0,2460.0,844.0,2760.0,1290.0,225.0,4530000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(38,'PBP 360 X 174.2',174.2,221.0,361.0,379.0,20.0,20.4,90,15.0,0.0,50900.0,18500.0,15.1,9.1,2820.0,978.0,3180.0,1500.0,325.0,5360000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(39,'PBP 360 X 178.4',178.4,227.0,362.0,379.0,21.0,20.9,90,15.0,0.0,52200.0,18900.0,15.2,9.1,2880.0,1000.0,3260.0,1530.0,357.0,5510000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(40,'PBP 400 X 122.4',122.4,155.0,348.0,390.0,14.0,14,90,15.0,0.0,34700.0,13800.0,14.9,9.4,1990.0,710.0,2210.0,1080.0,111.0,3860000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(41,'PBP 400 X 140.2',140.2,178.0,352.0,392.0,16.0,16,90,15.0,0.0,40200.0,16000.0,15.0,9.5,2280.0,820.0,2540.0,1250.0,165.0,4530000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(42,'PBP 400 X 158.1',158.1,201.0,356.0,394.0,18.0,18,90,15.0,0.0,45900.0,18300.0,15.1,9.6,2570.0,932.0,2880.0,1420.0,234.0,5240000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(43,'PBP 400 X 176.1',176.1,224.0,360.0,396.0,20.0,20,90,15.0,0.0,51700.0,20700.0,15.2,9.6,2870.0,1040.0,3230.0,1600.0,321.0,5980000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(44,'PBP 400 X 194.3',194.3,247.0,364.0,398.0,22.0,22,90,15.0,0.0,57600.0,23100.0,15.3,9.7,3160.0,1160.0,3580.0,1780.0,428.0,6750000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(45,'PBP 400 X 212.5',212.5,270.0,368.0,400.0,24.0,24,90,15.0,0.0,63800.0,25600.0,15.4,9.7,3460.0,1280.0,3940.0,1960.0,556.0,7570000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(46,'PBP 400 X 230.9',230.9,294.0,372.0,402.0,26.0,26,90,15.0,0.0,70100.0,28200.0,15.4,9.8,3770.0,1400.0,4310.0,2150.0,707.0,8420000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(47,'SC 100',19.97,25.4,100.0,100.0,6.0,10,98,12.0,6.0,434.0,136.0,4.13,2.31,87.0,27.2,101.0,45.2,10.6,3370.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(48,'SC 120',26.22,33.4,120.0,120.0,6.5,11,98,12.0,6.0,840.0,255.0,5.02,2.77,140.0,42.6,161.0,70.8,16.5,9400.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(49,'SC 140',33.25,42.3,140.0,140.0,7.0,12,98,12.0,6.0,1470.0,437.0,5.9,3.21,210.0,62.5,240.0,104.0,24.6,22400.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(50,'SC 150*',36.93,47.0,152.0,152.0,7.9,11.9,98,11.7,3.0,1920.0,554.0,6.39,3.43,253.0,72.9,288.0,122.0,27.6,34100.0,'IS808_Old',NULL);
INSERT INTO public."Columns" VALUES(51,'SC 160',41.85,53.3,160.0,160.0,8.0,13,98,15.0,7.5,2410.0,694.0,6.74,3.61,302.0,86.8,345.0,146.0,38.3,47900.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(52,'SC 180',50.48,64.3,180.0,180.0,8.5,14,98,15.0,7.5,3730.0,1050.0,7.62,4.05,414.0,117.0,471.0,197.0,52.8,93700.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(53,'SC 200',60.24,76.7,200.0,200.0,9.0,15,98,18.0,9.0,5520.0,1520.0,8.49,4.46,552.0,152.0,627.0,259.0,74.9,171000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(54,'SC 220',70.41,89.6,220.0,220.0,9.5,16,98,18.0,9.0,7860.0,2150.0,9.37,4.9,715.0,196.0,809.0,333.0,98.4,295000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(55,'SC 250',85.54,108.0,250.0,250.0,10.0,17,98,23.0,11.5,12400.0,3250.0,10.6,5.47,995.0,260.0,1120.0,448.0,143.0,600000.0,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(56,'UC 152 x 152 x 23',23.0,29.2,152.4,152.2,5.8,6.8,90,7.6,0.0,1250.0,400.0,6.54,3.7,164.0,52.5,182.0,80.2,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(57,'UC 152 x 152 x 30',30.0,38.3,157.6,152.9,6.5,9.4,90,7.6,0.0,1748.0,560.0,6.76,3.83,222.0,73.3,248.0,112.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(58,'UC 152 x 152 x 37',37.0,47.1,161.8,154.4,8.0,11.5,90,7.6,0.0,2210.0,706.0,6.85,3.87,273.0,91.5,309.0,140.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(59,'UC 203 x 203 x 46',46.1,58.7,203.2,203.6,7.2,11,90,10.2,0.0,4568.0,1548.0,8.82,5.13,450.0,152.0,497.0,231.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(60,'UC 203 x 203 x 52',52.0,66.3,206.2,204.3,7.9,12.5,90,10.2,0.0,5259.0,1777.0,8.91,5.18,510.0,174.0,567.0,264.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(61,'UC 203 x 203 x 60',60.0,76.4,209.6,205.8,9.4,14.2,90,10.2,0.0,6125.0,2064.0,8.95,5.2,584.0,201.0,656.0,305.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(62,'UC 203 x 203 x 71',71.0,90.4,215.8,206.4,10.0,17.3,90,10.2,0.0,7618.0,2537.0,9.18,5.3,706.0,246.0,799.0,374.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(63,'UC 203 x 203 x 86',86.1,109.6,222.2,209.1,12.7,20.5,90,10.2,0.0,9449.0,3127.0,9.28,5.34,850.0,299.0,977.0,456.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(64,'UC 254 x 254 x 107',107.1,136.4,266.7,258.8,12.8,20.5,90,12.7,0.0,17510.0,5927.0,11.3,6.59,1313.0,458.0,1484.0,697.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(65,'UC 254 x 254 x 132',132.0,168.1,276.3,261.3,15.3,25.3,90,12.7,0.0,22529.0,7531.0,11.6,6.69,1631.0,576.0,1869.0,878.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(66,'UC 254 x 254 x 167',167.1,212.9,289.1,265.2,19.2,31.7,90,12.7,0.0,29998.0,9869.0,11.9,6.81,2075.0,744.0,2424.0,1137.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(67,'UC 254 x 254 x 73',73.1,93.1,254.1,254.6,8.6,14.2,90,12.7,0.0,11407.0,3907.0,11.1,6.48,898.0,307.0,992.0,465.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(68,'UC 254 x 254 x 89',88.9,113.3,260.3,256.3,10.3,17.3,90,12.7,0.0,14268.0,4857.0,11.2,6.55,1096.0,379.0,1224.0,575.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(69,'UC 305 x 305 x 118',117.9,150.2,314.5,307.4,12.0,18.7,90,15.2,0.0,27672.0,9058.0,13.6,7.77,1760.0,589.0,1958.0,895.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(70,'UC 305 x 305 x 137',136.9,174.4,320.5,309.2,13.8,21.7,90,15.2,0.0,32814.0,10698.0,13.7,7.83,2048.0,692.0,2297.0,1053.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(71,'UC 305 x 305 x 158',158.1,201.4,327.1,311.2,15.8,25,90,15.2,0.0,38747.0,12568.0,13.9,7.9,2369.0,808.0,2680.0,1230.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(72,'UC 305 x 305 x 198',198.1,252.4,339.9,314.5,19.1,31.4,90,15.2,0.0,50904.0,16298.0,14.2,8.04,2995.0,1036.0,3440.0,1581.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(73,'UC 305 x 305 x 240',240.0,305.8,352.5,318.4,23.0,37.7,90,15.2,0.0,64203.0,20313.0,14.5,8.15,3643.0,1276.0,4247.0,1951.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(74,'UC 305 x 305 x 283',282.9,360.4,365.3,322.2,26.8,44.1,90,15.2,0.0,78872.0,24633.0,14.8,8.27,4318.0,1529.0,5105.0,2342.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(75,'UC 305 x 305 x 97',96.9,123.4,307.9,305.3,9.9,15.4,90,15.2,0.0,22249.0,7307.0,13.4,7.69,1445.0,479.0,1592.0,726.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(76,'UC 356 x 368 x 129',129.0,164.3,355.6,368.6,10.4,17.5,90,15.2,0.0,40246.0,14610.0,15.6,9.43,2264.0,793.0,2479.0,1199.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(77,'UC 356 x 368 x 153',152.9,194.8,362.0,370.5,12.3,20.7,90,15.2,0.0,48589.0,17552.0,15.8,9.49,2684.0,947.0,2965.0,1435.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(78,'UC 356 x 368 x 177',177.0,225.5,368.2,372.6,14.4,23.8,90,15.2,0.0,57118.0,20528.0,15.9,9.54,3103.0,1102.0,3455.0,1671.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(79,'UC 356 x 368 x 202',201.9,257.2,374.6,374.7,16.5,27,90,15.2,0.0,66261.0,23687.0,16.1,9.6,3538.0,1264.0,3972.0,1920.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(80,'UC 356 x 406 x 235',235.1,299.4,381.0,394.8,18.4,30.2,90,15.2,0.0,79085.0,30992.0,16.3,10.2,4151.0,1570.0,4687.0,2383.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(81,'UC 356 x 406 x 287',287.1,365.7,393.6,399.0,22.6,36.5,90,15.2,0.0,99875.0,38676.0,16.5,10.3,5075.0,1939.0,5812.0,2949.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(82,'UC 356 x 406 x 340',339.9,433.0,406.4,403.0,26.6,42.9,90,15.2,0.0,122543.0,46851.0,16.8,10.4,6031.0,2325.0,6999.0,3544.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(83,'UC 356 x 406 x 393',393.0,500.6,419.0,407.0,30.6,49.2,90,15.2,0.0,146618.0,55365.0,17.1,10.5,6998.0,2721.0,8222.0,4154.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(84,'UC 356 x 406 x 467',467.0,594.9,436.6,412.2,35.8,58,90,15.2,0.0,183003.0,67831.0,17.5,10.7,8383.0,3291.0,10002.0,5034.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(85,'UC 356 x 406 x 551',551.0,701.9,455.6,418.5,42.1,67.5,90,15.2,0.0,226938.0,82668.0,18.0,10.9,9962.0,3951.0,12076.0,6058.0,NULL,NULL,'IS808_Rev',NULL);
INSERT INTO public."Columns" VALUES(86,'UC 356 x 406 x 634',633.9,807.5,474.6,424.0,47.6,77,90,15.2,0.0,274845.0,98122.0,18.4,11.0,11582.0,4628.0,14235.0,7108.0,NULL,NULL,'IS808_Rev',NULL);
CREATE TABLE IF NOT EXISTS public."Beams" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR(50),
	"Mass"	NUMERIC(10 , 2),
	"Area"	NUMERIC(10 , 2),
	"D"	NUMERIC(10 , 2),
	"B"	NUMERIC(10 , 2),
	"tw"	NUMERIC(10 , 2),
	"T"	NUMERIC(10 , 2),
	"FlangeSlope"	INTEGER,
	"R1"	NUMERIC(10 , 2),
	"R2"	NUMERIC(10 , 2),
	"Iz"	NUMERIC(10 , 2),
	"Iy"	NUMERIC(10 , 2),
	"rz"	NUMERIC(10 , 2),
	"ry"	NUMERIC(10 , 2),
	"Zz"	NUMERIC(10 , 2),
	"Zy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"It"	NUMERIC(10 , 2),
	"Iw"	NUMERIC(10 , 2),
	"Source"	VARCHAR(100),
	"Type"	VARCHAR(100)
);
INSERT INTO public."Beams" VALUES(1,'JB 150',7.07,9.0,150.0,50.0,3.0,4.6,91.5,5.0,1.5,321.0,9.21,5.97,1.01,42.8,3.68,49.5,5.96,0.54800000000000004263,506.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(2,'JB 175',8.07,10.2,175.0,50.0,3.2,4.8,91.5,5.0,1.5,480.0,9.65,6.83,0.96899999999999995026,54.9,3.86,64.2,6.32,0.65600000000000004973,724.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(3,'JB 200',9.92,12.6,200.0,60.0,3.4,5.0,91.5,5.0,1.5,780.0,17.2,7.85,1.16,78.0,5.76,90.9,9.35,0.87300000000000004263,1710.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(4,'JB 225',12.78,16.2,225.0,80.0,3.7,5.0,91.5,6.5,1.5,1310.0,40.4,8.97,1.57,116.0,10.1,134.0,16.2,1.27,5160.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(5,'LB 75',6.05,7.71,75.0,50.0,3.7,5.0,91.5,6.5,2.0,72.7,10.0,3.07,1.13,19.3,4.0,22.3,6.39,0.73700000000000001065,127.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(6,'LB 100',8.01,10.2,100.0,50.0,4.0,6.4,91.5,7.0,3.0,168.0,12.7,4.05,1.11,33.6,5.08,38.9,8.2,1.38,292.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(7,'LB(P) 100',8.75,11.1,100.0,50.0,4.3,7.0,91.5,8.0,3.0,181.0,14.0,4.04,1.12,36.3,5.6,42.3,9.06,1.86,315.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(8,'LB 125',11.87,15.1,125.0,75.0,4.4,6.5,91.5,8.0,3.0,406.0,43.3,5.18,1.69,65.1,11.5,73.9,18.3,2.21,1600.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(9,'LB 150',14.19,18.0,150.0,80.0,4.8,6.8,91.5,9.5,3.0,687.0,55.2,6.16,1.74,91.7,13.8,104.0,22.1,3.02,2970.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(10,'LB 175',16.59,21.1,175.0,90.0,5.0,6.9,91.5,9.5,3.0,1090.0,79.5,7.18,1.94,124.0,17.6,141.0,28.2,3.55,5920.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(11,'LB(P) 175',16.6,21.1,175.0,80.0,5.2,7.7,96,9.5,3.0,1060.0,57.2,7.1,1.64,122.0,14.3,140.0,23.9,4.5,4590.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(12,'LB 200',19.83,25.2,200.0,100.0,5.4,7.3,91.5,9.5,3.0,1690.0,115.0,8.19,2.13,169.0,23.0,192.0,36.9,4.61,11200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(13,'LB(P) 200',21.06,26.8,200.0,100.0,5.6,8.0,96,9.5,3.0,1800.0,112.0,8.19,2.05,180.0,22.5,205.0,37.7,6.27,12200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(14,'LB 225',23.47,29.9,225.0,100.0,5.8,8.6,98,12.0,6.0,2500.0,112.0,9.14,1.94,222.0,22.5,254.0,39.2,8.47,16700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(15,'LB 250',27.87,35.5,250.0,125.0,6.1,8.2,98,13.0,6.5,3720.0,193.0,10.2,2.33,297.0,30.9,338.0,55.3,10.2,39000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(16,'LB 275',32.96,42.0,275.0,140.0,6.4,8.8,98,14.0,7.0,5370.0,287.0,11.3,2.61,391.0,41.0,443.0,73.5,14.0,71200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(17,'LB 300',37.72,48.0,300.0,150.0,6.7,9.4,98,15.0,7.5,7340.0,376.0,12.3,2.79,489.0,50.1,554.0,89.9,18.1,111000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(18,'LB(P) 300',41.5,52.8,300.0,140.0,7.0,11.6,98,15.0,7.5,8140.0,414.0,12.4,2.79,542.0,59.2,614.0,101.0,26.3,110000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(19,'LB 325',43.07,54.8,325.0,165.0,7.0,9.8,98,16.0,8.0,9880.0,510.0,13.4,3.05,608.0,61.9,688.0,111.0,22.8,182000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(20,'LB 350',49.44,63.0,350.0,165.0,7.4,11.4,98,16.0,8.0,13100.0,632.0,14.4,3.16,752.0,76.6,851.0,134.0,32.3,244000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(21,'LB 400',56.82,72.4,400.0,165.0,8.0,12.5,98,16.0,8.0,19300.0,716.0,16.3,3.14,965.0,86.8,1090.0,151.0,41.2,351000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(22,'LB 450',65.22,83.1,450.0,170.0,8.6,13.4,98,16.0,8.0,27500.0,853.0,18.2,3.2,1220.0,100.0,1400.0,174.0,51.8,522000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(23,'LB 500',74.92,95.4,500.0,180.0,9.2,14.1,98,17.0,8.5,38500.0,1060.0,20.1,3.33,1540.0,118.0,1770.0,206.0,65.5,808000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(24,'LB 550',86.28,109.0,550.0,190.0,9.9,15.0,98,18.0,9.0,53100.0,1330.0,21.9,3.48,1930.0,140.0,2220.0,246.0,84.5,1220000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(25,'LB 600',99.39,126.0,600.0,210.0,10.5,15.5,98,20.0,10.0,72900.0,1820.0,23.9,3.79,2430.0,173.0,2790.0,306.0,107.0,2040000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(26,'MB 100',8.95,11.4,100.0,50.0,4.7,7.0,98,9.0,4.5,182.0,12.5,3.99,1.04,36.4,5.01,42.6,8.58,2.15,315.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(27,'MB 125',13.35,17.0,125.0,70.0,5.0,8.0,98,9.0,4.5,445.0,38.4,5.11,1.5,71.3,10.9,82.1,18.4,3.99,1560.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(28,'MB 150',14.96,19.0,150.0,75.0,5.0,8.0,98,9.0,4.5,718.0,46.7,6.13,1.56,95.7,12.4,109.0,21.0,4.36,2830.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(29,'MB 175',19.5,24.8,175.0,85.0,5.8,9.0,98,10.0,5.0,1260.0,76.6,7.12,1.75,144.0,18.0,165.0,30.5,7.17,6340.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(30,'MB 200',24.17,30.8,200.0,100.0,5.7,10.0,98,11.0,5.5,2110.0,136.0,8.28,2.1,211.0,27.3,240.0,46.0,10.7,15000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(31,'MB 225',31.15,39.7,225.0,110.0,6.5,11.8,98,12.0,6.0,3440.0,218.0,9.31,2.34,306.0,39.6,348.0,66.3,18.6,29700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(32,'MB 250',37.3,47.5,250.0,125.0,6.9,12.5,98,13.0,6.5,5130.0,334.0,10.3,2.65,410.0,53.5,465.0,89.7,25.5,57300.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(33,'MB 300',46.02,58.6,300.0,140.0,7.7,13.1,98,14.0,7.0,8990.0,486.0,12.3,2.87,599.0,69.4,681.0,117.0,34.7,123000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(34,'MB 350',52.33,66.7,350.0,140.0,8.1,14.2,98,14.0,7.0,13600.0,537.0,14.2,2.83,779.0,76.8,889.0,129.0,43.1,183000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(35,'MB 400',61.55,78.4,400.0,140.0,8.9,16.0,98,14.0,7.0,20400.0,622.0,16.1,2.81,1020.0,88.8,1170.0,149.0,59.6,269000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(36,'MB 450',72.38,92.2,450.0,150.0,9.4,17.4,98,15.0,7.5,30400.0,834.0,18.1,3.0,1350.0,111.0,1550.0,187.0,81.0,457000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(37,'MB 500',86.88,110.0,500.0,180.0,10.2,17.2,98,17.0,8.5,45200.0,1360.0,20.2,3.51,1800.0,152.0,2070.0,259.0,103.0,974000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(38,'MB 550',103.64,132.0,550.0,190.0,11.2,19.3,98,18.0,9.0,64900.0,1830.0,22.1,3.72,2360.0,193.0,2710.0,328.0,150.0,1550000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(39,'MB 600',121.0,154.0,600.0,210.0,12.0,20.3,98,20.0,10.0,90200.0,2570.0,24.1,4.08,3000.0,245.0,3450.0,418.0,198.0,2630000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(40,'NPB 100 X 55 X 8.1',8.1,10.3,100.0,55.0,4.1,5.7,90,7.0,0.0,171.0,15.9,4.07,1.24,34.2,5.78,39.4,9.14,1.15,351.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(41,'NPB 120 X 60 X 10.37',10.37,13.2,120.0,64.0,4.4,6.3,90,7.0,0.0,317.0,27.6,4.9,1.44,52.9,8.64,60.7,13.5,1.69,889.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(42,'NPB 140 X 70 X 12.89',12.89,16.4,140.0,73.0,4.7,6.9,90,7.0,0.0,541.0,44.9,5.74,1.65,77.3,12.3,88.3,19.2,2.4,1980.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(43,'NPB 160 X 80 X 15.77',15.77,20.0,160.0,82.0,5.0,7.4,90,9.0,0.0,869.0,68.3,6.57,1.84,108.0,16.6,123.0,26.1,3.54,3950.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(44,'NPB 180 X 90 X 15.37',15.37,19.5,177.0,91.0,4.3,6.5,90,9.0,0.0,1060.0,81.8,7.36,2.04,120.0,17.9,135.0,27.9,2.67,5930.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(45,'NPB 180 X 90 X 18.8',18.8,23.9,180.0,91.0,5.3,8.0,90,9.0,0.0,1310.0,100.0,7.41,2.05,146.0,22.1,166.0,34.6,4.72,7430.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(46,'NPB 180 X 90 X 21.27',21.27,27.0,182.0,92.0,6.0,9.0,90,9.0,0.0,1500.0,117.0,7.45,2.08,165.0,25.4,189.0,39.9,6.64,8730.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(47,'NPB 200 X 100 X 18.43',18.43,23.4,197.0,100.0,4.5,7.0,90,12.0,0.0,1590.0,117.0,8.23,2.23,161.0,23.4,181.0,36.5,4.13,10500.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(48,'NPB 200 X 100 X 22.36',22.36,28.4,200.0,100.0,5.6,8.5,90,12.0,0.0,1940.0,142.0,8.26,2.23,194.0,28.4,220.0,44.6,6.92,12900.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(49,'NPB 200 X 100 X 25.09',25.09,31.9,202.0,102.0,6.2,9.5,90,12.0,0.0,2210.0,168.0,8.31,2.29,218.0,33.1,249.0,51.8,9.36,15500.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(50,'NPB 200 X 130 X 27.37',27.37,34.8,207.0,133.0,5.8,8.5,90,12.0,0.0,2660.0,334.0,8.74,3.09,257.0,50.2,288.0,77.4,8.48,32800.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(51,'NPB 200 X 130 X 31.56',31.56,40.1,210.0,134.0,6.4,10.0,90,12.0,0.0,3150.0,401.0,8.85,3.16,300.0,59.9,337.0,92.4,12.8,40100.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(52,'NPB 200 X 150 X 30.46',30.46,38.7,194.0,150.0,6.0,9.0,90,12.0,0.0,2670.0,507.0,8.3,3.61,275.0,67.6,306.0,103.0,10.4,43300.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(53,'NPB 200 X 165 X 35.69',35.69,45.4,201.0,165.0,6.2,10.0,90,12.0,0.0,3410.0,749.0,8.66,4.06,339.0,90.8,376.0,138.0,14.5,68200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(54,'NPB 200 X 165 X 42.48',42.48,54.1,205.0,166.0,7.2,12.0,90,12.0,0.0,4160.0,915.0,8.77,4.11,406.0,110.0,454.0,168.0,24.1,85100.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(55,'NPB 200 X 165 X 48.0',48.0,61.1,210.0,166.0,6.5,14.5,90,12.0,0.0,5020.0,1100.0,9.06,4.25,478.0,133.0,534.0,202.0,37.9,105000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(56,'NPB 220 X 110 X 22.18',22.18,28.2,217.0,110.0,5.0,7.7,90,12.0,0.0,2310.0,171.0,9.05,2.46,213.0,31.1,240.0,48.4,5.68,18700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(57,'NPB 220 X 110 X 26.2',26.2,33.3,220.0,110.0,5.9,9.2,90,12.0,0.0,2770.0,204.0,9.11,2.47,251.0,37.2,285.0,58.1,9.03,22600.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(58,'NPB 220 X 110 X 29.35',29.35,37.3,222.0,112.0,6.6,10.2,90,12.0,0.0,3130.0,239.0,9.15,2.53,282.0,42.8,321.0,66.9,12.1,26700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(59,'NPB 240 X 120 X 26.15',26.15,33.3,237.0,120.0,5.2,8.3,90,15.0,0.0,3290.0,240.0,9.93,2.68,277.0,40.0,311.0,62.3,8.51,31200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(60,'NPB 240 X 120 X 30.71',30.71,39.1,240.0,120.0,6.2,9.8,90,15.0,0.0,3890.0,283.0,9.97,2.69,324.0,47.2,366.0,73.9,12.9,37300.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(61,'NPB 240 X 120 X 34.32',34.32,43.7,242.0,122.0,7.0,10.8,90,15.0,0.0,4360.0,328.0,9.99,2.74,361.0,53.8,410.0,84.3,17.1,43600.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(62,'NPB 250 X 125 X 30.11',30.11,38.3,250.0,125.0,6.0,9.0,90,15.0,0.0,4130.0,294.0,10.3,2.77,331.0,47.0,373.0,73.6,11.1,42500.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(63,'NPB 250 X 150 X 34.08',34.08,43.4,258.0,146.0,6.1,9.2,90,15.0,0.0,5120.0,478.0,10.8,3.32,396.0,65.5,444.0,101.0,12.8,73800.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(64,'NPB 250 X 150 X 39.78',39.78,50.6,262.0,147.0,6.6,11.2,90,15.0,0.0,6200.0,594.0,11.0,3.42,473.0,80.8,530.0,124.0,20.3,93200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(65,'NPB 250 X 150 X 46.48',46.48,59.2,266.0,148.0,7.6,13.2,90,15.0,0.0,7380.0,715.0,11.1,3.47,554.0,96.6,625.0,149.0,31.5,113000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(66,'NPB 250 X 175 X 43.94',43.94,55.9,244.0,175.0,7.0,11.0,90,15.0,0.0,6090.0,984.0,10.4,4.19,499.0,112.0,555.0,172.0,22.4,133000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(67,'NPB 270 X 135 X 30.73',30.73,39.1,267.0,135.0,5.5,8.7,90,15.0,0.0,4910.0,357.0,11.2,3.02,368.0,53.0,412.0,82.3,10.4,59500.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(68,'NPB 270 X 135 X 36.07',36.07,45.9,270.0,135.0,6.6,10.2,90,15.0,0.0,5780.0,419.0,11.2,3.02,428.0,62.2,483.0,96.9,15.9,70500.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(69,'NPB 270 X 135 X 42.26',42.26,53.8,274.0,136.0,7.5,12.2,90,15.0,0.0,6940.0,513.0,11.3,3.08,507.0,75.5,574.0,117.0,25.0,87600.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(70,'NPB 300 X 150 X 36.53',36.53,46.5,297.0,150.0,6.1,9.2,90,15.0,0.0,7170.0,518.0,12.4,3.34,483.0,69.1,541.0,107.0,13.3,107000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(71,'NPB 300 X 150 X 42.24',42.24,53.8,300.0,150.0,7.1,10.7,90,15.0,0.0,8350.0,603.0,12.4,3.35,557.0,80.5,628.0,125.0,19.9,125000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(72,'NPB 300 X 150 X 49.32',49.32,62.8,304.0,152.0,8.0,12.7,90,15.0,0.0,9990.0,745.0,12.6,3.44,657.0,98.1,743.0,152.0,30.9,157000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(73,'NPB 300 X 165 X 39.88',39.88,50.7,310.0,165.0,5.8,9.7,90,15.0,0.0,8790.0,727.0,13.1,3.78,567.0,88.1,630.0,135.0,15.4,163000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(74,'NPB 300 X 165 X 45.76',45.76,58.2,313.0,166.0,6.6,11.2,90,15.0,0.0,10200.0,855.0,13.2,3.83,652.0,103.0,727.0,158.0,22.5,194000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(75,'NPB 300 X 165 X 53.46',53.46,68.1,317.0,167.0,7.6,13.2,90,15.0,0.0,12100.0,1020.0,13.3,3.88,764.0,122.0,857.0,189.0,35.2,236000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(76,'NPB 300 X 200 X 59.57',59.57,75.8,303.0,203.0,7.5,13.1,90,15.0,0.0,12800.0,1820.0,13.0,4.9,848.0,180.0,940.0,275.0,39.5,383000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(77,'NPB 300 X 200 X 66.75',66.75,85.0,306.0,204.0,8.5,14.6,90,15.0,0.0,14500.0,2060.0,13.0,4.93,948.0,202.0,1050.0,310.0,54.3,438000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(78,'NPB 300 X 200 X 75.37',75.37,96.0,310.0,205.0,9.4,16.6,90,15.0,0.0,16600.0,2380.0,13.1,4.98,1070.0,232.0,1200.0,356.0,77.6,512000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(79,'NPB 330 X 160 X 42.97',42.97,54.7,327.0,160.0,6.5,10.0,90,18.0,0.0,10200.0,685.0,13.6,3.53,625.0,85.6,701.0,133.0,19.6,171000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(80,'NPB 330 X 160 X 49.15',49.15,62.6,330.0,160.0,7.5,11.5,90,18.0,0.0,11700.0,788.0,13.7,3.54,713.0,98.5,804.0,153.0,28.0,199000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(81,'NPB 330 X 160 X 57.01',57.01,72.6,334.0,162.0,8.5,13.5,90,18.0,0.0,13900.0,960.0,13.8,3.63,832.0,118.0,942.0,184.0,42.2,245000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(82,'NPB 350 X 170 X 50.22',50.22,63.9,357.6,170.0,6.6,11.5,90,18.0,0.0,14500.0,944.0,15.0,3.84,811.0,111.0,906.0,171.0,27.3,281000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(83,'NPB 350 X 170 X 57.1',57.1,72.7,360.0,170.0,8.0,12.7,90,18.0,0.0,16200.0,1040.0,14.9,3.78,903.0,122.0,1010.0,191.0,37.4,313000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(84,'NPB 350 X 170 X 66.05',66.05,84.1,364.0,172.0,9.2,14.7,90,18.0,0.0,19000.0,1250.0,15.0,3.85,1040.0,145.0,1180.0,226.0,55.7,380000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(85,'NPB 350 X 250 X 79.18',79.18,100.0,340.0,250.0,9.0,14.0,90,18.0,0.0,21500.0,3650.0,14.6,6.01,1260.0,292.0,1400.0,446.0,63.4,968000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(86,'NPB 400 X 180 X 57.38',57.38,73.0,397.0,180.0,7.0,12.0,90,21.0,0.0,20200.0,1170.0,16.6,4.0,1020.0,130.0,1140.0,202.0,36.1,432000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(87,'NPB 400 X 180 X 66.31',66.31,84.4,400.0,180.0,8.6,13.5,90,21.0,0.0,23100.0,1310.0,16.5,3.95,1150.0,146.0,1300.0,229.0,51.3,490000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(88,'NPB 400 X 180 X 75.67',75.67,96.3,404.0,182.0,9.7,15.5,90,21.0,0.0,26700.0,1560.0,16.6,4.02,1320.0,171.0,1500.0,269.0,73.3,587000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(89,'NPB 400 X 200 X 67.28',67.28,85.7,400.0,200.0,8.0,13.0,90,21.0,0.0,24200.0,1730.0,16.8,4.5,1210.0,173.0,1350.0,269.0,48.5,648000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(90,'NPB 450 X190 X 67.16',67.16,85.5,447.0,190.0,7.6,13.1,90,21.0,0.0,29700.0,1500.0,18.6,4.19,1330.0,158.0,1490.0,245.0,47.1,704000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(91,'NPB 450 X 190 X 77.58',77.58,98.8,450.0,190.0,9.4,14.6,90,21.0,0.0,33700.0,1670.0,18.4,4.11,1490.0,176.0,1700.0,276.0,66.7,791000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(92,'NPB 450 X 190 X 92.37',92.37,117.0,456.0,192.0,11.0,17.6,90,21.0,0.0,40900.0,2080.0,18.6,4.21,1790.0,217.0,2040.0,340.0,109.0,997000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(93,'NPB 500 X 200 X 79.36',79.36,101.0,497.0,200.0,8.4,14.5,90,21.0,0.0,42900.0,1930.0,20.6,4.38,1720.0,193.0,1940.0,301.0,64.3,1120000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(94,'NPB 500 X 200 X 90.69',90.69,115.0,500.0,200.0,10.2,16.0,90,21.0,0.0,48100.0,2140.0,20.4,4.3,1920.0,214.0,2190.0,335.0,89.1,1240000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(95,'NPB 500 X 200 X 107.32',107.32,136.0,506.0,202.0,12.0,19.0,90,21.0,0.0,57700.0,2620.0,20.5,4.37,2280.0,259.0,2610.0,408.0,142.0,1540000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(96,'NPB 550 X 210 X 92.08',92.08,117.0,547.0,210.0,9.0,15.7,90,24.0,0.0,59900.0,2430.0,22.6,4.55,2190.0,231.0,2470.0,361.0,89.3,1710000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(97,'NPB 550 X 210 X 105.52',105.52,134.0,550.0,210.0,11.1,17.2,90,24.0,0.0,67100.0,2660.0,22.3,4.45,2440.0,254.0,2780.0,400.0,122.0,1880000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(98,'NPB 550 X 210 X 122.52',122.52,156.0,556.0,212.0,12.7,20.2,90,24.0,0.0,79100.0,3220.0,22.5,4.54,2840.0,304.0,3260.0,480.0,187.0,2299999.9999999993782,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(99,'NPB 600 X 220 X 107.57',107.57,137.0,597.0,220.0,9.8,17.5,90,24.0,0.0,82900.0,3110.0,24.6,4.76,2770.0,283.0,3140.0,442.0,122.0,2600000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(100,'NPB 600 X 220 X 122.45',122.45,155.0,600.0,220.0,12.0,19.0,90,24.0,0.0,92000.0,3380.0,24.2,4.66,3060.0,307.0,3510.0,485.0,165.0,2840000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(101,'NPB 600 X 220 X 154.47',154.47,196.0,610.0,224.0,15.0,24.0,90,24.0,0.0,118000.0,4520.0,24.5,4.79,3870.0,403.0,4470.0,640.0,316.0,3850000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(102,'NPB 700 X 250 X 113.46',113.46,144.0,694.0,250.0,9.0,16.0,90,24.0,0.0,118000.0,4170.0,28.6,5.37,3420.0,334.0,3850.0,518.0,107.0,4780000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(103,'NPB 700 X 250 X 128.41',128.41,163.0,695.0,250.0,11.5,16.5,90,24.0,0.0,128000.0,4310.0,27.9,5.13,3680.0,344.0,4210.0,543.0,136.0,4940000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(104,'NPB 700 X 250 X 143.42',143.42,182.0,700.0,250.0,12.5,19.0,90,24.0,0.0,145000.0,4960.0,28.2,5.21,4160.0,397.0,4760.0,625.0,190.0,5730000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(105,'NPB 700 X 250 X 153.87',153.87,196.0,704.0,250.0,13.0,21.0,90,24.0,0.0,159000.0,5480.0,28.4,5.29,4520.0,439.0,5170.0,690.0,240.0,6370000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(106,'NPB 700 X 250 X 171.48',171.48,218.0,709.0,250.0,14.5,23.5,90,24.0,0.0,178000.0,6140.0,28.5,5.3,5030.0,491.0,5770.0,775.0,328.0,7180000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(107,'NPB 750 X 270 X 145.29',145.29,185.0,750.0,265.0,13.2,16.6,90,17.0,0.0,161000.0,5160.0,29.5,5.28,4310.0,389.0,5000.0,616.0,150.0,6920000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(108,'NPB 750 X 270 X 174.54',174.54,222.0,760.0,270.0,14.4,21.6,90,17.0,0.0,206000.0,7100.0,30.4,5.65,5430.0,526.0,6240.0,827.0,272.0,9650000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(109,'NPB 750 X 270 X 202.49',202.49,257.0,770.0,270.0,15.6,26.6,90,17.0,0.0,249000.0,8750.0,31.1,5.82,6480.0,648.0,7430.0,1010.0,450.0,11999999.999999999644,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(110,'WB 150',17.0,21.6,150.0,100.0,5.4,7.0,96,8.0,4.0,839.0,94.7,6.22,2.09,111.0,18.9,126.0,31.9,4.22,5960.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(111,'WB 175',22.06,28.1,175.0,125.0,5.8,7.4,96,8.0,4.0,1510.0,188.0,7.32,2.59,172.0,30.1,194.0,51.2,6.22,16900.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(112,'WB 200',28.8,36.7,200.0,140.0,6.1,9.0,96,9.0,4.5,2620.0,328.0,8.45,2.99,262.0,46.9,294.0,78.7,11.3,37500.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(113,'WB 200',52.09,66.4,203.0,152.0,8.9,16.5,98,15.5,7.6,4780.0,809.0,8.48,3.49,470.0,106.0,539.0,175.0,65.8,83900.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(114,'WB 225',33.93,43.2,225.0,150.0,6.4,9.9,96,9.0,4.5,3920.0,448.0,9.52,3.22,348.0,59.8,389.0,99.7,15.5,64400.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(115,'WB 250',40.84,52.0,250.0,200.0,6.7,9.0,96,10.0,5.0,5940.0,857.0,10.6,4.05,475.0,85.7,527.0,149.0,17.8,174000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(116,'WB 300',48.12,61.3,300.0,200.0,7.4,10.0,96,11.0,5.5,9820.0,990.0,12.6,4.01,654.0,99.0,731.0,171.0,24.7,280000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(117,'WB 350',56.89,72.4,350.0,200.0,8.0,11.4,96,12.0,6.0,15500.0,1170.0,14.6,4.02,887.0,117.0,995.0,200.0,35.6,435000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(118,'WB 400',66.71,85.0,400.0,200.0,8.6,13.0,96,13.0,6.5,23400.0,1380.0,16.6,4.04,1170.0,138.0,1320.0,234.0,50.6,648000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(119,'WB 450',79.52,101.0,450.0,200.0,9.2,15.4,96,15.0,7.0,35100.0,1700.0,18.6,4.1,1560.0,170.0,1760.0,284.0,78.7,969000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(120,'WB 500',95.12,121.0,500.0,250.0,9.9,14.7,96,15.0,7.5,52200.0,2980.0,20.7,4.96,2090.0,239.0,2350.0,406.0,94.3,2250000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(121,'WB 550',112.48,143.0,550.0,250.0,10.5,17.6,96,16.0,8.0,74900.0,3740.0,22.8,5.1,2720.0,299.0,3060.0,500.0,145.0,3240000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(122,'WB 600',133.7,170.0,600.0,250.0,11.2,21.3,96,17.0,8.5,106000.0,4700.0,24.9,5.25,3540.0,376.0,3980.0,619.0,234.0,4640000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(123,'WB 600',145.06,184.0,600.0,250.0,11.8,23.6,96,18.0,9.0,115000.0,5290.0,25.0,5.35,3850.0,423.0,4340.0,692.0,305.0,5099999.9999999996447,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(124,'WPB 100 X 100 X 12.24',12.24,15.5,91.0,100.0,4.2,5.5,90,12.0,0.0,236.0,92.0,3.89,2.43,51.9,18.4,58.3,28.4,2.32,1670.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(125,'WPB 100 X 100 X 16.67',16.67,21.2,96.0,100.0,5.0,8.0,90,12.0,0.0,349.0,133.0,4.05,2.51,72.7,26.7,83.0,41.1,5.28,2580.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(126,'WPB 100 X 100 X 20.44',20.44,26.0,100.0,100.0,6.0,10.0,90,12.0,0.0,449.0,167.0,4.15,2.53,89.9,33.4,104.0,51.4,9.33,3370.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(127,'WPB 100 X 100 X 41.79',41.79,53.2,120.0,106.0,12.0,20.0,90,12.0,0.0,1140.0,399.0,4.63,2.73,190.0,75.3,235.0,116.0,67.2,9920.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(128,'WPB 120 X 120 X 14.56',14.56,18.5,109.0,120.0,4.2,5.5,90,12.0,0.0,413.0,158.0,4.72,2.92,75.8,26.4,84.1,40.6,2.59,4240.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(129,'WPB 120 X 120 X 19.89',19.89,25.3,114.0,120.0,5.0,8.0,90,12.0,0.0,606.0,230.0,4.89,3.01,106.0,38.4,119.0,58.8,6.04,6470.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(130,'WPB 120 X 120 X 26.7',26.7,34.0,120.0,120.0,6.5,11.0,90,12.0,0.0,864.0,317.0,5.04,3.05,144.0,52.9,165.0,80.9,13.9,9400.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(131,'WPB 120 X 120 X 52.13',52.13,66.4,140.0,126.0,12.5,21.0,90,12.0,0.0,2010.0,702.0,5.51,3.25,288.0,111.0,350.0,171.0,90.5,24700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(132,'WPB 140 X 140 X 18.08',18.08,23.0,128.0,140.0,4.3,6.0,90,12.0,0.0,719.0,274.0,5.59,3.45,112.0,39.2,123.0,59.9,3.43,10200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(133,'WPB 140 X 140 X 24.66',24.66,31.4,133.0,140.0,5.5,8.5,90,12.0,0.0,1030.0,389.0,5.73,3.52,155.0,55.6,173.0,84.8,8.1,15000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(134,'WPB 140 X 140 X 33.72',33.72,42.9,140.0,140.0,7.0,12.0,90,12.0,0.0,1500.0,549.0,5.92,3.57,215.0,78.5,245.0,119.0,20.1,22400.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(135,'WPB 140 X 140 X 63.24',63.24,80.5,160.0,146.0,13.0,22.0,90,12.0,0.0,3290.0,1140.0,6.39,3.76,411.0,156.0,493.0,240.0,118.0,54300.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(136,'WPB 150 X 150 X 23.5',23.5,29.9,152.0,152.0,5.8,6.8,90,12.0,0.0,1270.0,398.0,6.52,3.64,167.0,52.4,186.0,80.4,5.55,20900.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(137,'WPB 150 X 150 X 30.11',30.11,38.3,158.0,153.0,6.5,9.4,90,8.0,0.0,1760.0,561.0,6.77,3.82,222.0,73.4,248.0,111.0,10.6,30900.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(138,'WPB 150 X 150 X 36.97',36.97,47.0,162.0,154.0,8.0,11.5,90,8.0,0.0,2210.0,700.0,6.85,3.85,273.0,91.0,308.0,138.0,19.2,39600.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(139,'WPB 160 X 160 X 22.75',22.75,28.9,148.0,160.0,4.5,7.0,90,8.0,0.0,1220.0,478.0,6.5,4.06,165.0,59.7,181.0,90.5,4.54,23700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(140,'WPB 160 X 160 X 30.44',30.44,38.7,152.0,160.0,6.0,9.0,90,15.0,0.0,1670.0,615.0,6.56,3.98,220.0,76.9,245.0,117.0,12.1,31400.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(141,'WPB 160 X 160 X 42.59',42.59,54.2,160.0,160.0,8.0,13.0,90,15.0,0.0,2490.0,889.0,6.77,4.04,311.0,111.0,353.0,169.0,31.2,47900.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(142,'WPB 160 X 160 X 76.19',76.19,97.0,180.0,166.0,14.0,23.0,90,15.0,0.0,5090.0,1750.0,7.24,4.25,566.0,211.0,674.0,325.0,160.0,108000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(143,'WPB 180 X 180 X 28.68',28.68,36.5,167.0,180.0,5.0,7.5,90,15.0,0.0,1960.0,729.0,7.33,4.47,235.0,81.1,258.0,123.0,8.32,46300.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(144,'WPB 180 X 180 X 35.52',35.52,45.2,171.0,180.0,6.0,9.5,90,15.0,0.0,2510.0,924.0,7.44,4.52,293.0,102.0,324.0,156.0,14.9,60200.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(145,'WPB 180 X 180 X 51.22',51.22,65.2,180.0,180.0,8.5,14.0,90,15.0,0.0,3830.0,1360.0,7.66,4.57,425.0,151.0,481.0,231.0,42.2,93700.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(146,'WPB 180 X180 X 88.9',88.9,113.0,200.0,186.0,14.5,24.0,90,15.0,0.0,7480.0,2580.0,8.12,4.77,748.0,277.0,883.0,425.0,201.0,199000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(147,'WPB 200 X 200 X 34.65',34.65,44.1,186.0,200.0,5.5,8.0,90,18.0,0.0,2940.0,1060.0,8.16,4.92,316.0,106.0,347.0,163.0,12.5,84400.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(148,'WPB 200 X 200 X 37.34',37.34,47.6,200.0,200.0,6.1,8.9,90,10.0,0.0,3628.0,1187.0,8.73,5.0,363.0,119.0,398.0,180.0,13.3,NULL,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(149,'WPB 200 X 200 X 42.26',42.26,53.8,190.0,200.0,6.5,10.0,90,18.0,0.0,3690.0,1330.0,8.28,4.98,388.0,133.0,429.0,203.0,21.0,108000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(150,'WPB 200 X 200 X 50.92',50.92,64.8,194.0,202.0,8.0,12.0,90,18.0,0.0,4530.0,1650.0,8.35,5.04,467.0,163.0,521.0,249.0,34.3,136000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(151,'WPB 200 X 200 X 61.3',61.3,78.0,200.0,200.0,9.0,15.0,90,18.0,0.0,5690.0,2000.0,8.54,5.06,569.0,200.0,642.0,305.0,59.7,171000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(152,'WPB 200 X 200 X 74.01',74.01,94.2,206.0,206.0,10.2,18.0,90,18.0,0.0,7170.0,2620.0,8.72,5.27,696.0,255.0,793.0,388.0,99.3,231000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(153,'WPB 200 X 200 X 83.52',83.52,106.0,209.0,209.0,13.0,19.5,90,18.0,0.0,8050.0,2970.0,8.7,5.28,771.0,284.0,888.0,435.0,134.0,266000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(154,'WPB 200 X 200 X 103.06',103.06,131.0,220.0,206.0,15.0,25.0,90,18.0,0.0,10600.0,3650.0,9.0,5.27,967.0,354.0,1130.0,543.0,257.0,346000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(155,'WPB 220 X 220 X 40.4',40.4,51.4,205.0,220.0,6.0,8.5,90,18.0,0.0,4170.0,1510.0,9.0,5.41,406.0,137.0,445.0,209.0,15.5,145000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(156,'WPB 220 X 220 X 50.51',50.51,64.3,210.0,220.0,7.0,11.0,90,18.0,0.0,5400.0,1950.0,9.16,5.51,515.0,177.0,568.0,270.0,28.6,193000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(157,'WPB 220 X 220 X 71.47',71.47,91.0,220.0,220.0,9.5,16.0,90,18.0,0.0,8090.0,2840.0,9.42,5.58,735.0,258.0,827.0,393.0,77.0,295000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(158,'WPB 220 X 220 X 115.61',115.61,147.0,226.0,226.0,15.5,26.0,90,18.0,0.0,12600.0,5010.0,9.28,5.83,1120.0,443.0,1310.0,677.0,311.0,500000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(159,'WPB 240 X 240 X 47.4',47.4,60.3,224.0,240.0,6.5,9.0,90,21.0,0.0,5830.0,2070.0,9.83,5.86,520.0,173.0,570.0,264.0,22.1,239000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(160,'WPB 240 X 240 X 60.32',60.32,76.8,230.0,240.0,7.5,12.0,90,21.0,0.0,7760.0,2760.0,10.0,6.0,675.0,230.0,744.0,351.0,42.1,328000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(161,'WPB 240 X 240 X 83.2',83.2,105.0,240.0,240.0,10.0,17.0,90,21.0,0.0,11200.0,3920.0,10.3,6.08,938.0,326.0,1050.0,498.0,103.0,486000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(162,'WPB 240 X 240 X 156.68',156.68,199.0,270.0,248.0,18.0,32.0,90,21.0,0.0,24200.0,8150.0,11.0,6.39,1790.0,657.0,2110.0,1000.0,626.0,1150000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(163,'WPB 250 X 250 X 67.22',67.22,85.6,247.0,252.0,11.0,11.1,90,24.0,0.0,9390.0,2960.0,10.4,5.89,760.0,235.0,851.0,364.0,51.3,411000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(164,'WPB 250 X 250 X 73.15',73.15,93.1,252.0,250.0,9.0,13.6,90,24.0,0.0,11000.0,3540.0,10.9,6.17,880.0,283.0,977.0,434.0,67.6,503000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(165,'WPB 250 X 250 X 85.04',85.04,108.0,253.0,255.0,14.0,14.1,90,24.0,0.0,12100.0,3910.0,10.5,6.0,961.0,306.0,1080.0,475.0,95.6,555000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(166,'WPB 250 X 250 X 97.04',97.04,123.0,260.0,256.0,12.7,17.6,90,24.0,0.0,15000.0,4930.0,11.0,6.31,1150.0,385.0,1300.0,591.0,140.0,722000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(167,'WPB 250 X 250 X 103.97',103.97,132.0,264.0,257.0,11.9,19.6,90,24.0,0.0,16700.0,5550.0,11.2,6.47,1270.0,432.0,1430.0,660.0,174.0,828000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(168,'WPB 250 X 250 X 117.58',117.58,149.0,269.0,259.0,13.5,22.1,90,24.0,0.0,19300.0,6410.0,11.3,6.54,1430.0,495.0,1630.0,757.0,244.0,975000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(169,'WPB 250 X 250 X 133.92',133.92,170.0,275.0,261.0,15.4,25.1,90,24.0,0.0,22500.0,7450.0,11.4,6.61,1640.0,571.0,1880.0,874.0,351.0,1160000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(170,'WPB 250 X 250 X 148.38',148.38,189.0,280.0,263.0,17.3,27.6,90,24.0,0.0,25400.0,8380.0,11.5,6.66,1810.0,637.0,2100.0,978.0,466.0,1330000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(171,'WPB 260 X 260 X 54.15',54.15,68.9,244.0,260.0,6.5,9.5,90,24.0,0.0,7980.0,2780.0,10.7,6.35,654.0,214.0,714.0,327.0,30.1,382000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(172,'WPB 260 X 260 X 68.16',68.16,86.8,250.0,260.0,7.5,12.5,90,24.0,0.0,10400.0,3660.0,10.9,6.5,836.0,282.0,919.0,430.0,54.2,516000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(173,'WPB 260 X 260 X 92.99',92.99,118.0,260.0,260.0,10.0,17.5,90,24.0,0.0,14900.0,5130.0,11.2,6.58,1140.0,394.0,1280.0,602.0,126.0,753000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(174,'WPB 260 X 260 X 114.4',114.4,145.0,268.0,262.0,12.5,21.5,90,24.0,0.0,18900.0,6450.0,11.3,6.65,1410.0,492.0,1590.0,752.0,224.0,978000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(175,'WPB 260 X 260 X 141.52',141.52,180.0,278.0,265.0,15.5,26.5,90,24.0,0.0,24300.0,8230.0,11.6,6.75,1750.0,621.0,2010.0,950.0,407.0,1290000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(176,'WPB 260 X 260 X 172.43',172.43,219.0,290.0,268.0,18.0,32.5,90,24.0,0.0,31300.0,10400.0,11.9,6.89,2150.0,779.0,2520.0,1190.0,720.0,1720000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(177,'WPB 280 X 280 X 61.26',61.26,78.0,264.0,280.0,7.0,10.0,90,24.0,0.0,10500.0,3660.0,11.6,6.85,799.0,261.0,873.0,399.0,35.5,590000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(178,'WPB 280 X 280 X 76.36',76.36,97.2,270.0,280.0,8.0,13.0,90,24.0,0.0,13600.0,4760.0,11.8,6.99,1010.0,340.0,1110.0,518.0,63.5,785000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(179,'WPB 280 X 280 X 188.54',188.54,240.0,310.0,288.0,18.5,33.0,90,24.0,0.0,39500.0,13100.0,12.8,7.4,2550.0,914.0,2960.0,1390.0,807.0,2520000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(180,'WPB 280 X 280 X 284.13',284.13,361.95,280.0,280.0,10.5,18.0,90,24.0,0.0,30682.9,9105.2,9.21,5.02,2191.6,650.4,2941.1,1406.8,146.0,1130000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(181,'WPB 300 X 300 X 69.8',69.8,88.9,283.0,300.0,7.5,10.5,90,27.0,0.0,13800.0,4730.0,12.4,7.29,975.0,315.0,1060.0,482.0,47.8,877000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(182,'WPB 300 X 300 X 88.34',88.34,112.0,290.0,300.0,8.5,14.0,90,27.0,0.0,18200.0,6300.0,12.7,7.48,1250.0,420.0,1380.0,641.0,87.8,1190000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(183,'WPB 300 X 300 X 100.85',100.85,128.0,294.0,300.0,10.0,16.0,90,27.0,0.0,21000.0,7210.0,12.8,7.49,1430.0,480.0,1580.0,733.0,124.0,1390000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(184,'WPB 300 X 300 X 117.03',117.03,149.0,300.0,300.0,11.0,19.0,90,27.0,0.0,25100.0,8560.0,12.9,7.57,1670.0,570.0,1860.0,870.0,189.0,1680000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(185,'WPB 300 X 300 X 237.92',237.92,303.0,340.0,310.0,21.0,39.0,90,27.0,0.0,59200.0,19400.0,13.9,8.0,3480.0,1250.0,4070.0,1910.0,1410.0,4380000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(186,'WPB 320 X 300 X 74.25',74.25,94.5,301.0,300.0,8.0,11.0,90,27.0,0.0,16400.0,4950.0,13.1,7.24,1090.0,330.0,1190.0,505.0,53.6,1040000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(187,'WPB 320 X 300 X 97.64',97.64,124.0,310.0,300.0,9.0,15.5,90,27.0,0.0,22900.0,6980.0,13.5,7.49,1470.0,465.0,1620.0,709.0,111.0,1510000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(188,'WPB 320 X 300 X 126.66',126.66,161.0,320.0,300.0,11.5,20.5,90,27.0,0.0,30800.0,9230.0,13.8,7.56,1920.0,615.0,2140.0,939.0,230.0,2060000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(189,'WPB 320 X 300 X 244.97',244.97,312.0,359.0,309.0,21.0,40.0,90,27.0,0.0,68100.0,19700.0,14.7,7.94,3790.0,1270.0,4430.0,1950.0,1500.0,5000000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(190,'WPB 340 X 300 X 78.9',78.9,100.0,320.0,300.0,8.5,11.5,90,27.0,0.0,19500.0,5180.0,13.9,7.18,1220.0,345.0,1340.0,529.0,60.1,1230000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(191,'WPB 340 X 300 X 104.78',104.78,133.0,330.0,300.0,9.5,16.5,90,27.0,0.0,27600.0,7430.0,14.4,7.46,1670.0,495.0,1850.0,755.0,131.0,1820000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(192,'WPB 340 X 300 X 134.16',134.16,170.0,340.0,300.0,12.0,21.5,90,27.0,0.0,36600.0,9680.0,14.6,7.53,2150.0,645.0,2400.0,985.0,262.0,2450000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(193,'WPB 340 X 300 X 290.64',290.64,315.0,377.0,309.0,21.0,40.0,90,27.0,0.0,76300.0,19700.0,15.5,7.9,4050.0,1270.0,4710.0,1950.0,1510.0,5580000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(194,'WPB 360 X 300 X 91.04',91.04,106.0,339.0,300.0,9.0,12.0,90,27.0,0.0,23000.0,5410.0,14.7,7.12,1350.0,360.0,1490.0,552.0,67.2,1440000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(195,'WPB 360 X 300 X 125.81',125.81,142.0,350.0,300.0,10.0,17.5,90,27.0,0.0,33000.0,7880.0,15.2,7.43,1890.0,525.0,2080.0,802.0,153.0,2170000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(196,'WPB 360 X 300 X 163.0',163.0,180.0,360.0,300.0,12.5,22.5,90,27.0,0.0,43100.0,10100.0,15.4,7.49,2390.0,676.0,2680.0,1030.0,298.0,2880000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(197,'WPB 360 X 300 X 250.27',250.27,318.0,395.0,308.0,21.0,40.0,90,27.0,0.0,84800.0,19500.0,16.3,7.82,4290.0,1260.0,4980.0,1940.0,1510.0,6130000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(198,'WPB 360 X 370 X 136.21',136.21,173.0,356.0,369.0,11.2,17.8,90,27.0,0.0,42100.0,14900.0,15.5,9.27,2360.0,808.0,2600.0,1220.0,192.0,4260000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(199,'WPB 360 X 370 X 150.87',150.87,192.0,360.0,370.0,12.3,19.8,90,27.0,0.0,47300.0,16700.0,15.6,9.33,2620.0,904.0,2900.0,1370.0,256.0,4830000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(200,'WPB 360 X 370 X 165.35',165.35,210.0,364.0,371.0,13.3,21.8,90,27.0,0.0,52500.0,18500.0,15.7,9.39,2880.0,1000.0,3200.0,1520.0,333.0,5430000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(201,'WPB 360 X 370 X 182.02',182.02,231.0,368.0,373.0,15.0,23.8,90,27.0,0.0,58200.0,20600.0,15.8,9.42,3160.0,1100.0,3530.0,1680.0,432.0,6090000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(202,'WPB 360 X 370 X 197.66',197.66,251.0,372.0,374.0,16.4,25.8,90,27.0,0.0,63900.0,22500.0,15.9,9.45,3430.0,1200.0,3850.0,1830.0,546.0,6740000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(203,'WPB 400 X 300 X 92.4',92.4,117.0,378.0,300.0,9.5,13.0,90,27.0,0.0,31200.0,5860.0,16.2,7.05,1650.0,390.0,1820.0,599.0,81.4,1940000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(204,'WPB 400 X 300 X 124.81',124.81,158.0,390.0,300.0,11.0,19.0,90,27.0,0.0,45000.0,8560.0,16.8,7.33,2310.0,570.0,2560.0,872.0,193.0,2940000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(205,'WPB 400 X 300 X 155.26',155.26,197.0,400.0,300.0,13.5,24.0,90,27.0,0.0,57600.0,10800.0,17.0,7.39,2880.0,721.0,3230.0,1100.0,361.0,3810000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(206,'WPB 400 X 300 X 255.74',255.74,325.0,432.0,307.0,21.0,40.0,90,27.0,0.0,104000.0,19300.0,17.8,7.7,4820.0,1250.0,5570.0,1930.0,1520.0,7410000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(207,'WPB 400 X 400 X 191.11',191.11,243.0,368.0,391.0,15.0,24.2,90,27.0,0.0,61500.0,24100.0,15.9,9.95,3340.0,1230.0,3730.0,1870.0,467.0,7120000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(208,'WPB 400 X 400 X 219.67',219.67,279.0,375.0,394.0,17.3,27.7,90,27.0,0.0,72100.0,28200.0,16.0,10.0,3840.0,1430.0,4320.0,2180.0,691.0,8510000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(209,'WPB 400 X 400 X 239.62',239.62,305.0,380.0,395.0,18.9,30.2,90,27.0,0.0,79700.0,31000.0,16.1,10.0,4190.0,1570.0,4750.0,2390.0,887.0,9480000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(210,'WPB 450 X 300 X 99.75',99.75,127.0,425.0,300.0,10.0,13.5,90,27.0,0.0,41800.0,6080.0,18.1,6.92,1970.0,405.0,2180.0,624.0,91.4,2570000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(211,'WPB 450 X 300 X 139.76',139.76,178.0,440.0,300.0,11.5,21.0,90,27.0,0.0,63700.0,9460.0,18.9,7.29,2890.0,631.0,3210.0,965.0,250.0,4140000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(212,'WPB 450 X 300 X 171.12',171.12,217.0,450.0,300.0,14.0,26.0,90,27.0,0.0,79800.0,11700.0,19.1,7.33,3550.0,781.0,3980.0,1190.0,448.0,5250000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(213,'WPB 450 X 300 X 263.33',263.33,335.0,478.0,307.0,21.0,40.0,90,27.0,0.0,131000.0,19300.0,19.7,7.59,5500.0,1250.0,6330.0,1930.0,1530.0,9250000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(214,'WPB 500 X 300 X 107.46',107.46,136.0,472.0,300.0,10.5,14.0,90,27.0,0.0,54600.0,6310.0,19.9,6.79,2310.0,420.0,2570.0,649.0,102.0,3299999.9999999998223,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(215,'WPB 500 X 300 X 129.78',129.78,165.0,480.0,300.0,11.5,18.0,90,27.0,0.0,68900.0,8110.0,20.4,7.0,2870.0,541.0,3190.0,832.0,179.0,4320000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(216,'WPB 500 X 300 X 155.08',155.08,197.0,490.0,300.0,12.0,23.0,90,27.0,0.0,86900.0,10300.0,20.9,7.24,3540.0,691.0,3940.0,1050.0,317.0,5640000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(217,'WPB 500 X 300 X 187.34',187.34,238.0,500.0,300.0,14.5,28.0,90,27.0,0.0,107000.0,12600.0,21.1,7.27,4280.0,841.0,4810.0,1290.0,548.0,7010000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(218,'WPB 500 X 300 X 270.28',270.28,344.0,524.0,306.0,21.0,40.0,90,27.0,0.0,161000.0,19100.0,21.6,7.45,6180.0,1250.0,7090.0,1930.0,1540.0,11100000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(219,'WPB 550 X 300 X 119.99',119.99,152.0,522.0,300.0,11.5,15.0,90,27.0,0.0,72800.0,6760.0,21.8,6.65,2790.0,451.0,3120.0,698.0,126.0,4330000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(220,'WPB 550 X 300 X 166.24',166.24,211.0,540.0,300.0,12.5,24.0,90,27.0,0.0,111000.0,10800.0,22.9,7.14,4140.0,721.0,4620.0,1100.0,360.0,7180000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(221,'WPB 550 X 300 X 199.44',199.44,254.0,550.0,300.0,15.0,29.0,90,27.0,0.0,136000.0,13000.0,23.1,7.17,4970.0,871.0,5590.0,1340.0,610.0,8850000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(222,'WPB 550 X 300 X 278.19',278.19,354.0,572.0,306.0,21.0,40.0,90,27.0,0.0,197000.0,19100.0,23.6,7.35,6920.0,1250.0,7930.0,1930.0,1550.0,13500000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(223,'WPB 600 X300 X 128.79',128.79,164.0,571.0,300.0,12.0,15.5,90,27.0,0.0,91800.0,6990.0,23.6,6.52,3210.0,466.0,3620.0,724.0,141.0,5380000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(224,'WPB 600 X 300 X 177.78',177.78,226.0,590.0,300.0,13.0,25.0,90,27.0,0.0,141000.0,11200.0,24.9,7.05,4780.0,751.0,5350.0,1150.0,407.0,8970000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(225,'WPB 600 X 300 X 211.92',211.92,269.0,600.0,300.0,15.5,30.0,90,27.0,0.0,171000.0,13500.0,25.1,7.08,5700.0,902.0,6420.0,1390.0,677.0,10900000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(226,'WPB 600 X 300 X 285.48',285.48,363.0,620.0,305.0,21.0,40.0,90,27.0,0.0,237000.0,18900.0,25.5,7.22,7650.0,1240.0,8770.0,1930.0,1560.0,15900000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(227,'WPB 650 X 300 X 137.98',137.98,175.0,620.0,300.0,12.5,16.0,90,27.0,0.0,113000.0,7220.0,25.4,6.41,3670.0,481.0,4150.0,750.0,158.0,6560000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(228,'WPB 650 X 300 X 189.69',189.69,241.0,640.0,300.0,13.5,26.0,90,27.0,0.0,175000.0,11700.0,26.9,6.96,5470.0,781.0,6130.0,1200.0,457.0,11000000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(229,'WPB 650 X 300 X 224.78',224.78,286.0,650.0,300.0,16.0,31.0,90,27.0,0.0,210000.0,13900.0,27.1,6.98,6480.0,932.0,7310.0,1440.0,749.0,13300000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(230,'WPB 650 X 300 X 293.39',293.39,373.0,668.0,305.0,21.0,40.0,90,27.0,0.0,281000.0,18900.0,27.4,7.12,8430.0,1240.0,9650.0,1930.0,1580.0,18600000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(231,'WPB 700 X 300 X 149.89',149.89,190.0,670.0,300.0,13.0,17.0,90,27.0,0.0,142000.0,7670.0,27.3,6.33,4260.0,511.0,4840.0,799.0,186.0,8150000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(232,'WPB 700 X 300 X 204.48',204.48,260.0,690.0,300.0,14.5,27.0,90,27.0,0.0,215000.0,12100.0,28.7,6.83,6240.0,811.0,7030.0,1250.0,521.0,13300000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(233,'WPB 700 X 300 X 240.51',240.51,306.0,700.0,300.0,17.0,32.0,90,27.0,0.0,256000.0,14400.0,28.9,6.86,7330.0,962.0,8320.0,1490.0,839.0,16000000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(234,'WPB 700 X 300 X 300.68',300.68,383.0,716.0,304.0,21.0,40.0,90,27.0,0.0,329000.0,18700.0,29.3,7.0,9190.0,1230.0,10500.0,1920.0,1590.0,21299999.999999998934,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(235,'WPB 800 X 300 X 171.52',171.52,218.0,770.0,300.0,14.0,18.0,90,30.0,0.0,208000.0,8130.0,30.9,6.1,5420.0,542.0,6220.0,856.0,243.0,11399999.999999999023,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(236,'WPB 800 X 300 X 224.38',224.38,285.0,790.0,300.0,15.0,28.0,90,30.0,0.0,303000.0,12600.0,32.5,6.65,7680.0,842.0,8690.0,1310.0,608.0,18200000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(237,'WPB 800 X 300 X 262.34',262.34,334.0,800.0,300.0,17.5,33.0,90,30.0,0.0,359000.0,14900.0,32.7,6.67,8970.0,993.0,10200.0,1550.0,958.0,21800000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(238,'WPB 800 X 300 X 317.36',317.36,404.0,814.0,303.0,21.0,40.0,90,30.0,0.0,442000.0,18600.0,33.0,6.78,10800.0,1220.0,12400.0,1930.0,1650.0,27700000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(239,'WPB 800 X 300 X 179.9',179.9,229.0,835.0,292.0,14.0,18.8,90,30.0,0.0,253000.0,7830.0,33.2,5.84,6080.0,536.0,7000.0,851.0,264.0,12900000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(240,'WPB 850 X 300 X 195.74',195.74,249.0,840.0,292.0,14.7,21.3,90,30.0,0.0,282000.0,8870.0,33.6,5.96,6720.0,608.0,7730.0,961.0,343.0,14799999.999999999822,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(241,'WPB 850 X 300 X 214.25',214.25,272.0,846.0,293.0,15.4,24.3,90,30.0,0.0,317000.0,10200.0,34.1,6.12,7500.0,698.0,8600.0,1100.0,459.0,17099999.999999999644,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(242,'WPB 850 X 300 X 230.56',230.56,293.0,851.0,294.0,16.1,26.8,90,30.0,0.0,347000.0,11300.0,34.4,6.23,8160.0,775.0,9350.0,1220.0,579.0,19199999.999999999289,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(243,'WPB 850 X 300 X 253.69',253.69,323.0,859.0,292.0,17.0,30.8,90,30.0,0.0,392000.0,12800.0,34.8,6.3,9130.0,879.0,10400.0,1380.0,802.0,21899999.999999999467,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(244,'WPB 900 X 300 X 198.01',198.01,252.0,870.0,300.0,15.0,20.0,90,30.0,0.0,301000.0,9040.0,34.5,5.98,6920.0,602.0,7990.0,957.0,321.0,16200000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(245,'WPB 900 X 300 X 251.62',251.62,320.0,890.0,300.0,16.0,30.0,90,30.0,0.0,422000.0,13500.0,36.2,6.5,9480.0,903.0,10800.0,1410.0,749.0,24900000.0,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(246,'WPB 900 X 300 X 291.46',291.46,371.0,900.0,300.0,18.5,35.0,90,30.0,0.0,494000.0,15800.0,36.4,6.52,10900.0,1050.0,12500.0,1650.0,1150.0,29399999.999999998578,'IS808_Rev',NULL);
INSERT INTO public."Beams" VALUES(247,'UB 1016 x 305 x 222',222.0,282.8,970.3,300.0,16.0,21.1,90,30.0,0.0,407961.0,9534.0,38.0,5.8,8409.0,636.0,9807.0,1020.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(248,'UB 1016 x 305 x 249',248.7,316.9,980.2,300.0,16.5,26.0,90,30.0,0.0,481305.0,11743.0,39.0,6.1,9821.0,783.0,11350.0,1245.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(249,'UB 1016 x 305 x 272',272.3,346.9,990.1,300.0,16.5,31.0,90,30.0,0.0,553974.0,13993.0,40.0,6.4,11190.0,933.0,12826.0,1470.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(250,'UB 1016 x 305 x 314',314.3,400.4,1000.0,300.0,19.1,35.9,90,30.0,0.0,644211.0,16219.0,40.1,6.4,12884.0,1081.0,14851.0,1713.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(251,'UB 1016 x 305 x 349',349.4,445.2,1008.1,302.0,21.1,40.0,90,30.0,0.0,723131.0,18446.0,40.3,6.4,14346.0,1222.0,16592.0,1941.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(252,'UB 1016 x 305 x 393',392.7,500.2,1016.0,303.0,24.4,43.9,90,30.0,0.0,807688.0,20480.0,40.2,6.4,15899.0,1352.0,18539.0,2168.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(253,'UB 1016 x 305 x 437',436.9,556.6,1025.9,305.4,26.9,49.0,90,30.0,0.0,909906.0,23430.0,40.4,6.5,17739.0,1534.0,20762.0,2469.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(254,'UB 1016 x 305 x 487',486.6,619.9,1036.1,308.5,30.0,54.1,90,30.0,0.0,1021420.0,26703.0,40.6,6.6,19717.0,1731.0,23200.0,2800.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(255,'UB 127 x 76 x 13',13.0,16.5,127.0,76.0,4.0,7.6,90,7.6,0.0,473.0,55.7,5.4,1.8,75.0,15.0,84.2,22.6,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(256,'UB 152 x 89 x 16',16.0,20.3,152.0,88.7,4.5,7.7,90,7.6,0.0,834.0,89.7,6.4,2.1,109.0,20.0,123.0,31.2,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(257,'UB 178 x 102 x 19',19.0,24.3,178.0,101.2,4.8,7.9,90,7.6,0.0,1356.0,137.0,7.5,2.4,153.0,27.0,171.0,41.6,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(258,'UB 203 x 102 x 23',23.1,29.4,203.0,101.8,5.4,9.3,90,7.6,0.0,2105.0,164.0,8.5,2.4,207.0,32.0,234.0,49.8,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(259,'UB 203 x 133 x 25',25.1,32.0,203.0,133.2,5.7,7.8,90,7.6,0.0,2340.0,308.0,8.6,3.1,230.0,46.0,258.0,70.9,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(260,'UB 203 x 133 x 30',30.0,38.2,207.0,133.9,6.4,9.6,90,7.6,0.0,2896.0,385.0,8.7,3.2,280.0,57.0,314.0,88.2,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(261,'UB 254 x 102 x 22',22.0,28.0,254.0,101.6,5.7,6.8,90,7.6,0.0,2841.0,119.0,10.1,2.1,224.0,23.0,259.0,37.3,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(262,'UB 254 x 102 x 25',25.2,32.0,257.0,101.9,6.0,8.4,90,7.6,0.0,3415.0,149.0,10.3,2.2,266.0,29.0,306.0,46.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(263,'UB 254 x 102 x 28',28.3,36.1,260.0,102.2,6.3,10.0,90,7.6,0.0,4005.0,178.0,10.5,2.2,308.0,35.0,353.0,54.8,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(264,'UB 254 x 146 x 31',31.1,39.7,251.0,146.1,6.0,8.6,90,7.6,0.0,4413.0,447.0,10.5,3.4,351.0,61.0,393.0,94.1,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(265,'UB 254 x 146 x 37',37.0,47.2,256.0,146.4,6.3,10.9,90,7.6,0.0,5537.0,571.0,10.8,3.5,433.0,78.0,483.0,119.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(266,'UB 254 x 146 x 43',43.0,54.8,260.0,147.3,7.2,12.7,90,7.6,0.0,6544.0,677.0,10.9,3.5,504.0,92.0,566.0,141.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(267,'UB 305 x 102 x 25',24.8,31.6,305.0,101.6,5.8,7.0,90,7.6,0.0,4455.0,123.0,11.9,2.0,292.0,24.0,342.0,38.8,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(268,'UB 305 x 102 x 28',28.2,35.9,309.0,101.8,6.0,8.8,90,7.6,0.0,5366.0,155.0,12.2,2.1,348.0,31.0,403.0,48.5,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(269,'UB 305 x 102 x 33',32.8,41.8,313.0,102.4,6.6,10.8,90,7.6,0.0,6501.0,194.0,12.5,2.2,416.0,38.0,481.0,60.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(270,'UB 305 x 127 x 37',37.0,47.2,304.0,123.4,7.1,10.7,90,8.9,0.0,7171.0,336.0,12.3,2.7,471.0,54.0,539.0,85.4,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(271,'UB 305 x 127 x 42',41.9,53.4,307.0,124.3,8.0,12.1,90,8.9,0.0,8196.0,389.0,12.4,2.7,534.0,63.0,614.0,98.4,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(272,'UB 305 x 127 x 48',48.1,61.2,311.0,125.3,9.0,14.0,90,8.9,0.0,9575.0,461.0,12.5,2.7,616.0,74.0,711.0,116.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(273,'UB 305 x 165 x 40',40.3,51.3,303.0,165.0,6.0,10.2,90,8.9,0.0,8503.0,764.0,12.9,3.9,560.0,93.0,623.0,142.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(274,'UB 305 x 165 x 46',46.1,58.7,307.0,165.7,6.7,11.8,90,8.9,0.0,9899.0,896.0,13.0,3.9,646.0,108.0,720.0,166.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(275,'UB 305 x 165 x 54',54.0,68.8,310.0,166.9,7.9,13.7,90,8.9,0.0,11696.0,1063.0,13.0,3.9,754.0,127.0,846.0,196.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(276,'UB 356 x 127 x 33',33.1,42.1,349.0,125.4,6.0,8.5,90,10.2,0.0,8249.0,280.0,14.0,2.6,473.0,45.0,543.0,70.3,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(277,'UB 356 x 127 x 39',39.1,49.8,353.0,126.0,6.6,10.7,90,10.2,0.0,10172.0,358.0,14.3,2.7,576.0,57.0,659.0,89.1,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(278,'UB 356 x 171 x 45',45.0,57.3,351.0,171.1,7.0,9.7,90,10.2,0.0,12066.0,811.0,14.5,3.8,687.0,95.0,775.0,147.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(279,'UB 356 x 171 x 51',51.0,64.9,355.0,171.5,7.4,11.5,90,10.2,0.0,14136.0,968.0,14.8,3.9,796.0,113.0,896.0,174.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(280,'UB 356 x 171 x 57',57.0,72.6,358.0,172.2,8.1,13.0,90,10.2,0.0,16038.0,1108.0,14.9,3.9,896.0,129.0,1010.0,199.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(281,'UB 356 x 171 x 67',67.1,85.5,363.0,173.2,9.1,15.7,90,10.2,0.0,19463.0,1362.0,15.1,4.0,1071.0,157.0,1211.0,243.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(282,'UB 406 x 140 x 39',39.0,49.7,398.0,141.8,6.4,8.6,90,10.2,0.0,12508.0,410.0,15.9,2.9,629.0,58.0,724.0,91.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(283,'UB 406 x 140 x 46',46.0,58.6,403.0,142.2,6.8,11.2,90,10.2,0.0,15685.0,538.0,16.4,3.0,778.0,76.0,888.0,118.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(284,'UB 406 x 178 x 54',54.1,69.0,403.0,177.7,7.7,10.9,90,10.2,0.0,18722.0,1021.0,16.5,3.8,930.0,115.0,1055.0,178.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(285,'UB 406 x 178 x 60',60.1,76.5,406.0,177.9,7.9,12.8,90,10.2,0.0,21596.0,1203.0,16.8,4.0,1063.0,135.0,1199.0,209.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(286,'UB 406 x 178 x 67',67.1,85.5,409.0,178.8,8.8,14.3,90,10.2,0.0,24331.0,1365.0,16.9,4.0,1189.0,153.0,1346.0,237.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(287,'UB 406 x 178 x 74',74.2,94.5,413.0,179.5,9.5,16.0,90,10.2,0.0,27310.0,1545.0,17.0,4.0,1323.0,172.0,1501.0,267.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(288,'UB 457 x 152 x 52',52.3,66.6,450.0,152.4,7.6,10.9,90,10.2,0.0,21369.0,645.0,17.9,3.1,950.0,85.0,1096.0,133.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(289,'UB 457 x 152 x 60',59.8,76.2,455.0,152.9,8.1,13.3,90,10.2,0.0,25500.0,794.0,18.3,3.2,1122.0,104.0,1287.0,163.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(290,'UB 457 x 152 x 67',67.2,85.6,458.0,153.8,9.0,15.0,90,10.2,0.0,28927.0,912.0,18.4,3.3,1263.0,119.0,1453.0,187.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(291,'UB 457 x 152 x 74',74.2,94.5,462.0,154.4,9.6,17.0,90,10.2,0.0,32674.0,1046.0,18.6,3.3,1414.0,136.0,1627.0,213.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(292,'UB 457 x 152 x 82',82.1,104.5,466.0,155.3,10.5,18.9,90,10.2,0.0,36589.0,1184.0,18.7,3.4,1571.0,153.0,1811.0,240.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(293,'UB 457 x 191 x 67',67.1,85.5,453.0,189.9,8.5,12.7,90,10.2,0.0,29380.0,1452.0,18.5,4.1,1296.0,153.0,1471.0,237.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(294,'UB 457 x 191 x 74',74.3,94.6,457.0,190.4,9.0,14.5,90,10.2,0.0,33319.0,1671.0,18.8,4.2,1458.0,176.0,1653.0,272.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(295,'UB 457 x 191 x 82',82.0,104.5,460.0,191.3,9.9,16.0,90,10.2,0.0,37051.0,1871.0,18.8,4.2,1611.0,196.0,1831.0,304.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(296,'UB 457 x 191 x 89',89.3,113.8,463.0,191.9,10.5,17.7,90,10.2,0.0,41015.0,2089.0,19.0,4.3,1770.0,218.0,2014.0,338.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(297,'UB 457 x 191 x 98',98.3,125.3,467.0,192.8,11.4,19.6,90,10.2,0.0,45727.0,2347.0,19.1,4.3,1957.0,243.0,2232.0,379.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(298,'UB 533 x 210 x 101',101.0,128.7,537.0,210.0,10.8,17.4,90,12.7,0.0,61519.0,2691.0,21.9,4.6,2292.0,256.0,2612.0,399.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(299,'UB 533 x 210 x 109',109.0,138.9,540.0,210.8,11.6,18.8,90,12.7,0.0,66822.0,2942.0,21.9,4.6,2477.0,279.0,2828.0,436.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(300,'UB 533 x 210 x 122',122.0,155.4,545.0,211.9,12.7,21.3,90,12.7,0.0,76043.0,3387.0,22.1,4.7,2793.0,320.0,3196.0,500.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(301,'UB 533 x 210 x 82',82.2,104.7,528.0,208.8,9.6,13.2,90,12.7,0.0,47539.0,2007.0,21.3,4.4,1800.0,192.0,2059.0,300.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(302,'UB 533 x 210 x 92',92.1,117.4,533.0,209.3,10.1,15.6,90,12.7,0.0,55227.0,2389.0,21.7,4.5,2072.0,228.0,2360.0,356.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(303,'UB 610 x 229 x 101',101.2,128.9,603.0,227.6,10.5,14.8,90,12.7,0.0,75780.0,2914.0,24.2,4.8,2515.0,256.0,2881.0,400.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(304,'UB 610 x 229 x 113',113.0,143.9,608.0,228.2,11.1,17.3,90,12.7,0.0,87318.0,3433.0,24.6,4.9,2874.0,301.0,3281.0,469.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(305,'UB 610 x 229 x 125',125.1,159.3,612.0,229.0,11.9,19.6,90,12.7,0.0,98610.0,3932.0,24.9,5.0,3221.0,343.0,3676.0,535.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(306,'UB 610 x 229 x 140',139.9,178.2,617.0,230.2,13.1,22.1,90,12.7,0.0,111777.0,4505.0,25.0,5.0,3622.0,391.0,4142.0,611.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(307,'UB 610 x 305 x 149',149.2,190.0,612.0,304.8,11.8,19.7,90,16.5,0.0,125876.0,9306.0,25.7,7.0,4111.0,611.0,4594.0,937.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(308,'UB 610 x 305 x 179',179.0,228.1,620.0,307.1,14.1,23.6,90,16.5,0.0,153024.0,11407.0,25.9,7.1,4935.0,743.0,5547.0,1144.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(309,'UB 610 x 305 x 238',238.1,303.3,636.0,311.4,18.4,31.4,90,16.5,0.0,209471.0,15835.0,26.3,7.2,6589.0,1017.0,7486.0,1574.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(310,'UB 686 x 254 x 125',125.2,159.5,678.0,253.0,11.7,16.2,90,15.2,0.0,117992.0,4382.0,27.2,5.2,3481.0,346.0,3994.0,542.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(311,'UB 686 x 254 x 140',140.1,178.4,684.0,253.7,12.4,19.0,90,15.2,0.0,136267.0,5182.0,27.6,5.4,3987.0,409.0,4558.0,638.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(312,'UB 686 x 254 x 152',152.4,194.1,688.0,254.5,13.2,21.0,90,15.2,0.0,150355.0,5783.0,27.8,5.5,4374.0,454.0,5000.0,710.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(313,'UB 686 x 254 x 170',170.2,216.8,693.0,255.8,14.5,23.7,90,15.2,0.0,170326.0,6629.0,28.0,5.5,4916.0,518.0,5631.0,811.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(314,'UB 762 x 267 x 134',133.9,170.6,750.0,264.4,12.0,15.5,90,16.5,0.0,150692.0,4786.0,29.7,5.3,4018.0,362.0,4644.0,570.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(315,'UB 762 x 267 x 147',146.9,187.2,754.0,265.2,12.8,17.5,90,16.5,0.0,168501.0,5454.0,30.0,5.4,4470.0,411.0,5156.0,647.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(316,'UB 762 x 267 x 173',173.0,220.4,762.0,266.7,14.3,21.6,90,16.5,0.0,205282.0,6848.0,30.5,5.6,5387.0,514.0,6198.0,807.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(317,'UB 762 x 267 x 197',196.8,250.6,770.0,268.0,15.6,25.4,90,16.5,0.0,239957.0,8173.0,30.9,5.7,6234.0,610.0,7167.0,959.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(318,'UB 914 x 305 x 201',200.9,255.9,903.0,303.3,15.1,20.2,90,19.1,0.0,325254.0,9420.0,35.7,6.1,7204.0,621.0,8351.0,982.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(319,'UB 914 x 305 x 224',224.2,285.6,910.4,304.1,15.9,23.9,90,19.1,0.0,376413.0,11233.0,36.3,6.3,8269.0,739.0,9535.0,1163.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(320,'UB 914 x 305 x 253',253.4,322.8,918.4,305.5,17.3,27.9,90,19.1,0.0,436304.0,13298.0,36.8,6.4,9501.0,871.0,10942.0,1371.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(321,'UB 914 x 305 x 289',289.1,368.3,926.6,307.7,19.5,32.0,90,19.1,0.0,504187.0,15594.0,37.0,6.5,10883.0,1014.0,12570.0,1601.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(322,'UB 914 x 419 x 343',343.3,437.3,911.8,418.5,19.4,32.0,90,24.1,0.0,625779.0,39149.0,37.8,9.5,13726.0,1871.0,15477.0,2890.0,NULL,NULL,'',NULL);
INSERT INTO public."Beams" VALUES(323,'UB 914 x 419 x 388',388.0,494.2,921.0,420.5,21.4,36.6,90,24.1,0.0,719635.0,45431.0,38.2,9.6,15627.0,2161.0,17665.0,3341.0,NULL,NULL,'',NULL);
CREATE TABLE IF NOT EXISTS public."Channels" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR(50),
	"Mass"	NUMERIC(10 , 2),
	"Area"	NUMERIC(10 , 2),
	"D"	INTEGER,
	"B"	INTEGER,
	"tw"	NUMERIC(10 , 2),
	"T"	NUMERIC(10 , 2),
	"FlangeSlope"	INTEGER,
	"R1"	NUMERIC(10 , 2),
	"R2"	NUMERIC(10 , 2),
	"Cy"	NUMERIC(10 , 2),
	"Iz"	NUMERIC(10 , 2),
	"Iy"	NUMERIC(10 , 2),
	"rz"	NUMERIC(10 , 2),
	"ry"	NUMERIC(10 , 2),
	"Zz"	NUMERIC(10 , 2),
	"Zy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"It"	NUMERIC(10 , 2),
	"Iw"	NUMERIC(10 , 2),
	"Source"	VARCHAR(100),
	"Type"	VARCHAR(100)
); 
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(1,'MC 75',7.14,9.08,75,40,4.8,7.5,96,8.5,2.4,1.32,78.2,12.7,2.94,1.18,20.9,4.8,25.0,9.0,1.59,132.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(2,'MC 100',9.56,12.1,100,50,5.0,7.7,96,9.0,2.4,1.54,191.0,26.3,3.97,1.47,38.4,7.6,45.2,14.8,2.25,512.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(3,'MC 125',13.1,16.6,125,65,5.3,8.2,96,9.5,2.4,1.95,424.0,60.3,5.05,1.9,67.9,13.3,78.9,26.0,3.59,1900.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(4,'MC 125*',13.7,17.4,125,66,6.0,8.1,96,9.5,2.4,1.92,433.0,63.7,4.98,1.91,69.4,13.6,81.2,27.1,3.9,2030.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(5,'MC 150',16.8,21.3,150,75,5.7,9.0,96,10.0,2.4,2.2,786.0,102.0,6.08,2.19,104.0,19.3,121.0,38.1,5.45,4700.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(6,'MC 150*',17.7,22.5,150,76,6.5,9.0,96,10.0,2.4,2.17,810.0,108.0,6.0,2.2,108.0,20.0,126.0,40.0,6.07,5060.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(7,'MC 175',19.6,24.8,175,75,6.0,10.2,96,10.5,3.2,2.19,1230.0,120.0,7.04,2.2,141.0,22.7,163.0,44.7,7.49,7450.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(8,'MC 175*',22.7,27.3,175,76,7.5,10.2,96,10.5,3.2,2.14,1290.0,130.0,6.87,2.18,147.0,23.7,174.0,47.4,9.01,8250.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(9,'MC 200',22.3,28.4,200,75,6.2,11.4,96,11.0,3.2,2.2,1820.0,139.0,8.02,2.21,182.0,26.2,212.0,51.2,9.89,11000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(10,'MC 200*',24.3,30.9,200,76,7.5,11.4,96,11.0,3.2,2.12,1900.0,149.0,7.85,2.2,190.0,27.3,224.0,53.8,11.4,12100.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(11,'MC 225',26.1,33.2,225,80,6.5,12.4,96,12.0,3.2,2.31,2700.0,185.0,9.02,2.36,240.0,32.7,279.0,63.8,13.3,18700.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(12,'MC 225*',30.7,38.7,225,82,9.0,12.4,96,12.0,3.2,2.22,2920.0,210.0,8.69,2.33,260.0,35.1,309.0,68.6,17.6,22000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(13,'MC 250',30.6,38.9,250,80,7.2,14.1,96,12.0,3.2,2.3,3820.0,218.0,9.92,2.37,306.0,38.2,358.0,74.2,18.9,26800.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(14,'MC 250*',34.2,43.4,250,82,9.0,14.1,96,12.0,3.2,2.23,4060.0,242.0,9.68,2.36,325.0,40.7,386.0,78.7,22.8,30600.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(15,'MC 250*',38.1,48.1,250,83,11.0,14.1,96,12.0,3.2,2.19,4280.0,258.0,9.44,2.32,342.0,42.1,414.0,80.8,28.5,33800.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(16,'MC 300',36.3,46.2,300,90,7.8,13.6,96,13.0,3.2,2.35,6400.0,311.0,11.7,2.59,427.0,46.8,501.0,91.9,21.7,57500.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(17,'MC 300*',41.5,52.7,300,92,10.0,13.6,96,13.0,3.2,2.26,6880.0,344.0,11.4,2.55,458.0,49.6,549.0,96.3,28.1,66100.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(18,'MC 300*',46.2,58.4,300,93,12.0,13.6,96,13.0,3.2,2.22,7260.0,363.0,11.1,2.49,484.0,51.2,589.0,98.7,36.1,72300.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(19,'MC 350',42.7,54.3,350,100,8.3,13.5,96,14.0,4.8,2.44,10000.0,429.0,13.6,2.81,575.0,56.8,677.0,112.0,26.1,112000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(20,'MC 400',50.1,63.7,400,100,8.8,15.3,96,15.0,4.8,2.42,15100.0,504.0,15.4,2.81,758.0,66.5,898.0,129.0,36.1,170000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(21,'JC 100',5.8,7.41,100,45,3.0,5.1,91.5,6.0,2.0,1.4,123.0,14.6,4.09,1.4,24.8,4.7,28.4,8.8,0.51900000000000003907,264.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(22,'JC 125',7.9,10.0,125,50,3.0,6.6,91.5,6.0,2.4,1.64,269.0,25.1,5.17,1.58,43.1,7.5,49.1,13.6,1.07,701.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(23,'JC 150',9.9,12.6,150,55,3.6,6.9,91.5,7.0,2.4,1.67,471.0,37.4,6.1,1.72,62.9,9.8,72.1,18.1,1.47,1520.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(24,'JC 175',11.2,14.2,175,60,3.6,6.9,91.5,7.0,3.0,1.75,720.0,49.6,7.11,1.87,82.3,11.7,94.2,21.9,1.62,2780.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(25,'JC 200',14.0,17.7,200,70,4.1,7.1,91.5,8.0,3.2,1.97,1160.0,82.8,8.08,2.16,116.0,16.5,133.0,31.0,2.23,6150.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(26,'LC 75',5.7,7.26,75,40,3.7,6.0,91.5,6.0,2.0,1.35,65.9,11.3,3.01,1.25,17.6,4.3,20.6,7.7,0.72599999999999997868,110.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(27,'LC 100',7.9,10.0,100,50,4.0,6.4,91.5,6.0,2.0,1.62,164.0,24.4,4.05,1.56,32.9,7.2,38.1,13.3,1.11,434.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(28,'LC 125',10.7,13.6,125,65,4.4,6.6,91.5,7.0,2.4,2.04,356.0,56.3,5.11,2.03,57.1,12.6,65.4,23.4,1.68,1590.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(29,'LC (P) 125',11.3,14.3,125,65,4.6,7.0,96,7.0,2.4,1.87,370.0,50.6,5.08,1.88,59.2,10.9,68.3,22.0,2.27,1670.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(30,'LC 150',14.4,18.3,150,75,4.8,7.8,91.5,8.0,2.4,2.39,697.0,101.0,6.16,2.35,93.1,19.9,106.0,36.5,3.04,4120.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(31,'LC (P) 150',15.6,19.8,150,75,5.0,8.7,96,8.0,2.4,2.24,750.0,96.1,6.15,2.2,100.0,18.3,114.0,35.7,4.55,4450.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(32,'LC 175',17.6,22.4,175,75,5.1,9.5,91.5,8.0,3.2,2.4,1140.0,124.0,7.16,2.36,131.0,24.4,150.0,44.7,5.07,6830.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(33,'LC 200',20.6,26.2,200,75,5.5,10.8,91.5,8.5,3.2,2.36,1720.0,144.0,8.11,2.35,172.0,28.2,199.0,51.8,7.31,10300.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(34,'LC (P) 200',21.5,27.3,200,75,5.7,11.4,96,8.5,3.2,2.23,1790.0,136.0,8.09,2.23,179.0,25.9,207.0,50.2,9.13,10800.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(35,'LC 225',24.0,30.5,225,90,5.8,10.2,96,11.0,3.2,2.47,2550.0,207.0,9.14,2.6,226.0,31.8,260.0,64.2,9.3,22200.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(36,'LC 250',28.0,35.6,250,100,6.1,10.7,96,11.0,3.2,2.71,3690.0,295.0,10.1,2.88,295.0,40.6,338.0,82.5,12.0,39700.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(37,'LC 300',33.1,42.1,300,100,6.7,11.6,96,12.0,3.2,2.56,6050.0,344.0,11.9,2.86,403.0,46.3,467.0,94.2,15.6,66400.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(38,'LC (P) 300',33.1,42.1,300,90,7.0,12.5,96,12.0,3.2,2.32,5910.0,282.0,11.8,2.59,394.0,42.4,460.0,84.3,16.8,53000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(39,'LC 350',38.9,49.4,350,100,7.4,12.5,96,13.0,4.8,2.42,9310.0,391.0,13.7,2.81,532.0,51.6,623.0,103.0,20.3,103000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(40,'LC 400',45.8,58.2,400,100,8.0,14.0,96,14.0,4.8,2.37,13900.0,457.0,15.5,2.8,699.0,60.0,825.0,117.0,27.9,157000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(41,'MPC 75',7.14,9.1,75,40,4.8,7.5,90,8.5,4.5,1.38,78.6,13.7,2.94,1.23,21.0,5.2,25.2,9.5,1.48,132.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(42,'MPC 100',9.56,12.1,100,50,5.0,7.7,90,9.0,4.5,1.65,193.0,29.4,3.98,1.55,38.6,8.8,45.5,16.0,2.04,512.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(43,'MPC 125',13.1,16.7,125,65,5.5,8.1,90,9.5,5.0,2.14,426.0,69.8,5.04,2.04,68.2,15.9,79.3,29.1,3.14,1900.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(44,'MPC 125*',13.7,17.5,125,66,6.0,8.1,90,9.5,5.0,2.11,437.0,74.1,5.0,2.06,69.9,16.5,81.7,30.2,3.4,2030.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(45,'MPC 150',16.8,21.3,150,75,5.7,9.0,90,10.0,5.0,2.46,792.0,120.0,6.09,2.37,105.0,23.8,122.0,43.2,4.71,4700.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(46,'MPC 150*',17.7,22.5,150,76,6.5,9.0,90,10.0,5.0,2.4,817.0,128.0,6.02,2.38,109.0,24.7,126.0,45.1,5.25,5060.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(47,'MPC 175',19.6,24.9,175,75,6.0,10.2,90,10.5,6.0,2.39,1240.0,138.0,7.06,2.36,141.0,27.0,164.0,49.5,6.66,7450.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(48,'MPC 175*',21.7,27.6,175,77,7.5,10.2,90,10.5,6.0,2.32,1310.0,155.0,6.9,2.37,150.0,28.9,176.0,53.0,8.1,8550.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(49,'MPC 200',22.3,28.4,200,75,6.2,11.4,90,11.0,6.0,2.34,1830.0,157.0,8.03,2.35,183.0,30.5,213.0,55.9,8.99,11000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(50,'MPC 200*',24.3,30.9,200,76,7.5,11.4,90,11.0,6.5,2.26,1910.0,168.0,7.86,2.33,191.0,31.5,225.0,57.8,10.4,12100.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(51,'MPC 225',26.1,33.2,225,80,6.5,12.4,90,12.0,6.5,2.48,2710.0,208.0,9.03,2.5,241.0,37.9,280.0,69.5,12.1,18700.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(52,'MPC 225*',30.7,39.0,225,83,9.0,12.4,90,12.0,7.0,2.37,2960.0,244.0,8.72,2.51,263.0,41.3,312.0,75.3,16.2,22800.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(53,'MPC 250',30.6,38.9,250,80,7.2,14.1,90,12.0,7.0,2.44,3830.0,240.0,9.93,2.48,307.0,43.2,359.0,79.3,17.5,26800.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(54,'MPC 250*',34.2,43.4,250,82,9.0,14.1,90,12.0,7.0,2.36,4080.0,267.0,9.69,2.48,326.0,45.9,387.0,83.5,21.1,30600.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(55,'MPC 250*',38.1,48.6,250,84,11.0,14.1,90,12.0,7.0,2.31,4350.0,295.0,9.46,2.46,348.0,48.4,420.0,87.7,26.7,34900.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(56,'MPC 300',36.3,46.2,300,90,7.8,13.6,90,13.0,7.0,2.54,6420.0,351.0,11.7,2.76,428.0,54.4,502.0,99.1,19.8,57500.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(57,'MPC 300*',41.5,52.8,300,92,10.0,13.6,90,13.0,7.0,2.42,6910.0,390.0,11.4,2.72,460.0,57.5,551.0,103.0,25.7,66100.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(58,'MPC 300*',46.2,58.8,300,94,12.0,13.6,90,13.0,7.0,2.36,7360.0,424.0,11.1,2.69,490.0,60.3,596.0,108.0,33.5,74400.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(59,'MPC 350',42.7,54.3,350,100,8.3,13.5,90,14.0,8.0,2.65,10100.0,497.0,13.6,3.02,577.0,67.7,679.0,122.0,23.4,112000.0,'IS808_Rev',NULL);
INSERT INTO public."Channels"("id" , "Designation" , "Mass" , "Area" , "D" , "B" , "tw" , "T" , "FlangeSlope" , "R1" , "R2" , "Cy" , "Iz" , "Iy" , "rz" , "ry" , "Zz" , "Zy" , "Zpz" , "Zpy" , "It" , "Iw" , "Source" , "Type") VALUES(60,'MPC 400',50.1,63.8,400,100,8.8,15.3,90,15.0,8.0,2.6,15200.0,572.0,15.4,3.0,762.0,77.4,901.0,139.0,33.1,170000.0,'IS808_Rev',NULL);
CREATE TABLE IF NOT EXISTS public."SHS" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR,
	"D"	NUMERIC(10 , 2),
	"B"	NUMERIC(10 , 2),
	"T"	NUMERIC(10 , 2),
	"W"	NUMERIC(10 , 2),
	"A"	NUMERIC(10 , 2),
	"Izz"	NUMERIC(10 , 2),
	"Iyy"	NUMERIC(10 , 2),
	"Rzz"	NUMERIC(10 , 2),
	"Ryy"	NUMERIC(10 , 2),
	"Zzz"	NUMERIC(10 , 2),
	"Zyy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"Source"	VARCHAR(50)
);
INSERT INTO public."SHS" VALUES(1,' SHS 25  x  25 x  2.6',25.0,25.0,2.6,1.69,2.16,1.72,1.72,0.89,0.89,1.38,1.38,1.76,1.76,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(2,' SHS 25  x  25 x  3.2',25.0,25.0,3.2,1.98,2.53,1.89,1.89,0.86,0.86,1.51,1.51,1.98,1.98,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(3,' SHS 30 x  30 x  2.6',30.0,30.0,2.6,2.1,2.68,3.23,3.23,1.1,1.1,2.15,2.15,2.68,2.68,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(4,' SHS 30 x  30 x  3.2',30.0,30.0,3.2,2.49,3.17,3.62,3.62,1.07,1.07,2.41,2.41,3.08,3.08,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(5,' SHS 30  x 30 x 4.0',30.0,30.0,4.0,2.94,3.75,3.97,3.97,1.03,1.03,2.64,2.64,3.5,3.5,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(6,' SHS 32 x 32 x 2.6',32.0,32.0,2.6,2.26,2.88,4.02,4.02,1.18,1.18,2.51,2.51,3.11,3.11,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(7,' SHS 32 x 32 x 3.2',32.0,32.0,3.2,2.69,3.42,4.54,4.54,1.15,1.15,2.84,2.84,3.59,3.59,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(8,' SHS 32 x 32 x 4.0',32.0,32.0,4.0,3.19,4.07,5.02,5.02,1.11,1.11,3.14,3.14,4.11,4.11,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(9,' SHS 35  x  35 x  2.6',35.0,35.0,2.6,2.51,3.2,5.43,5.43,1.3,1.3,3.1,3.1,3.81,3.81,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(10,' SHS 35  x  35 x  3.2',35.0,35.0,3.2,2.99,3.81,6.18,6.18,1.27,1.27,3.53,3.53,4.42,4.42,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(11,' SHS 35 x  35 x  4.0',35.0,35.0,4.0,3.57,4.55,6.93,6.93,1.23,1.23,3.96,3.96,5.11,5.11,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(12,' SHS 38 x  38 x  2.6',38.0,38.0,2.6,2.75,3.51,7.14,7.14,1.43,1.43,3.76,3.76,4.57,4.57,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(13,' SHS 38 x  38 x  2.9',38.0,38.0,2.9,3.03,3.86,7.68,7.68,1.41,1.41,4.04,4.04,4.97,4.97,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(14,' SHS 38  x  38 x  3.2',38.0,38.0,3.2,3.29,4.19,8.18,8.18,2.4,2.4,4.3,4.3,5.34,5.34,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(15,' SHS 38  x 38 x  3.6',38.0,38.0,3.6,3.63,4.62,8.76,8.76,1.38,1.38,4.61,4.61,5.8,5.8,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(16,' SHS 38  x  38 x  4.0',38.0,38.0,4.0,3.95,5.03,9.26,9.26,1.36,1.36,4.87,4.87,6.22,6.22,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(17,' SHS 40 x  40 x  2.6',40.0,40.0,2.6,2.92,3.72,8.45,8.45,1.51,1.51,4.22,4.22,5.12,5.12,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(18,' SHS 40  x  40 x  3.2',40.0,40.0,3.2,3.49,4.45,9.72,9.72,1.48,1.48,4.86,4.86,6.01,6.01,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(19,' SHS 40 x  40 x  3.6',40.0,40.0,3.6,3.85,4.91,10.45,10.45,1.46,1.46,5.22,5.22,6.53,6.53,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(20,' SHS 40 x  40 x  4.0',40.0,40.0,4.0,4.2,5.35,11.07,11.07,1.44,1.44,5.54,5.54,7.01,7.01,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(21,' SHS 45 x 45 x  2.6',45.0,45.0,2.6,3.32,4.24,12.47,12.47,1.71,1.71,5.52,5.52,6.64,6.64,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(22,' SHS 45  x  45 x  2.9',45.0,45.0,2.9,3.66,4.67,13.45,13.45,1.7,1.7,5.98,5.98,7.25,7.25,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(23,' SHS 45  x  45 x  3.2',45.0,45.0,3.2,3.99,5.09,14.41,14.41,1.68,1.68,6.4,6.4,7.83,7.83,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(24,' SHS 45 x  45 x  3.6',45.0,45.0,3.6,4.42,5.63,15.57,15.57,1.66,1.66,6.92,6.92,8.55,8.55,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(25,' SHS 45 x  45 x  4.5',45.0,45.0,4.5,5.31,6.77,17.74,17.74,1.62,1.62,7.88,7.88,9.99,9.99,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(26,' SHS 49.5  x  49.5 x  2.9',49.0,49.0,2.9,4.07,5.19,18.37,18.37,1.88,1.88,7.42,7.42,8.93,8.93,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(27,' SHS 49.5  x  49.5 x 3.6',49.0,49.0,3.6,4.93,6.28,21.42,21.42,1.85,1.85,8.66,8.66,10.6,10.6,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(28,' SHS 49.5  x  49.5 x  4.5',49.0,49.0,4.5,5.95,7.58,24.64,24.64,1.8,1.8,9.96,9.96,12.47,12.47,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(29,' SHS 63.5  x  63.5  x  3.2',63.0,63.0,3.2,5.85,7.45,44.35,44.35,2.44,2.44,13.97,13.97,16.65,16.65,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(30,' SHS 63.5  x  63.5 x  3.6',63.0,63.0,3.6,6.51,8.29,48.55,48.55,2.42,2.42,15.29,15.29,18.36,18.36,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(31,' SHS 63.5 x  63.5 x  4.5',63.0,63.0,4.5,7.93,10.1,57.0,57.0,2.38,2.38,17.95,17.95,21.93,21.93,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(32,' SHS 72 x  72 x  3.2',72.0,72.0,3.2,6.71,8.54,66.32,66.32,2.79,2.79,18.42,18.42,21.8,21.8,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(33,' SHS 72  x  72 x  4.0',72.0,72.0,4.0,8.22,10.47,79.03,79.03,2.75,2.75,21.95,21.95,26.32,26.32,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(34,' SHS 72  x  72 x  4.8',72.0,72.0,4.8,9.66,12.31,90.31,90.31,2.71,2.71,25.09,25.09,30.49,30.49,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(35,' SHS 75 x  75 x  3.2',75.0,75.0,3.2,7.01,8.93,75.53,75.53,2.91,2.91,20.41,20.41,23.79,23.79,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(36,' SHS 75  x 75 x  4.0',75.0,75.0,4.0,8.59,10.95,90.19,90.19,2.87,2.87,24.05,24.05,28.76,28.76,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(37,' SHS 75 x  75 x  4.9',75.0,75.0,4.9,10.3,13.12,104.82,104.82,2.83,2.83,27.95,27.95,33.92,33.92,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(38,' SHS 88.9 x 88.9 x  3.6',88.0,88.0,3.6,9.38,11.95,142.83,142.83,3.46,3.46,32.13,32.13,37.85,37.85,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(39,' SHS 88.9  x 88.9 x  4.5',88.0,88.0,4.5,11.52,14.67,170.97,170.97,3.41,3.41,38.46,38.46,45.55,45.55,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(40,' SHS 88.9 x 88.9 x  4.9',88.0,88.0,4.9,12.44,15.85,182.57,182.57,3.39,3.39,41.07,41.07,49.23,49.23,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(41,' SHS 91.5  x  91.5 x  3.6',91.0,91.0,3.6,9.67,12.32,156.49,156.49,3.56,3.56,34.21,34.21,40.24,40.24,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(42,' SHS 91.5  x  91.5 x  4.5',91.0,91.0,4.5,11.88,15.14,187.57,187.57,3.52,3.52,41.0,41.0,48.79,48.79,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(43,' SHS 91.5  x  91.5 x  5.4',91.0,91.0,5.4,14.01,17.85,215.68,215.68,3.48,3.48,47.14,47.14,56.77,56.77,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(44,' SHS 100 x 100 x  4.0',100.0,100.0,4.0,11.73,14.95,226.35,226.35,3.89,3.89,45.27,45.27,53.3,53.3,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(45,' SHS 100 x 100 x  5.0',100.0,100.0,5.0,14.41,18.36,271.1,271.1,3.84,3.84,54.22,54.22,64.59,64.59,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(46,' SHS 100 x 100 x  6.0',100.0,100.0,6.0,16.98,21.63,311.47,311.47,3.79,3.79,62.29,62.29,75.1,75.1,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(47,' SHS 113.5  x 113.5  x  4.5',113.0,113.0,4.5,14.99,19.1,372.88,372.88,4.42,4.42,65.71,65.71,77.33,77.33,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(48,' SHS 113.5  x 113.5  x  4.8',113.0,113.0,4.8,15.92,20.28,393.31,393.31,4.4,4.4,69.3,69.3,81.81,81.81,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(49,' SHS 113.5 x 113.5 x 5.4',113.0,113.0,5.4,17.74,22.6,432.58,432.58,4.38,4.38,76.23,76.23,90.55,90.55,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(50,' SHS 113.5  x  I13.5  x 6.0',113.0,113.0,6.0,19.53,24.87,469.81,469.81,4.35,4.35,82.79,82.79,98.96,98.96,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(51,' SHS 125 x 125 x  4.5',125.0,125.0,4.5,16.62,21.17,505.83,505.83,4.89,4.89,80.93,80.93,94.54,94.54,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(52,' SHS 125 x 125 x 5.0',125.0,125.0,5.0,18.33,23.36,552.62,552.62,4.86,4.86,88.42,88.42,104.1,104.1,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(53,' SHS 125  x 125 x  6.0',125.0,125.0,6.0,21.69,27.63,640.89,640.89,4.82,4.82,102.54,102.54,121.87,121.87,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(54,' SHS 132  x 132 x  4.8',132.0,132.0,4.8,18.71,23.83,634.39,634.39,5.16,5.16,96.12,96.12,112.69,112.69,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(55,' SHS 132 x  132 x  5.4',132.0,132.0,5.4,20.88,26.59,700.11,700.11,5.13,5.13,106.08,106.08,125.02,125.02,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(56,' SHS 132 x 132 x  6.0',132.0,132.0,6.0,23.01,29.31,762.98,762.98,5.1,5.1,115.6,115.6,136.98,136.98,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(57,' SHS 150 x 150  x 5.0',150.0,150.0,5.0,22.26,28.36,982.12,982.12,5.89,5.89,130.95,130.95,152.98,152.98,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(58,' SHS 150 x  150 x  6.0',150.0,150.0,6.0,26.4,33.63,1145.91,1145.91,5.84,5.84,152.79,152.79,179.88,179.88,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(59,' SHS 180 x  180 x  4.0',180.0,180.0,4.0,21.9,27.9,1434.0,1434.0,7.17,7.17,159.0,159.0,184.0,184.0,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(60,' SHS 180 x  180 x  5.0',180.0,180.0,5.0,27.2,34.6,1755.0,1755.0,7.12,7.12,195.0,195.0,226.0,226.0,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(61,' SHS 180 x  180 x  6.0',180.0,180.0,6.0,32.05,40.83,2036.0,2036.0,7.06,7.06,226.0,226.0,280.0,280.0,'IS 4923:1997');
INSERT INTO public."SHS" VALUES(62,' SHS 180 x  180 x  8.0',180.0,180.0,8.0,41.91,53.39,2590.73,2590.73,6.97,6.97,287.86,287.86,340.68,340.68,'IS 4923:1997');
CREATE TABLE IF NOT EXISTS public."RHS" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR,
	"D"	NUMERIC(10 , 2),
	"B"	NUMERIC(10 , 2),
	"T"	NUMERIC(10 , 2),
	"W"	NUMERIC(10 , 2),
	"A"	NUMERIC(10 , 2),
	"Izz"	NUMERIC(10 , 2),
	"Iyy"	NUMERIC(10 , 2),
	"Rzz"	NUMERIC(10 , 2),
	"Ryy"	NUMERIC(10 , 2),
	"Zzz"	NUMERIC(10 , 2),
	"Zyy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"Source"	VARCHAR(50)
);
INSERT INTO public."RHS" VALUES(1,' RHS 50  x  25  x  2.9',50.0,25.0,2.9,2.98,3.8,10.93,3.6,1.7,0.97,4.37,2.88,5.72,3.48,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(2,' RHS 50 x  25 x 3.2',50.0,25.0,3.2,3.24,4.13,11.63,3.8,1.68,0.96,4.65,3.04,6.14,3.73,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(3,' RHS 60 x  40  x  2.9',60.0,40.0,2.9,4.12,5.25,24.74,13.11,2.17,1.58,8.25,6.56,10.25,7.73,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(4,' RHS 66  x  33  x  2.9',66.0,33.0,2.9,4.07,5.19,27.33,9.12,2.29,1.33,8.28,5.53,10.59,6.49,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(5,' RHS 66  x  33  x  3.6',66.0,33.0,3.6,4.93,6.28,31.87,10.52,2.25,1.29,9.66,6.37,12.56,7.66,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(6,' RHS 66 x  33 x 4.5',66.0,33.0,4.5,5.95,7.58,36.64,11.93,2.2,1.25,11.1,7.23,14.77,8.94,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(7,' RHS 70 x  30 x  2.9',70.0,30.0,2.9,4.12,5.25,29.82,7.72,2.38,1.21,8.52,5.14,11.07,6.04,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(8,' RHS 70 x  30 x  3.2',70.0,30.0,3.2,4.5,5.73,32.04,8.24,2.37,1.2,9.15,5.49,11.98,6.51,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(9,' RHS 70  x  30 x  4.0',70.0,30.0,4.0,5.45,6.95,37.23,9.42,2.31,1.16,10.64,6.28,14.2,7.66,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(10,' RHS 80  x 40  x  2.9',80.0,40.0,2.9,5.03,6.41,50.87,17.11,2.82,1.63,12.72,8.56,16.07,9.88,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(11,' RHS 80 x  40 x  3.2',80.0,40.0,3.2,5.5,7.01,54.94,18.41,2.8,1.62,13.74,9.21,17.46,10.72,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(12,' RHS 80 x  40  x  4.0',80.0,40.0,4.0,6.71,8.55,64.79,21.49,2.75,1.59,16.2,10.74,20.91,12.77,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(13,' RHS 96 x  48  x 3.2',96.0,48.0,3.2,6.71,8.54,98.61,33.28,3.4,1.97,20.54,13.87,25.85,15.91,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(14,' RHS 96 x  48  x  4.0',96.0,48.0,4.0,8.22,10.47,117.54,39.32,3.55,1.94,24.49,16.3,31.21,19.14,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(15,' RHS 96 x  48  x  4.8',96.0,48.0,4.8,9.66,12.31,134.35,44.55,3.3,1.9,27.99,18.56,36.13,22.08,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(16,' RHS 100  x 50  x  3.2',100.0,50.0,3.2,7.01,8.93,112.29,37.95,3.55,2.06,22.46,15.18,28.2,17.37,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(17,' RHS 100  x 50  x  4.0',100.0,50.0,4.0,8.59,10.95,134.14,44.95,3.5,2.03,26.83,17.98,34.1,20.93,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(18,' RHS 122  x  61  x  3.6',122.0,61.0,3.6,9.67,12.32,232.61,78.83,4.34,2.35,38.13,25.84,47.71,29.42,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(19,' RHS 122 x  61  x  4.5',122.0,61.0,4.5,11.88,15.14,278.94,93.78,4.29,2.49,45.73,30.75,57.85,35.56,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(20,' RHS 122  x 61  x  5.4',122.0,61.0,5.4,14.01,17.85,320.83,107.03,4.24,2.45,52.6,35.09,67.29,41.22,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(21,' RHS 127 x  50  x  3.6',127.0,50.0,3.6,9.34,11.89,227.08,52.05,4.37,2.09,35.76,20.82,45.95,23.7,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(22,' RHS 127 x 50  x  4.6',127.0,50.0,4.6,11.69,14.89,276.33,62.46,4.31,2.05,43.52,24.98,56.66,29.04,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(23,' RHS 145 x 82  x  4.8',145.0,82.0,4.8,15.92,20.28,555.16,228.5,5.23,3.36,76.57,55.73,94.93,63.93,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(24,' RHS 145  x 82  x 5.4',145.0,82.0,5.4,17.74,22.6,610.85,250.59,5.2,3.33,84.26,61.12,105.07,70.66,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(25,' RHS 172 x  92  x  4.8',172.0,92.0,4.8,18.71,23.83,917.13,346.91,6.2,3.82,106.64,75.41,132.08,85.61,'IS 4923:1997');
INSERT INTO public."RHS" VALUES(26,' RHS 172  x  92  x  5.4',172.0,92.0,5.4,20.88,26.59,1012.47,381.74,6.17,3.79,117.73,82.99,146.55,94.86,'IS 4923:1997');
CREATE TABLE IF NOT EXISTS public."CHS" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR,
	"NB"	VARCHAR,
	"OD"	NUMERIC(10 , 2),
	"T"	NUMERIC(10 , 2),
	"W"	NUMERIC(10 , 2),
	"A"	NUMERIC(10 , 2),
	"V"	NUMERIC(10 , 2),
	"Ves"	NUMERIC(10 , 2),
	"Vis"	NUMERIC(10 , 2),
	"I"	NUMERIC(10 , 2),
	"Z"	NUMERIC(10 , 2),
	"R"	NUMERIC(10 , 2),
	"Rsq"	NUMERIC(10 , 2),
	"Source"	VARCHAR
);
INSERT INTO public."CHS" VALUES(1,' CHS 21.3 x 2','15',21.3,2.0,0.95,1.21,235.0,669.0,543.0,0.57,0.54,0.69,0.47,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(2,' CHS 21.3 x 2.6','15',21.3,2.6,1.2,1.53,204.0,669.0,506.0,0.68,0.64,0.67,0.45,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(3,' CHS 21.3 x 3.2','15',21.3,3.2,1.43,1.82,174.0,669.0,468.0,0.77,0.72,0.65,0.42,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(4,' CHS 26.9 x 2.3','20',26.9,2.3,1.4,1.78,391.0,845.0,701.0,1.36,1.01,0.87,0.76,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(5,' CHS 26.9 x 2.6','20',26.9,2.6,1.56,1.98,370.0,845.0,682.0,1.48,1.1,0.86,0.75,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(6,' CHS 26.9 x 3.2','20',26.9,3.2,1.87,2.38,330.0,845.0,644.0,1.7,1.27,0.85,0.71,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(7,' CHS 33.7 x 2.6','25',33.7,2.6,1.99,2.54,638.0,1059.0,895.0,3.09,1.84,1.1,1.22,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(8,' CHS 33.7 x 3.2','25',33.7,3.2,2.41,3.07,585.0,1059.0,858.0,3.6,2.14,1.08,1.18,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(9,' CHS 33.7 x 4','25',33.7,4.0,2.93,3.73,519.0,1059.0,807.0,4.19,2.49,1.06,1.12,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(10,' CHS 42.4 x 2.6','32',42.4,2.6,2.55,3.25,1087.0,1332.0,1169.0,6.46,3.05,1.41,1.99,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(11,' CHS 42.4 x 3.2','32',42.4,3.2,3.09,3.94,1018.0,1332.0,1131.0,7.62,3.59,1.39,1.93,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(12,' CHS 42.4 x 4','32',42.4,4.0,3.79,4.83,929.0,1332.0,1081.0,8.99,4.24,1.36,1.86,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(13,' CHS 48.3 x 2.9','40',48.3,2.9,3.25,4.14,1419.0,1517.0,1335.0,10.7,4.43,1.61,2.59,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(14,' CHS 48.3 x 3.2','40',48.3,3.2,3.56,4.53,1379.0,1517.0,1316.0,11.59,4.8,1.6,2.56,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(15,' CHS 48.3 x 4','40',48.3,4.0,4.37,5.57,1276.0,1517.0,1266.0,13.77,5.7,1.57,2.47,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(16,' CHS 60.3 x 2.9','50',60.3,2.9,4.11,5.23,2333.0,1894.0,1712.0,21.59,7.15,2.03,4.13,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(17,' CHS 60.3 x 3.6','50',60.3,3.6,5.03,6.41,2215.0,1894.0,1668.0,25.87,8.58,2.01,4.03,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(18,' CHS 60.3 x 4.5','50',60.3,4.5,6.19,7.89,2067.0,1894.0,1612.0,30.9,10.25,1.98,3.92,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(19,' CHS 76.1 x 2.9','65',76.1,2.9,5.24,0.67,3882.0,2391.0,2209.0,44.74,11.76,2.59,6.71,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(20,' CHS 76.1 x 3.6','65',76.1,3.6,6.44,8.2,3728.0,2391.0,2165.0,54.01,14.19,2.57,6.59,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(21,' CHS 76.1 x 4.5','65',76.1,4.5,7.95,10.12,3536.0,2391.0,2108.0,65.12,17.11,2.54,6.43,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(22,' CHS 88.9 x 3.2','80',88.9,3.2,6.76,8.62,5346.0,2793.0,2592.0,79.21,17.82,3.03,9.19,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(23,' CHS 88.9 x 4','80',88.9,4.0,8.38,10.67,5140.0,2793.0,2542.0,95.34,21.67,3.0,9.03,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(24,' CHS 88.9 x 4.8','80',88.9,4.8,9.96,12.68,4939.0,2793.0,2491.0,112.49,25.31,2.98,8.87,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(25,' CHS 101.6 x 3.6','90',101.6,3.6,8.7,11.08,6999.0,3192.0,2966.0,133.24,26.23,3.47,12.02,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(26,' CHS 101.6 x 4','90',101.6,4.0,9.63,12.26,6881.0,3192.0,2941.0,146.28,18.8,3.45,11.93,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(27,' CHS 101.6 x 4.8','90',101.6,4.8,11.46,14.6,6648.0,3192.0,2890.0,171.39,33.74,3.43,11.74,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(28,' CHS 114.3 x 3.6','100',114.3,3.6,9.83,12.52,9009.0,3591.0,3365.0,191.98,33.59,3.92,15.33,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(29,' CHS 114.3 x 4.5','100',114.3,4.5,12.19,15.52,8709.0,3591.0,3308.0,234.32,41.0,3.89,15.1,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(30,' CHS 114.3 x 5.4','100',114.3,5.4,14.5,18.47,8413.0,3591.0,3252.0,274.54,48.04,3.85,14.86,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(31,' CHS 127 x 4.5','110',127.0,4.5,13.59,17.32,10936.0,3990.0,3707.0,325.29,51.23,4.33,18.78,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(32,' CHS 127 x 4.8','110',127.0,4.8,14.47,18.43,10825.0,3990.0,3688.0,344.5,54.25,4.32,18.69,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(33,' CHS 127 x 5.4','110',127.0,5.4,16.19,20.63,10605.0,3990.0,3651.0,382.04,60.16,4.3,18.52,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(34,' CHS 139.7 x 4.5','125',139.7,4.5,15.0,19.11,13417.0,4389.0,4106.0,437.2,62.59,4.78,22.87,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(35,' CHS 139.7 x 4.8','125',139.7,4.8,15.97,20.34,13295.0,4389.0,4087.0,463.33,66.33,4.77,22.78,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(36,' CHS 139.7 x 5.4','125',139.7,5.4,17.89,22.78,13050.0,4389.0,4050.0,514.5,73.66,4.75,22.58,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(37,' CHS 152.4 x 4.5','135',152.4,4.5,16.41,20.91,16151.0,4788.0,4505.0,572.24,75.1,5.23,27.37,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(38,' CHS 152.4 x 4.8','135',152.4,4.8,17.47,22.26,16016.0,4788.0,4486.0,606.76,79.63,5.22,27.26,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(39,' CHS 152.4 x 5.4','135',152.4,5.4,19.58,24.94,15748.0,4788.0,4448.0,674.51,88.52,5.2,27.05,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(40,' CHS 165.1 x 4.5','150',165.1,4.5,17.82,22.7,19138.0,5187.0,4904.0,732.57,88.74,5.68,32.27,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(41,' CHS 165.1 x 4.8','150',165.1,4.8,18.98,24.17,18991.0,5187.0,4885.0,777.13,94.14,5.67,32.15,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(42,' CHS 165.1 x 5.4','150',165.1,5.4,21.27,27.09,18699.0,5187.0,4847.0,864.7,104.75,5.65,31.92,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(43,' CHS 165.1 x 5.9','150',165.1,5.9,23.2,29.5,18465.0,5189.0,4818.0,970.0,113.4,5.63,31.72,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(44,' CHS 165.1 x 6.3','150',165.1,6.3,24.67,31.43,18265.0,5187.0,4791.0,992.28,120.2,5.62,31.57,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(45,' CHS 165.1 x 8','150',165.1,8.0,30.99,39.48,17460.0,5187.0,4684.0,1221.25,147.94,5.56,30.93,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(46,' CHS 168.3 x 4.5','150',168.3,4.5,18.18,23.16,19931.0,5287.0,5005.0,777.22,92.36,5.79,33.56,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(47,' CHS 168.3 x 4.8','150',168.3,4.8,19.35,24.66,19781.0,5287.0,4986.0,824.57,97.99,5.78,33.44,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(48,' CHS 168.3 x 5.4','150',168.3,5.4,21.69,27.64,19483.0,5287.0,4948.0,917.69,109.05,5.76,33.21,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(49,' CHS 168.3 x 6.3','150',168.3,6.3,25.17,32.06,19040.0,5287.0,4891.0,1053.42,125.18,5.73,32.85,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(50,' CHS 168.3 x 8','150',168.3,8.0,31.63,40.29,18218.0,5287.0,4785.0,1297.27,154.16,5.67,32.2,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(51,' CHS 168.3 x 10','150',168.3,10.0,39.04,49.73,17273.0,5287.0,4659.0,1563.98,185.86,5.61,31.45,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(52,' CHS 193.7 x 4.8','175',193.7,4.8,22.36,28.49,26619.0,6085.0,5784.0,1271.39,131.27,6.68,44.63,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(53,' CHS 193.7 x 5.4','175',193.7,5.4,25.08,31.94,26273.0,6085.0,5746.0,1416.97,146.31,6.66,44.36,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(54,' CHS 193.7 x 5.9','175',193.7,5.9,27.33,34.81,25987.0,6085.0,5715.0,1536.13,158.61,6.64,44.13,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(55,' CHS 193.7 x 6.3','175',193.7,6.3,29.12,37.09,25759.0,6085.0,5689.0,1630.05,168.31,6.63,43.95,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(56,' CHS 193.7 x 8','175',193.7,8.0,36.64,46.67,24801.0,6085.0,5583.0,2015.54,208.11,6.57,43.19,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(57,' CHS 193.7 x 10','175',193.7,10.0,45.3,57.71,23697.0,6085.0,5457.0,2441.59,252.1,6.5,42.31,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(58,' CHS 193.7 x 12','175',193.7,12.0,53.77,68.5,22618.0,6085.0,5331.0,2839.2,293.15,6.44,41.45,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(59,' CHS 219.1 x 4.8','200',219.1,4.8,25.37,32.32,34471.0,6883.0,6582.0,1856.03,169.42,7.58,57.43,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(60,' CHS 219.1 x 5.6','200',219.1,5.6,29.49,37.56,33947.0,6883.0,6531.0,2141.61,195.49,7.55,57.02,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(61,' CHS 219.1 x 5.9','200',219.1,5.9,31.02,39.52,33751.0,6883.0,6513.0,2247.01,205.11,7.54,56.86,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(62,' CHS 219.1 x 6.3','200',219.1,6.3,33.06,42.12,33491.0,6883.0,6487.0,2386.14,217.81,7.53,56.65,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(63,' CHS 219.1 x 8','200',219.1,8.0,41.65,53.06,32397.0,6883.0,6381.0,2959.63,270.16,7.47,55.78,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(64,' CHS 219.1 x 10','200',219.1,10.0,51.57,65.69,31134.0,6883.0,6255.0,3598.44,328.47,7.4,54.78,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(65,' CHS 219.1 x 12','200',219.1,12.0,61.29,78.07,29895.0,6883.0,6129.0,4199.88,383.38,7.33,53.79,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(66,' CHS 244.5 x 5.9','225',244.5,5.9,34.72,44.23,42529.0,7681.0,7310.0,3149.12,257.6,8.44,71.21,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(67,' CHS 244.5 x 6.3','225',244.5,6.3,37.01,47.14,42237.0,7681.0,7285.0,3346.03,273.7,8.42,70.97,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(68,' CHS 244.5 x 8','225',244.5,8.0,46.66,59.44,41007.0,7681.0,7179.0,4160.45,340.32,8.37,70.0,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(69,' CHS 244.5 x 10','225',244.5,10.0,57.83,73.67,39584.0,7681.0,7053.0,5073.15,414.98,8.3,68.86,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(70,' CHS 273 x 5.9','250',273.0,5.9,38.86,49.51,53584.0,8577.0,8206.0,4417.18,323.6,9.45,89.22,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(71,' CHS 273 x 6.3','250',273.0,6.3,41.44,52.79,53256.0,8577.0,8181.0,4695.82,344.02,9.43,88.96,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(72,' CHS 273 x 8','250',273.0,8.0,52.28,66.6,51875.0,8577.0,8074.0,5851.71,428.7,9.37,87.86,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(73,' CHS 273 x 10','250',273.0,10.0,64.86,82.62,50273.0,8577.0,7948.0,7154.09,524.11,9.31,86.59,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(74,' CHS 273 x 12','250',273.0,12.0,77.24,98.39,48695.0,8577.0,7823.0,8396.14,615.1,9.24,85.33,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(75,' CHS 323.9 x 6.3','300',323.9,6.3,49.34,62.86,76111.0,10176.0,9780.0,7928.9,489.59,11.23,126.14,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(76,' CHS 323.9 x 8','300',323.9,8.0,62.32,79.39,74458.0,10176.0,9673.0,9910.08,611.92,11.17,124.82,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(77,' CHS 323.9 x 10','300',323.9,10.0,77.41,98.61,72536.0,10176.0,9547.0,12158.34,750.75,11.1,123.29,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(78,' CHS 323.9 x 12','300',323.9,12.0,92.3,117.58,70639.0,10176.0,9422.0,14319.56,884.2,11.04,121.78,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(79,' CHS 355.6 x 8','350',355.6,8.0,68.58,87.36,90579.0,11172.0,10669.0,13201.37,742.48,12.29,151.11,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(80,' CHS 355.6 x 10','350',355.6,10.0,85.23,108.57,88457.0,11172.0,10543.0,16223.5,912.46,12.22,149.42,'IS 1161:2014');
INSERT INTO public."CHS" VALUES(81,' CHS 355.6 x 12','350',355.6,12.0,101.68,129.53,86361.0,11172.0,10418.0,19139.47,1076.46,12.16,147.76,'IS 1161:2014');
CREATE TABLE IF NOT EXISTS public."Angles" (
	"id" SERIAL PRIMARY KEY,
	"Designation"	VARCHAR(50),
	"Mass"	NUMERIC(10 , 2),
	"Area"	NUMERIC(10 , 2),
	"a"	NUMERIC(10 , 2),
	"b"	NUMERIC(10 , 2),
	"t"	NUMERIC(10 , 2),
	"R1"	NUMERIC(10 , 2),
	"R2"	NUMERIC(10 , 2) DEFAULT (null),
	"Cz"	NUMERIC(10 , 2),
	"Cy"	NUMERIC(10 , 2),
	"Iz"	NUMERIC(10 , 2),
	"Iy"	NUMERIC(10 , 2),
	"Alpha"	NUMERIC(10 , 2),
	"Iumax"	NUMERIC(10 , 2),
	"Ivmin"	NUMERIC(10 , 2),
	"rz"	NUMERIC(10 , 2),
	"ry"	NUMERIC(10 , 2),
	"rumax"	NUMERIC(10 , 2),
	"rvmin"	NUMERIC(10 , 2),
	"Zz"	NUMERIC(10 , 2),
	"Zy"	NUMERIC(10 , 2),
	"Zpz"	NUMERIC(10 , 2),
	"Zpy"	NUMERIC(10 , 2),
	"It"	NUMERIC(10 , 2),
	"Source"	VARCHAR(100),
	"Type"	VARCHAR(100)
);
INSERT INTO public."Angles" VALUES(1,'20 x 20 x 3',0.9,1.14,20.0,20.0,3.0,4.0,0.0,0.6,0.6,0.4,0.4,0.79,0.64,0.17,0.59,0.59,0.75,0.39,0.29,0.29,0.52,0.53,0.033000000000000007105,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(2,'20 x 20 x 4',1.16,1.47,20.0,20.0,4.0,4.0,0.0,0.64,0.64,0.5,0.5,0.79,0.79,0.22,0.58,0.58,0.73,0.39,0.37,0.37,0.66,0.67,0.075999999999999996447,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(3,'25 x 25 x 3',1.14,1.45,25.0,25.0,3.0,4.5,0.0,0.73,0.73,0.83,0.83,0.79,1.3,0.35,0.75,0.75,0.95,0.49,0.46,0.46,0.83,0.84,0.042000000000000001776,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(4,'25 x 25 x 4',1.48,1.88,25.0,25.0,4.0,4.5,0.0,0.76,0.76,1.04,1.04,0.79,1.63,0.44,0.74,0.74,0.93,0.48,0.6,0.6,1.07,1.09,0.098000000000000024868,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(5,'25 x 25 x 5',1.8,2.29,25.0,25.0,5.0,4.5,0.0,0.8,0.8,1.23,1.23,0.79,1.92,0.54,0.73,0.73,0.92,0.48,0.72,0.72,1.3,1.31,0.18700000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(6,'30 x 30 x 3',1.38,1.76,30.0,30.0,3.0,5.0,0.0,0.85,0.85,1.47,1.47,0.79,2.32,0.62,0.91,0.91,1.15,0.59,0.68,0.68,1.22,1.23,0.050999999999999996447,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(7,'30 x 30 x 4',1.8,2.29,30.0,30.0,4.0,5.0,0.0,0.89,0.89,1.86,1.86,0.79,2.94,0.78,0.9,0.9,1.13,0.58,0.88,0.88,1.58,1.6,0.11899999999999999467,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(8,'30 x 30 x 5',2.2,2.8,30.0,30.0,5.0,5.0,0.0,0.93,0.93,2.22,2.22,0.79,3.49,0.95,0.89,0.89,1.12,0.58,1.07,1.07,1.92,1.94,0.22900000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(9,'35 x 35 x 3',1.62,2.06,35.0,35.0,3.0,5.0,0.0,0.97,0.97,2.38,2.38,0.79,3.77,0.99,1.07,1.07,1.35,0.69,0.94,0.94,1.69,1.7,0.06,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(10,'35 x 35 x 4',2.11,2.69,35.0,35.0,4.0,5.0,0.0,1.01,1.01,3.04,3.04,0.79,4.81,1.27,1.06,1.06,1.34,0.69,1.22,1.22,2.19,2.21,0.14,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(11,'35 x 35 x 5',2.59,3.3,35.0,35.0,5.0,5.0,0.0,1.05,1.05,3.65,3.65,0.79,5.76,1.54,1.05,1.05,1.32,0.68,1.49,1.49,2.68,2.69,0.27,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(12,'35 x 35 x 6',3.06,3.89,35.0,35.0,6.0,5.0,0.0,1.09,1.09,4.2,4.2,0.79,6.61,1.8,1.04,1.04,1.3,0.68,1.74,1.74,3.14,3.15,0.46,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(13,'40 x 40 x 3',1.86,2.37,40.0,40.0,3.0,5.5,0.0,1.09,1.09,3.61,3.61,0.79,5.72,1.51,1.23,1.23,1.55,0.8,1.24,1.24,2.22,2.24,0.069000000000000003552,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(14,'40 x 40 x 4',2.44,3.1,40.0,40.0,4.0,5.5,0.0,1.13,1.13,4.63,4.63,0.79,7.34,1.93,1.22,1.22,1.54,0.79,1.62,1.62,2.9,2.92,0.16200000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(15,'40 x 40 x 5',2.99,3.81,40.0,40.0,5.0,5.5,0.0,1.17,1.17,5.58,5.58,0.79,8.83,2.33,1.21,1.21,1.52,0.78,1.97,1.97,3.55,3.57,0.31200000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(16,'40 x 40 x 6',3.54,4.5,40.0,40.0,6.0,5.5,0.0,1.21,1.21,6.46,6.46,0.79,10.2,2.73,1.2,1.2,1.5,0.78,2.32,2.32,4.17,4.19,0.53200000000000002842,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(17,'45 x 45 x 3',2.1,2.67,45.0,45.0,3.0,5.5,0.0,1.22,1.22,5.2,5.2,0.79,8.2,2.17,1.39,1.39,1.76,0.9,1.58,1.58,2.84,2.86,0.078000000000000015987,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(18,'45 x 45 x 4',2.75,3.5,45.0,45.0,4.0,5.5,0.0,1.26,1.26,6.7,6.7,0.79,10.6,2.78,1.38,1.38,1.74,0.89,2.07,2.07,3.71,3.73,0.1830000000000000071,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(19,'45 x 45 x 5',3.39,4.31,45.0,45.0,5.0,5.5,0.0,1.3,1.3,8.1,8.1,0.79,12.8,3.37,1.37,1.37,1.72,0.88,2.53,2.53,4.55,4.57,0.35400000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(20,'45 x 45 x 6',4.01,5.1,45.0,45.0,6.0,5.5,0.0,1.34,1.34,9.42,9.42,0.79,14.9,3.94,1.36,1.36,1.71,0.88,2.98,2.98,5.36,5.38,0.60400000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(21,'50 x 50 x 3',2.34,2.99,50.0,50.0,3.0,6.0,0.0,1.34,1.34,7.21,7.21,0.79,11.4,3.01,1.55,1.55,1.96,1.0,1.97,1.97,3.53,3.55,0.086999999999999992894,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(22,'50 x 50 x 4',3.08,3.92,50.0,50.0,4.0,6.0,0.0,1.38,1.38,9.32,9.32,0.79,14.8,3.86,1.54,1.54,1.94,0.99,2.57,2.57,4.62,4.64,0.20400000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(23,'50 x 50 x 5',3.79,4.83,50.0,50.0,5.0,6.0,0.0,1.42,1.42,11.3,11.3,0.79,17.9,4.69,1.53,1.53,1.93,0.99,3.16,3.16,5.67,5.7,0.39500000000000001776,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(24,'50 x 50 x 6',4.49,5.72,50.0,50.0,6.0,6.0,0.0,1.46,1.46,13.2,13.2,0.79,20.8,5.48,1.52,1.52,1.91,0.98,3.72,3.72,6.69,6.71,0.67600000000000015631,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(25,'55 x 55 x 4',3.4,4.33,55.0,55.0,4.0,6.5,0.0,1.5,1.5,12.5,12.5,0.79,19.9,5.2,1.7,1.7,2.14,1.1,3.14,3.14,5.63,5.66,0.22600000000000002309,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(26,'55 x 55 x 5',4.19,5.34,55.0,55.0,5.0,6.5,0.0,1.54,1.54,15.2,15.2,0.79,24.2,6.31,1.69,1.69,2.13,1.09,3.85,3.85,6.92,6.95,0.43700000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(27,'55 x 55 x 6',4.97,6.33,55.0,55.0,6.0,6.5,0.0,1.58,1.58,17.8,17.8,0.79,28.2,7.39,1.68,1.68,2.11,1.08,4.55,4.55,8.17,8.2,0.74800000000000004263,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(28,'55 x 55 x 8',6.48,8.25,55.0,55.0,8.0,6.5,0.0,1.66,1.66,22.5,22.5,0.79,35.6,9.48,1.65,1.65,2.08,1.07,5.87,5.87,10.5,10.6,1.74,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(29,'60 x 60 x 4',3.71,4.73,60.0,60.0,4.0,6.5,0.0,1.63,1.63,16.4,16.4,0.79,26.0,6.8,1.86,1.86,2.35,1.2,3.76,3.76,6.74,6.77,0.24699999999999993072,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(30,'60 x 60 x 5',4.58,5.84,60.0,60.0,5.0,6.5,0.0,1.67,1.67,20.0,20.0,0.79,31.7,8.26,1.85,1.85,2.33,1.19,4.62,4.62,8.3,8.32,0.47900000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(31,'60 x 60 x 6',5.44,6.93,60.0,60.0,6.0,6.5,0.0,1.71,1.71,23.4,23.4,0.79,37.1,9.69,1.84,1.84,2.31,1.18,5.46,5.46,9.81,9.84,0.82,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(32,'60 x 60 x 8',7.1,9.05,60.0,60.0,8.0,6.5,0.0,1.78,1.78,29.8,29.8,0.79,47.1,12.4,1.81,1.81,2.28,1.17,7.06,7.06,12.7,12.7,1.91,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(33,'65 x 65 x 4',4.03,5.13,65.0,65.0,4.0,6.5,0.0,1.75,1.75,21.0,21.0,0.79,33.4,8.69,2.02,2.02,2.55,1.3,4.43,4.43,7.95,7.98,0.26800000000000001598,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(34,'65 x 65 x 5',4.98,6.34,65.0,65.0,5.0,6.5,0.0,1.79,1.79,25.7,25.7,0.79,40.8,10.6,2.01,2.01,2.54,1.29,5.45,5.45,9.8,9.83,0.52,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(35,'65 x 65 x 6',5.91,7.53,65.0,65.0,6.0,6.5,0.0,1.83,1.83,30.1,30.1,0.79,47.8,12.4,2.0,2.0,2.52,1.28,6.45,6.45,11.5,11.6,0.89199999999999999289,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(36,'65 x 65 x 8',7.73,9.85,65.0,65.0,8.0,6.5,0.0,1.91,1.91,38.4,38.4,0.79,60.8,16.0,1.97,1.97,2.48,1.27,8.36,8.36,15.0,15.0,2.08,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(37,'70 x 70 x 5',5.38,6.86,70.0,70.0,5.0,7.0,0.0,1.92,1.92,32.3,32.3,0.79,51.3,13.3,2.17,2.17,2.74,1.39,6.36,6.36,11.4,11.4,0.56200000000000009947,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(38,'70 x 70 x 6',6.39,8.15,70.0,70.0,6.0,7.0,0.0,1.96,1.96,38.0,38.0,0.79,60.3,15.6,2.16,2.16,2.72,1.39,7.53,7.53,13.5,13.5,0.96400000000000005684,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(39,'70 x 70 x 8',8.37,10.6,70.0,70.0,8.0,7.0,0.0,2.03,2.03,48.5,48.5,0.79,76.9,20.1,2.13,2.13,2.69,1.37,9.77,9.77,17.5,17.6,2.25,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(40,'70 x 70 x 10',10.29,13.1,70.0,70.0,10.0,7.0,0.0,2.11,2.11,58.3,58.3,0.79,92.1,24.4,2.11,2.11,2.65,1.37,11.9,11.9,21.4,21.5,4.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(41,'75 x 75 x 5',5.77,7.36,75.0,75.0,5.0,7.0,0.0,2.04,2.04,40.0,40.0,0.79,63.6,16.5,2.33,2.33,2.94,1.5,7.3,7.3,13.2,13.2,0.60400000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(42,'75 x 75 x 6',6.86,8.75,75.0,75.0,6.0,7.0,0.0,2.08,2.08,47.1,47.1,0.79,74.8,19.4,2.32,2.32,2.92,1.49,8.7,8.7,15.6,15.6,1.03,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(43,'75 x 75 x 8',9.0,11.4,75.0,75.0,8.0,7.0,0.0,2.16,2.16,60.3,60.3,0.79,95.7,24.9,2.29,2.29,2.89,1.47,11.3,11.3,20.3,20.4,2.42,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(44,'75 x 75 x 10',11.07,14.1,75.0,75.0,10.0,7.0,0.0,2.23,2.23,72.6,72.6,0.79,114.0,30.3,2.27,2.27,2.85,1.47,13.8,13.8,24.8,24.9,4.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(45,'80 x 80 x 6',7.36,9.38,80.0,80.0,6.0,8.0,0.0,2.2,2.2,57.6,57.6,0.79,91.4,23.7,2.48,2.48,3.12,1.59,9.9,9.9,17.8,17.9,1.1,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(46,'80 x 80 x 8',9.65,12.3,80.0,80.0,8.0,8.0,0.0,2.28,2.28,74.0,74.0,0.79,117.0,30.5,2.45,2.45,3.09,1.58,12.9,12.9,23.3,23.3,2.59,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(47,'80 x 80 x 10',11.88,15.1,80.0,80.0,10.0,8.0,0.0,2.36,2.36,89.2,89.2,0.79,141.0,37.1,2.43,2.43,3.05,1.57,15.8,15.8,28.4,28.5,5.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(48,'80 x 80 x 12',14.05,17.9,80.0,80.0,12.0,8.0,0.0,2.43,2.43,103.0,103.0,0.79,163.0,43.5,2.4,2.4,3.02,1.56,18.5,18.5,33.4,33.5,8.52,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(49,'90 x 90 x 6',8.32,10.6,90.0,90.0,6.0,8.5,0.0,2.45,2.45,83.0,83.0,0.79,131.0,34.2,2.8,2.8,3.53,1.8,12.7,12.7,22.8,22.8,1.25,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(50,'90 x 90 x 8',10.92,13.9,90.0,90.0,8.0,8.5,0.0,2.53,2.53,107.0,107.0,0.79,170.0,44.1,2.77,2.77,3.5,1.78,16.5,16.5,29.7,29.8,2.93,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(51,'90 x 90 x 10',13.47,17.1,90.0,90.0,10.0,8.5,0.0,2.6,2.6,129.0,129.0,0.79,205.0,53.6,2.75,2.75,3.46,1.77,20.2,20.2,36.4,36.5,5.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(52,'90 x 90 x 12',15.95,20.3,90.0,90.0,12.0,8.5,0.0,2.68,2.68,150.0,150.0,0.79,238.0,62.8,2.72,2.72,3.42,1.76,23.8,23.8,42.9,43.0,9.67,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(53,'100 x 100 x 6',9.26,11.8,100.0,100.0,6.0,8.5,0.0,2.7,2.7,115.0,115.0,0.79,182.0,47.2,3.12,3.12,3.94,2.0,15.7,15.7,28.3,28.3,1.39,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(54,'100 x 100 x 8',12.18,15.5,100.0,100.0,8.0,8.5,0.0,2.78,2.78,148.0,148.0,0.79,236.0,61.0,3.1,3.1,3.9,1.98,20.6,20.6,37.0,37.1,3.27,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(55,'100 x 100 x 10',15.04,19.1,100.0,100.0,10.0,8.5,0.0,2.85,2.85,180.0,180.0,0.79,286.0,74.3,3.07,3.07,3.87,1.97,25.3,25.3,45.4,45.5,6.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(56,'100 x 100 x 12',17.83,22.7,100.0,100.0,12.0,8.5,0.0,2.93,2.93,210.0,210.0,0.79,333.0,87.2,3.04,3.04,3.83,1.96,29.8,29.8,53.6,53.7,10.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(57,'110 x 110 x 8',13.4,17.0,110.0,110.0,8.0,10.0,4.8,3.0,3.0,196.0,196.0,0.79,312.0,80.7,3.39,3.39,4.28,2.17,24.6,24.6,44.6,44.7,3.61,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(58,'110 x 110 x 10',16.58,21.1,110.0,110.0,10.0,10.0,4.8,3.09,3.09,240.0,240.0,0.79,381.0,98.6,3.37,3.37,4.25,2.16,30.4,30.4,54.9,55.0,7.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(59,'110 x 110 x 12',19.68,25.0,110.0,110.0,12.0,10.0,4.8,3.17,3.17,281.0,281.0,0.79,446.0,116.0,3.35,3.35,4.22,2.15,35.9,35.9,64.9,65.1,11.9,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(60,'110 x 110 x 16',25.71,32.7,110.0,110.0,16.0,10.0,4.8,3.32,3.32,357.0,357.0,0.79,565.0,149.0,3.3,3.3,4.15,2.14,46.5,46.5,84.1,84.2,27.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(61,'130 x 130 x 8',15.92,20.2,130.0,130.0,8.0,10.0,4.8,3.5,3.5,330.0,330.0,0.79,526.0,135.0,4.04,4.04,5.1,2.58,34.8,34.8,63.0,63.1,4.3,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(62,'130 x130 x 10',19.72,25.1,130.0,130.0,10.0,10.0,4.8,3.59,3.59,405.0,405.0,0.79,644.0,165.0,4.02,4.02,5.07,2.57,43.1,43.1,77.8,77.9,8.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(63,'130 x130 x 12',23.45,29.8,130.0,130.0,12.0,10.0,4.8,3.67,3.67,476.0,476.0,0.79,757.0,195.0,3.99,3.99,5.04,2.56,51.0,51.0,92.2,92.3,14.2,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(64,'130 x130 x 16',30.74,39.1,130.0,130.0,16.0,10.0,4.8,3.82,3.82,609.0,609.0,0.79,966.0,252.0,3.94,3.94,4.97,2.54,66.3,66.3,119.0,120.0,33.3,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(65,'150 x 150 x 10',22.93,29.2,150.0,150.0,10.0,12.0,4.8,4.08,4.08,633.0,633.0,0.79,1000.0,259.0,4.66,4.66,5.87,2.98,58.0,58.0,104.0,104.0,9.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(66,'150 x 150 x 12',27.29,34.7,150.0,150.0,12.0,12.0,4.8,4.16,4.16,746.0,746.0,0.79,1180.0,305.0,4.63,4.63,5.84,2.96,68.8,68.8,124.0,124.0,16.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(67,'150 x 150 x 16',35.84,45.6,150.0,150.0,16.0,12.0,4.8,4.31,4.31,958.0,958.0,0.79,1520.0,394.0,4.58,4.58,5.78,2.94,89.7,89.7,162.0,162.0,38.7,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(68,'150 x 150 x 20',44.12,56.2,150.0,150.0,20.0,12.0,4.8,4.46,4.46,1150.0,1150.0,0.79,1830.0,480.0,4.53,4.53,5.71,2.92,109.0,109.0,198.0,198.0,74.6,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(69,'200 x 200 x 12',36.85,46.9,200.0,200.0,12.0,15.0,4.8,5.39,5.39,1820.0,1820.0,0.79,2900.0,746.0,6.24,6.24,7.87,3.99,125.0,125.0,225.0,225.0,22.3,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(70,'200 x 200 x 16',48.53,61.8,200.0,200.0,16.0,15.0,4.8,5.56,5.56,2360.0,2360.0,0.79,3760.0,967.0,6.19,6.19,7.8,3.96,163.0,163.0,295.0,295.0,52.4,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(71,'200 x 200 x 20',59.96,76.3,200.0,200.0,20.0,15.0,4.8,5.71,5.71,2870.0,2870.0,0.79,4560.0,1180.0,6.13,6.13,7.73,3.93,201.0,201.0,362.0,363.0,101.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(72,'200 x 200 x 25',73.9,94.1,200.0,200.0,25.0,15.0,4.8,5.9,5.9,3470.0,3470.0,0.79,5500.0,1430.0,6.07,6.07,7.65,3.91,246.0,246.0,443.0,444.0,195.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(73,'50 x 50 x 7',5.17,6.59,50.0,50.0,7.0,6.0,0.0,1.5,1.5,14.9,14.9,0.79,23.6,6.27,1.51,1.51,1.89,0.98,4.26,4.26,7.67,7.7,1.06,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(74,'50 x 50 x 8',5.84,7.44,50.0,50.0,8.0,6.0,0.0,1.54,1.54,16.6,16.6,0.79,26.2,7.03,1.49,1.49,1.88,0.97,4.79,4.79,8.62,8.65,1.57,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(75,'55 x 55 x 10',7.92,10.0,55.0,55.0,10.0,6.5,0.0,1.73,1.73,26.8,26.8,0.79,42.1,11.5,1.63,1.63,2.04,1.07,7.11,7.11,12.8,12.8,3.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(76,'60 x 60 x 10',8.71,11.0,60.0,60.0,10.0,6.5,0.0,1.86,1.86,35.5,35.5,0.79,55.9,15.1,1.79,1.79,2.25,1.17,8.57,8.57,15.4,15.4,3.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(77,'65 x 65 x 10',9.49,12.0,65.0,65.0,10.0,6.5,0.0,1.98,1.98,45.9,45.9,0.79,72.5,19.4,1.95,1.95,2.45,1.27,10.1,10.1,18.3,18.3,4.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(78,'70 x 70 x 7',7.39,9.42,70.0,70.0,7.0,7.0,0.0,2.0,2.0,43.4,43.4,0.79,68.8,17.9,2.15,2.15,2.7,1.38,8.66,8.66,15.5,15.6,1.52,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(79,'100 x 100 x 7',10.73,13.6,100.0,100.0,7.0,8.5,0.0,2.74,2.74,132.0,132.0,0.79,210.0,54.2,3.11,3.11,3.92,1.99,18.2,18.2,32.7,32.7,2.2,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(80,'100 x 100 x 15',21.91,27.9,100.0,100.0,15.0,8.5,0.0,3.04,3.04,252.0,252.0,0.79,398.0,106.0,3.01,3.01,3.78,1.95,36.2,36.2,65.3,65.4,20.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(81,'120 x 120 x 8',14.66,18.6,120.0,120.0,8.0,10.0,4.8,3.25,3.25,258.0,258.0,0.79,410.0,105.0,3.72,3.72,4.69,2.38,29.5,29.5,53.4,53.5,3.95,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(82,'120 x 120 x 10',18.15,23.1,120.0,120.0,10.0,10.0,4.8,3.34,3.34,315.0,315.0,0.79,501.0,129.0,3.69,3.69,4.66,2.36,36.4,36.4,65.9,66.0,7.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(83,'120 x 120 x 12',21.57,27.4,120.0,120.0,12.0,10.0,4.8,3.42,3.42,370.0,370.0,0.79,588.0,152.0,3.67,3.67,4.63,2.35,43.1,43.1,78.0,78.1,13.1,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(84,'120 x 120 x 15',26.58,33.8,120.0,120.0,15.0,10.0,4.8,3.53,3.53,447.0,447.0,0.79,709.0,185.0,3.64,3.64,4.58,2.34,52.8,52.8,95.5,95.6,25.3,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(85,'130 x 130 x 9',17.82,22.7,130.0,130.0,9.0,10.0,4.8,3.55,3.55,368.0,368.0,0.79,586.0,150.0,4.03,4.03,5.08,2.57,39.0,39.0,70.5,70.6,6.09,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(86,'150 x 150 x 15',33.72,42.9,150.0,150.0,15.0,12.0,4.8,4.28,4.28,907.0,907.0,0.79,1440.0,372.0,4.6,4.6,5.79,2.95,84.6,84.6,152.0,152.0,32.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(87,'150 x 150 x 18',40.01,50.9,150.0,150.0,18.0,12.0,4.8,4.39,4.39,1050.0,1050.0,0.79,1680.0,437.0,4.56,4.56,5.74,2.93,99.8,99.8,180.0,180.0,54.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(88,'180 x 180 x 15',41.09,52.3,180.0,180.0,15.0,18.0,4.8,5.0,5.0,1610.0,1610.0,0.79,2550.0,663.0,5.55,5.55,6.99,3.56,123.0,123.0,223.0,223.0,38.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(89,'180 x 180 x 18',48.79,62.1,180.0,180.0,18.0,18.0,4.8,5.12,5.12,1880.0,1880.0,0.79,2990.0,778.0,5.51,5.51,6.94,3.54,146.0,146.0,264.0,264.0,66.4,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(90,'180 x 180 x 20',53.85,68.6,180.0,180.0,20.0,18.0,4.8,5.2,5.2,2060.0,2060.0,0.79,3270.0,853.0,5.49,5.49,6.91,3.53,161.0,161.0,290.0,291.0,90.6,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(91,'200 x 200 x 24',71.31,90.8,200.0,200.0,24.0,18.0,4.8,5.85,5.85,3350.0,3350.0,0.79,5320.0,1390.0,6.08,6.08,7.65,3.91,237.0,237.0,427.0,428.0,173.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(92,'30 x 20 x 3',1.14,1.45,30.0,20.0,3.0,4.5,0.0,0.99,0.51,1.29,0.46,1.05,1.47,0.27,0.94,0.56,1.01,0.43,0.64,0.31,1.16,0.56,0.042000000000000001776,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(93,'30 x 20 x 4',1.48,1.88,30.0,20.0,4.0,4.5,0.0,1.04,0.55,1.63,0.57,0.4,1.85,0.34,0.93,0.55,0.99,0.43,0.83,0.39,1.48,0.73,0.098000000000000024868,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(94,'30 x 20 x 5',1.8,2.29,30.0,20.0,5.0,4.5,0.0,1.07,0.58,1.93,0.67,0.39,2.19,0.41,0.92,0.54,0.98,0.42,1.0,0.47,1.79,0.9,0.18700000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(95,'40 x 25 x 3',1.5,1.91,40.0,25.0,3.0,5.0,0.0,1.32,0.59,3.11,0.94,0.37,3.48,0.57,1.27,0.7,1.35,0.54,1.16,0.49,2.08,0.9,0.055,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(96,'40 x 25 x 4',1.96,2.49,40.0,25.0,4.0,5.0,0.0,1.36,0.63,3.97,1.19,0.36,4.44,0.72,1.26,0.69,1.33,0.54,1.5,0.64,2.69,1.18,0.13,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(97,'40 x 25 x 5',2.4,3.05,40.0,25.0,5.0,5.0,0.0,1.4,0.67,4.76,1.42,0.36,5.31,0.87,1.25,0.68,1.32,0.53,1.83,0.77,3.27,1.45,0.25,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(98,'40 x 25 x 6',2.82,3.59,40.0,25.0,6.0,5.0,0.0,1.44,0.7,5.5,1.62,0.35,6.1,1.02,1.24,0.67,1.3,0.53,2.15,0.9,3.81,1.72,0.42400000000000002131,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(99,'45 x 30 x 3',1.74,2.21,45.0,30.0,3.0,5.0,0.0,1.44,0.71,4.57,1.65,0.41,5.26,0.96,1.44,0.86,1.54,0.66,1.49,0.72,2.7,1.29,0.064000000000000003552,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(100,'45 x 30 x 4',2.27,2.89,45.0,30.0,4.0,5.0,0.0,1.48,0.74,5.87,2.1,0.41,6.75,1.22,1.42,0.85,1.53,0.65,1.95,0.93,3.5,1.69,0.15099999999999999644,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(101,'45 x 30 x 5',2.79,3.55,45.0,30.0,5.0,5.0,0.0,1.52,0.78,7.08,2.51,0.4,8.11,1.48,1.41,0.84,1.51,0.64,2.38,1.13,4.27,2.08,0.29099999999999997868,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(102,'45 x 30 x 6',3.29,4.19,45.0,30.0,6.0,5.0,0.0,1.56,0.82,8.21,2.89,0.4,9.37,1.73,1.4,0.83,1.49,0.64,2.79,1.32,5.0,2.46,0.49599999999999999644,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(103,'50 x 30 x 3',1.86,2.37,50.0,30.0,3.0,5.5,0.0,1.64,0.67,6.13,1.69,0.35,6.79,1.03,1.61,0.84,1.69,0.66,1.83,0.73,3.28,1.31,0.069000000000000003552,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(104,'50 x 30 x 4',2.44,3.1,50.0,30.0,4.0,5.5,0.0,1.69,0.71,7.89,2.15,0.34,8.73,1.32,1.59,0.83,1.68,0.65,2.38,0.94,4.26,1.72,0.16200000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(105,'50 x 30 x 5',2.99,3.81,50.0,30.0,5.0,5.5,0.0,1.73,0.75,9.53,2.58,0.34,10.5,1.59,1.58,0.82,1.66,0.65,2.92,1.15,5.19,2.13,0.31200000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(106,'50 x 30 x 6',3.54,4.5,50.0,30.0,6.0,5.5,0.0,1.77,0.79,11.1,2.97,0.33,12.2,1.86,1.57,0.81,1.64,0.64,3.43,1.34,6.09,2.52,0.53200000000000002842,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(107,'60 x 40 x 5',3.79,4.83,60.0,40.0,5.0,6.0,0.0,1.97,0.98,17.5,6.28,0.41,20.2,3.65,1.91,1.14,2.04,0.87,4.35,2.08,7.83,3.77,0.39500000000000001776,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(108,'60 x 40 x 6',4.49,5.72,60.0,40.0,6.0,6.0,0.0,2.01,1.02,20.5,7.29,0.41,23.5,4.26,1.89,1.13,2.03,0.86,5.13,2.45,9.21,4.47,0.67600000000000015631,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(109,'60 x 40 x 8',5.84,7.44,60.0,40.0,8.0,6.0,0.0,2.08,1.09,25.9,9.12,0.4,29.6,5.45,1.87,1.11,1.99,0.86,6.62,3.14,11.8,5.83,1.57,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(110,'65 x 45 x 5',4.18,5.33,65.0,45.0,5.0,6.0,0.0,2.09,1.1,22.8,9.02,0.44,26.7,5.12,2.07,1.3,2.24,0.98,5.16,2.65,9.33,4.77,0.43700000000000001065,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(111,'65 x 45 x 6',4.96,6.32,65.0,45.0,6.0,6.0,0.0,2.13,1.14,26.7,10.5,0.44,31.2,5.99,2.06,1.29,2.22,0.97,6.1,3.12,11.0,5.66,0.74800000000000004263,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(112,'65 x 45 x 8',6.47,8.24,65.0,45.0,8.0,6.0,0.0,2.2,1.21,33.9,13.2,0.43,39.5,7.66,2.03,1.27,2.19,0.96,7.89,4.02,14.1,7.39,1.74,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(113,'70 x 45 x 5',4.39,5.59,70.0,45.0,5.0,6.5,0.0,2.29,1.06,28.0,9.2,0.39,31.8,5.42,2.24,1.28,2.39,0.98,5.95,2.68,10.7,4.82,0.4580000000000000071,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(114,'70 x 45 x 6',5.21,6.63,70.0,45.0,6.0,6.5,0.0,2.33,1.1,32.8,10.7,0.39,37.2,6.34,2.23,1.27,2.37,0.98,7.04,3.15,12.6,5.72,0.78399999999999998578,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(115,'70 x 45 x 8',6.79,8.65,70.0,45.0,8.0,6.5,0.0,2.41,1.18,41.8,13.5,0.38,47.2,8.1,2.2,1.25,2.34,0.97,9.12,4.06,16.3,7.5,1.82,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(116,'70 x 45 x 10',8.31,10.5,70.0,45.0,10.0,6.5,0.0,2.49,1.25,50.0,16.0,0.37,56.2,9.81,2.17,1.23,2.3,0.96,11.0,4.91,19.7,9.22,3.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(117,'75 x 50 x 5',4.78,6.09,75.0,50.0,5.0,6.5,0.0,2.41,1.18,35.1,12.7,0.41,40.5,7.32,2.4,1.44,2.58,1.1,6.9,3.32,12.4,5.95,0.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(118,'75 x 50 x 6',5.68,7.23,75.0,50.0,6.0,6.5,0.0,2.45,1.22,41.2,14.8,0.41,47.5,8.57,2.39,1.43,2.56,1.09,8.17,3.92,14.7,7.07,0.85600000000000004973,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(119,'75 x 50 x 8',7.42,9.45,75.0,50.0,8.0,6.5,0.0,2.53,1.29,52.7,18.7,0.41,60.5,10.9,2.36,1.41,2.53,1.08,10.6,5.05,19.0,9.25,1.99,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(120,'75 x 50 x 10',9.1,11.5,75.0,50.0,10.0,6.5,0.0,2.61,1.37,63.2,22.3,0.4,72.2,13.3,2.34,1.39,2.5,1.07,12.9,6.13,23.1,11.3,3.83,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(121,'80 x 50 x 5',4.99,6.36,80.0,50.0,5.0,7.0,0.0,2.62,1.14,42.0,12.9,0.37,47.3,7.68,2.57,1.43,2.73,1.1,7.81,3.34,14.0,5.99,0.52,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(122,'80 x 50 x 6',5.92,7.55,80.0,50.0,6.0,7.0,0.0,2.66,1.18,49.4,15.1,0.37,55.5,8.99,2.56,1.41,2.71,1.09,9.25,3.95,16.5,7.13,0.89199999999999999289,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(123,'80 x 50 x 8',7.74,9.87,80.0,50.0,8.0,7.0,0.0,2.74,1.26,63.2,19.1,0.37,70.8,11.5,2.53,1.39,2.68,1.08,12.0,5.09,21.4,9.36,2.08,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(124,'80 x 50 x 10',9.5,12.1,80.0,50.0,10.0,7.0,0.0,2.82,1.33,76.0,22.7,0.36,84.7,13.9,2.5,1.37,2.65,1.07,14.6,6.18,26.0,11.5,4.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(125,'90 x 60 x 6',6.88,8.76,90.0,60.0,6.0,7.5,0.0,2.9,1.42,72.8,26.3,0.41,84.0,15.2,2.88,1.73,3.1,1.32,11.9,5.74,21.5,10.2,1.03,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(126,'90 x 60 x 8',9.01,11.4,90.0,60.0,8.0,7.5,0.0,2.98,1.49,93.6,33.5,0.41,107.0,19.5,2.86,1.71,3.06,1.3,15.5,7.44,27.9,13.4,2.42,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(127,'90 x 60 x 10',11.08,14.1,90.0,60.0,10.0,7.5,0.0,3.06,1.57,113.0,40.1,0.41,129.0,23.6,2.83,1.69,3.03,1.29,19.0,9.05,34.1,16.6,4.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(128,'90 x 60 x 12',13.09,16.6,90.0,60.0,12.0,7.5,0.0,3.13,1.64,131.0,46.2,0.4,149.0,27.6,2.8,1.66,3.0,1.29,22.3,10.6,39.9,19.7,7.94,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(129,'100 x 65 x 6',7.6,9.68,100.0,65.0,6.0,8.0,0.0,3.22,1.5,100.0,34.0,0.4,114.0,19.8,3.22,1.88,3.44,1.43,14.8,6.8,26.6,12.1,1.14,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(130,'100 x 65 x 8',9.97,12.7,100.0,65.0,8.0,8.0,0.0,3.3,1.57,129.0,43.5,0.4,147.0,25.5,3.19,1.85,3.4,1.42,19.3,8.8,34.6,15.9,2.67,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(131,'100 x 65 x 10',12.28,15.6,100.0,65.0,10.0,8.0,0.0,3.38,1.65,156.0,52.2,0.39,177.0,30.9,3.16,1.83,3.37,1.4,23.6,10.8,42.3,19.7,5.16,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(132,'100 x 75 x 6',8.08,10.3,100.0,75.0,6.0,8.5,0.0,3.05,1.82,105.0,51.2,0.5,128.0,27.6,3.19,2.23,3.54,1.64,15.1,9.0,27.4,16.0,1.21,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(133,'100 x 75 x 8',10.61,13.5,100.0,75.0,8.0,8.5,0.0,3.13,1.89,135.0,65.7,0.5,165.0,35.5,3.17,2.21,3.5,1.62,19.7,11.7,35.8,21.0,2.85,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(134,'100 x 75 x 10',13.07,16.6,100.0,75.0,10.0,8.5,0.0,3.21,1.97,164.0,79.2,0.5,200.0,43.0,3.14,2.18,3.47,1.61,24.2,14.3,43.8,25.9,5.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(135,'100 x 75 x 12',15.48,19.7,100.0,75.0,12.0,8.5,0.0,3.28,2.04,191.0,91.7,0.5,232.0,50.4,3.11,2.16,3.43,1.6,28.5,16.8,51.4,30.6,9.38,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(136,'125 x 75 x 6',9.27,11.8,125.0,75.0,6.0,9.0,0.0,4.08,1.62,194.0,54.3,0.35,215.0,32.7,4.05,2.14,4.27,1.66,23.1,9.2,41.3,16.4,1.39,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(137,'125 x 75 x 8',12.19,15.5,125.0,75.0,8.0,9.0,0.0,4.17,1.7,251.0,69.7,0.35,279.0,42.1,4.03,2.12,4.24,1.65,30.2,12.0,53.9,21.6,3.27,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(138,'125 x 75 x 10',15.05,19.1,125.0,75.0,10.0,9.0,0.0,4.26,1.78,306.0,84.1,0.35,339.0,51.0,4.0,2.09,4.21,1.63,37.2,14.7,66.2,26.7,6.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(139,'125 x 95 x 6',10.14,12.9,125.0,95.0,6.0,9.0,4.8,3.72,2.24,205.0,103.0,0.52,254.0,55.0,3.99,2.83,4.44,2.06,23.4,14.3,42.9,25.5,1.54,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(140,'125 x 95 x 8',13.37,17.0,125.0,95.0,8.0,9.0,4.8,3.8,2.32,268.0,134.0,0.52,331.0,71.4,3.97,2.81,4.41,2.05,30.9,18.8,56.4,33.7,3.61,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(141,'125 x 95 x 10',16.54,21.0,125.0,95.0,10.0,9.0,4.8,3.89,2.4,328.0,164.0,0.51,404.0,87.3,3.94,2.79,4.38,2.04,38.1,23.1,69.4,41.7,7.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(142,'125 x 95 x 12',19.65,25.0,125.0,95.0,12.0,9.0,4.8,3.97,2.48,384.0,191.0,0.51,473.0,102.0,3.92,2.77,4.35,2.02,45.1,27.3,82.0,49.5,11.9,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(143,'150 x 115 x 8',16.27,20.7,150.0,115.0,8.0,11.0,4.8,4.48,2.76,474.0,244.0,0.52,589.0,128.0,4.78,3.43,5.34,2.49,45.1,27.9,82.4,50.0,4.38,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(144,'150 x 115 x 10',20.14,25.6,150.0,115.0,10.0,11.0,4.8,4.57,2.84,581.0,298.0,0.52,722.0,157.0,4.76,3.41,5.31,2.48,55.8,34.5,101.0,61.9,8.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(145,'150 x 115 x 12',23.96,30.5,150.0,115.0,12.0,11.0,4.8,4.65,2.92,684.0,350.0,0.52,849.0,185.0,4.74,3.39,5.28,2.47,66.2,40.8,120.0,73.5,14.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(146,'150 x 115 x 16',31.4,40.0,150.0,115.0,16.0,11.0,4.8,4.81,3.07,878.0,446.0,0.52,1080.0,239.0,4.69,3.34,5.21,2.44,86.2,53.0,156.0,96.1,33.9,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(147,'200 x 100 x 10',22.93,29.2,200.0,100.0,10.0,12.0,4.8,6.98,2.03,1220.0,214.0,0.26,1300.0,137.0,6.48,2.71,6.68,2.17,94.3,26.9,165.0,48.7,9.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(148,'200 x 100 x 12',27.29,34.7,200.0,100.0,12.0,12.0,4.8,7.07,2.11,1440.0,251.0,0.26,1530.0,161.0,6.46,2.69,6.65,2.15,112.0,31.9,196.0,58.3,16.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(149,'200 x 100 x 16',35.84,45.6,200.0,100.0,16.0,12.0,4.8,7.23,2.27,1870.0,319.0,0.25,1980.0,207.0,6.4,2.65,6.59,2.13,146.0,41.3,255.0,77.5,38.7,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(150,'200 x 150 x 10',26.92,34.2,200.0,150.0,10.0,13.5,4.8,6.02,3.55,1400.0,688.0,0.51,1720.0,368.0,6.41,4.48,7.1,3.28,100.0,60.2,183.0,107.0,11.3,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(151,'200 x 150 x 12',32.07,40.8,200.0,150.0,12.0,13.5,4.8,6.11,3.63,1660.0,812.0,0.51,2040.0,433.0,6.39,4.46,7.07,3.26,119.0,71.4,218.0,127.0,19.4,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(152,'200 x 150 x 16',42.18,53.7,200.0,150.0,16.0,13.5,4.8,6.27,3.79,2150.0,1040.0,0.5,2630.0,560.0,6.33,4.41,7.01,3.23,156.0,93.2,285.0,167.0,45.6,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(153,'200 x 150 x 20',52.04,66.2,200.0,150.0,20.0,13.5,4.8,6.42,3.94,2610.0,1260.0,0.5,3190.0,682.0,6.28,4.36,6.94,3.21,192.0,114.0,349.0,206.0,88.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(154,'40 x 20 x 3',1.37,1.74,40.0,20.0,3.0,4.0,0.0,1.43,0.45,2.9,0.49,0.25,3.04,0.32,1.28,0.53,1.32,0.43,1.11,0.32,1.95,0.59,0.050999999999999996447,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(155,'40 x 20 x 4',1.79,2.27,40.0,20.0,4.0,4.0,0.0,1.47,0.49,3.7,0.62,0.25,3.86,0.41,1.27,0.52,1.3,0.42,1.45,0.41,2.52,0.78,0.11899999999999999467,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(156,'40 x 20 x 5',2.19,2.78,40.0,20.0,5.0,4.0,0.0,1.51,0.52,4.4,0.73,0.24,4.62,0.49,1.25,0.51,1.29,0.42,1.76,0.49,3.05,0.97,0.22900000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(157,'60 x 30 x 5',3.4,4.33,60.0,30.0,5.0,6.0,0.0,2.16,0.69,15.9,2.7,0.25,16.8,1.76,1.92,0.79,1.97,0.64,4.14,1.17,7.24,2.21,0.35400000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(158,'60 x 30 x 6',4.02,5.12,60.0,30.0,6.0,6.0,0.0,2.21,0.73,18.5,3.11,0.25,19.6,2.06,1.9,0.78,1.96,0.63,4.88,1.37,8.5,2.64,0.60400000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(159,'60 x 40 x 7',5.17,6.59,60.0,40.0,7.0,6.0,0.0,2.05,1.06,23.3,8.23,0.4,26.6,4.86,1.88,1.12,2.01,0.86,5.89,2.8,10.5,5.16,1.06,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(160,'65 x 50 x 5',4.38,5.58,65.0,50.0,5.0,6.0,0.0,2.0,1.26,23.6,12.2,0.52,29.3,6.48,2.06,1.48,2.29,1.08,5.25,3.27,9.53,5.85,0.4580000000000000071,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(161,'65 x 50 x 6',5.19,6.62,65.0,50.0,6.0,6.0,0.0,2.04,1.3,27.6,14.2,0.52,34.3,7.59,2.04,1.47,2.28,1.07,6.2,3.85,11.2,6.93,0.78399999999999998578,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(162,'65 x 50 x 7',6.0,7.64,65.0,50.0,7.0,6.0,0.0,2.08,1.34,31.5,16.2,0.52,39.0,8.67,2.03,1.45,2.26,1.07,7.13,4.42,12.9,7.99,1.23,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(163,'65 x 50 x 8',6.78,8.64,65.0,50.0,8.0,6.0,0.0,2.12,1.38,35.2,18.0,0.52,43.4,9.72,2.02,1.44,2.24,1.06,8.03,4.97,14.5,9.03,1.82,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(164,'70 x 50 x 5',4.57,5.83,70.0,50.0,5.0,6.0,0.0,2.21,1.22,29.0,12.5,0.46,34.5,6.92,2.23,1.46,2.43,1.09,6.05,3.3,10.9,5.9,0.47900000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(165,'70 x 50 x 6',5.43,6.92,70.0,50.0,6.0,6.0,0.0,2.25,1.26,34.0,14.5,0.46,40.4,8.11,2.22,1.45,2.42,1.08,7.16,3.89,12.9,7.0,0.82,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(166,'70 x 50 x 7',6.27,7.99,70.0,50.0,7.0,6.0,0.0,2.29,1.3,38.8,16.5,0.46,46.0,9.26,2.2,1.44,2.4,1.08,8.23,4.46,14.8,8.08,1.29,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(167,'70 x 50 x 8',7.09,9.04,70.0,50.0,8.0,6.0,0.0,2.33,1.33,43.4,18.4,0.46,51.4,10.3,2.19,1.43,2.38,1.07,9.28,5.01,16.7,9.14,1.91,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(168,'75 x 50 x 7',6.57,8.37,75.0,50.0,7.0,7.0,0.0,2.49,1.26,47.1,16.8,0.41,54.2,9.8,2.37,1.42,2.54,1.08,9.41,4.49,16.9,8.17,1.34,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(169,'80 x 40 x 5',4.6,5.86,80.0,40.0,5.0,7.0,0.0,2.82,0.86,39.0,6.74,0.26,41.4,4.36,2.58,1.07,2.66,0.86,7.53,2.14,13.1,3.94,0.47900000000000000355,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(170,'80 x 40 x 6',5.45,6.95,80.0,40.0,6.0,7.0,0.0,2.86,0.89,45.7,7.84,0.25,48.5,5.09,2.57,1.06,2.64,0.86,8.9,2.52,15.5,4.7,0.82,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(171,'80 x 40 x 7',6.29,8.02,80.0,40.0,7.0,7.0,0.0,2.91,0.93,52.2,8.87,0.25,55.3,5.8,2.55,1.05,2.63,0.85,10.2,2.89,17.8,5.47,1.29,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(172,'80 x 40 x 8',7.12,9.07,80.0,40.0,8.0,7.0,0.0,2.95,0.97,58.4,9.84,0.25,61.7,6.5,2.54,1.04,2.61,0.85,11.5,3.25,20.1,6.24,1.91,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(173,'80 x 60 x 6',6.42,8.18,80.0,60.0,6.0,8.0,0.0,2.48,1.5,52.6,25.5,0.5,64.3,13.8,2.54,1.77,2.8,1.3,9.5,5.7,17.3,10.1,0.96400000000000005684,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(174,'80 x 60 x 7',7.42,9.45,80.0,60.0,7.0,8.0,0.0,2.52,1.54,60.1,29.1,0.5,73.4,15.8,2.52,1.75,2.79,1.29,11.0,6.5,19.9,11.7,1.52,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(175,'80 x 60 x 8',8.4,10.7,80.0,60.0,8.0,8.0,0.0,2.56,1.57,67.4,32.5,0.5,82.2,17.7,2.51,1.74,2.77,1.29,12.4,7.3,22.4,13.3,2.25,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(176,'90 x 65 x 6',7.13,9.08,90.0,65.0,6.0,8.0,0.0,2.81,1.57,74.8,33.1,0.47,89.7,18.3,2.87,1.91,3.14,1.42,12.1,6.7,21.9,12.0,1.07,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(177,'90 x 65 x 7',8.24,10.5,90.0,65.0,7.0,8.0,0.0,2.85,1.61,85.7,37.8,0.47,102.0,20.9,2.86,1.9,3.13,1.41,13.9,7.7,25.2,13.9,1.69,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(178,'90 x 65 x 8',9.34,11.9,90.0,65.0,8.0,8.0,0.0,2.89,1.65,96.3,42.3,0.47,115.0,23.5,2.84,1.89,3.11,1.4,15.8,8.7,28.5,15.7,2.5,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(179,'90 x 65 x 10',11.49,14.6,90.0,65.0,10.0,8.0,0.0,2.97,1.73,116.0,50.7,0.47,138.0,28.4,2.82,1.86,3.08,1.39,19.3,10.6,34.8,19.3,4.83,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(180,'100 x 50 x 6',6.92,8.81,100.0,50.0,6.0,9.0,0.0,3.51,1.06,91.9,15.9,0.26,97.5,10.3,3.23,1.34,3.33,1.08,14.2,4.0,24.8,7.4,1.03,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(181,'100 x 50 x 7',7.99,10.1,100.0,50.0,7.0,9.0,0.0,3.56,1.1,105.0,18.1,0.26,111.0,11.7,3.21,1.33,3.31,1.07,16.3,4.6,28.6,8.6,1.63,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(182,'100 x 50 x 8',9.05,11.5,100.0,50.0,8.0,9.0,0.0,3.6,1.14,118.0,20.2,0.25,125.0,13.1,3.2,1.32,3.29,1.07,18.5,5.2,32.2,9.8,2.42,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(183,'100 x 50 x 10',11.13,14.1,100.0,50.0,10.0,9.0,0.0,3.68,1.21,142.0,24.0,0.25,150.0,15.9,3.17,1.3,3.26,1.06,22.6,6.3,39.3,12.2,4.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(184,'100 x 65 x 7',8.85,11.2,100.0,65.0,7.0,10.0,0.0,3.25,1.53,115.0,38.9,0.4,131.0,22.8,3.2,1.86,3.41,1.42,17.1,7.8,30.7,14.1,1.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(185,'120 x 80 x 8',12.26,15.6,120.0,80.0,8.0,11.0,0.0,3.85,1.89,230.0,83.2,0.41,265.0,48.1,3.84,2.31,4.12,1.75,28.3,13.6,51.0,24.4,3.27,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(186,'120 x 80 x 10',15.12,19.2,120.0,80.0,10.0,11.0,0.0,3.94,1.96,280.0,100.0,0.41,322.0,58.3,3.81,2.28,4.09,1.74,34.8,16.6,62.6,30.1,6.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(187,'120 x 80 x 12',17.91,22.8,120.0,80.0,12.0,11.0,0.0,4.02,2.04,327.0,116.0,0.41,375.0,68.1,3.79,2.26,4.06,1.73,41.0,19.6,73.7,35.7,10.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(188,'125 x 75 x 12',17.91,22.8,125.0,75.0,12.0,11.0,0.0,4.32,1.85,358.0,97.5,0.34,396.0,59.8,3.97,2.07,4.17,1.62,43.9,17.3,78.1,31.8,10.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(189,'135 x 65 x 8',12.18,15.5,135.0,65.0,8.0,11.0,4.8,4.79,1.35,292.0,45.5,0.24,308.0,29.7,4.34,1.71,4.46,1.38,33.6,8.8,59.0,16.4,3.27,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(190,'135 x 65 x 10',15.04,19.1,135.0,65.0,10.0,11.0,4.8,4.88,1.43,357.0,55.0,0.24,376.0,36.1,4.32,1.69,4.43,1.37,41.4,10.8,72.5,20.5,6.33,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(191,'135 x 65 x 12',17.84,22.7,135.0,65.0,12.0,11.0,4.8,4.97,1.51,418.0,63.9,0.24,440.0,42.3,4.29,1.68,4.4,1.36,49.0,12.8,85.4,24.6,10.8,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(192,'150 x 75 x 9',15.39,19.6,150.0,75.0,9.0,11.0,4.8,5.28,1.58,457.0,78.8,0.26,485.0,50.7,4.83,2.01,4.98,1.61,47.1,13.3,82.8,24.5,5.24,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(193,'150 x 75 x 15',24.85,31.6,150.0,75.0,15.0,11.0,4.8,5.53,1.81,715.0,120.0,0.25,755.0,79.1,4.75,1.95,4.89,1.58,75.5,21.1,131.0,40.7,23.6,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(194,'150 x 90 x 10',18.22,23.2,150.0,90.0,10.0,12.0,4.8,5.0,2.04,536.0,147.0,0.35,594.0,89.1,4.81,2.52,5.06,1.96,53.6,21.2,96.2,38.4,7.66,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(195,'150 x 90 x 12',21.64,27.5,150.0,90.0,12.0,12.0,4.8,5.09,2.12,630.0,172.0,0.34,698.0,104.0,4.78,2.5,5.03,1.95,63.6,25.0,113.0,45.8,13.1,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(196,'150 x 90 x 15',26.66,33.9,150.0,90.0,15.0,12.0,4.8,5.21,2.24,764.0,206.0,0.34,843.0,126.0,4.74,2.47,4.98,1.93,78.0,30.6,139.0,56.7,25.3,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(197,'200 x 100 x 15',33.86,43.1,200.0,100.0,15.0,15.0,4.8,7.17,2.23,1770.0,303.0,0.25,1870.0,196.0,6.41,2.65,6.6,2.13,138.0,39.0,241.0,72.9,32.0,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(198,'200 x 150 x 15',39.75,50.6,200.0,150.0,15.0,15.0,4.8,6.22,3.75,2030.0,988.0,0.5,2490.0,530.0,6.34,4.42,7.02,3.24,147.0,87.8,268.0,157.0,37.6,'IS808_Rev',NULL);
INSERT INTO public."Angles" VALUES(199,'200 x 150 x 18',47.21,60.1,200.0,150.0,18.0,15.0,4.8,6.34,3.86,2390.0,1150.0,0.5,2920.0,623.0,6.3,4.38,6.97,3.22,175.0,103.0,317.0,187.0,64.5,'IS808_Rev',NULL);
COMMIT;
