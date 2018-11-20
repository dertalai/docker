				-------------------------------
				--  Actualización de tablas  --
				-------------------------------


-- Actualización tabla enmienda_presupuestaria
ALTER TABLE parlamento.enmienda_articulado ALTER COLUMN texto_justificacion TYPE varchar(16384);
ALTER TABLE parlamento.enmienda_articulado ALTER COLUMN texto_nuevo TYPE varchar(16384);
ALTER TABLE parlamento.enmienda_articulado ALTER COLUMN texto_original TYPE varchar(16384);

-- Actualización tabla enmienda_presupuestaria
ALTER TABLE parlamento.enmienda_presupuestaria ALTER COLUMN texto_justificacion TYPE varchar(16384);
ALTER TABLE parlamento.enmienda_presupuestaria ALTER COLUMN nueva_descripcion TYPE varchar(16384);
ALTER TABLE parlamento.enmienda_presupuestaria ALTER COLUMN texto_enmienda TYPE varchar(16384);


-- Actualización tabla tipo_enm_articulado
ALTER TABLE parlamento.tipo_enm_articulado RENAME COLUMN tipo_enmienda_articulado TO tipo_enm_articulado;
ALTER TABLE parlamento.tipo_enm_articulado ADD COLUMN letra_cod_enmienda varchar(3);
ALTER TABLE parlamento.tipo_enm_articulado ADD COLUMN texto_tipo_enmienda varchar(25);
UPDATE parlamento.tipo_enm_articulado SET letra_cod_enmienda = 'A', texto_tipo_enmienda = 'ADICIÓN' WHERE tipo_enm_articulado LIKE 'ADICION';
UPDATE parlamento.tipo_enm_articulado SET letra_cod_enmienda = 'M', texto_tipo_enmienda = 'MODIFICACIÓN' WHERE tipo_enm_articulado LIKE 'MODIFICACION';
UPDATE parlamento.tipo_enm_articulado SET letra_cod_enmienda = 'S', texto_tipo_enmienda = 'SUPRESIÓN' WHERE tipo_enm_articulado LIKE 'SUPRESION';
ALTER TABLE parlamento.tipo_enm_articulado ALTER COLUMN letra_cod_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enm_articulado ALTER COLUMN texto_tipo_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enm_articulado ADD CONSTRAINT uk_tipo_enm_articulado UNIQUE (tipo_enm_articulado);



-- Actualización tabla tipo_enmienda_presup
ALTER TABLE parlamento.tipo_enmienda_presup ADD COLUMN letra_cod_enmienda varchar(3);
ALTER TABLE parlamento.tipo_enmienda_presup ADD COLUMN texto_tipo_enmienda varchar(25);
ALTER TABLE parlamento.tipo_enmienda_presup ADD COLUMN texto_subtipo_enmienda varchar(25);
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'IA', texto_tipo_enmienda = 'INGRESO', texto_subtipo_enmienda = 'ADICIÓN' WHERE tipo_enmienda LIKE 'INGRESO' AND sub_tipo_enmienda LIKE 'ADICION';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'IC', texto_tipo_enmienda = 'INGRESO', texto_subtipo_enmienda = 'CREACIÓN' WHERE tipo_enmienda LIKE 'INGRESO' AND sub_tipo_enmienda LIKE 'CREACION';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'ID', texto_tipo_enmienda = 'INGRESO', texto_subtipo_enmienda = 'DISMINUCIÓN' WHERE tipo_enmienda LIKE 'INGRESO' AND sub_tipo_enmienda LIKE 'DISMINUCION';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'GC', texto_tipo_enmienda = 'GASTO', texto_subtipo_enmienda = 'CREACIÓN' WHERE tipo_enmienda LIKE 'GASTO' AND sub_tipo_enmienda LIKE 'CREACION';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'GA', texto_tipo_enmienda = 'GASTO', texto_subtipo_enmienda = 'AUMENTO' WHERE tipo_enmienda LIKE 'GASTO' AND sub_tipo_enmienda LIKE 'AUMENTO';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'GD', texto_tipo_enmienda = 'GASTO', texto_subtipo_enmienda = 'DISMINUCIÓN' WHERE tipo_enmienda LIKE 'GASTO' AND sub_tipo_enmienda LIKE 'DISMINUCION';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'GM', texto_tipo_enmienda = 'GASTO', texto_subtipo_enmienda = 'MODIFICACIÓN' WHERE tipo_enmienda LIKE 'GASTO' AND sub_tipo_enmienda LIKE 'MODIFICACION';
UPDATE parlamento.tipo_enmienda_presup SET letra_cod_enmienda = 'GR', texto_tipo_enmienda = 'GASTO', texto_subtipo_enmienda = 'REDISTRIBUCIÓN' WHERE tipo_enmienda LIKE 'GASTO' AND sub_tipo_enmienda LIKE 'REDISTRIBUCION';

ALTER TABLE parlamento.tipo_enmienda_presup ALTER COLUMN letra_cod_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enmienda_presup ALTER COLUMN tipo_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enmienda_presup ALTER COLUMN sub_tipo_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enmienda_presup ALTER COLUMN texto_tipo_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enmienda_presup ALTER COLUMN texto_subtipo_enmienda SET NOT NULL;
ALTER TABLE parlamento.tipo_enmienda_presup ALTER COLUMN enabled SET NOT NULL;
ALTER TABLE parlamento.tipo_enmienda_presup ADD CONSTRAINT uk_tipo_enm_presupuestaria UNIQUE (tipo_enmienda, sub_tipo_enmienda);
