INSERT INTO parlamento.tipo_enm_articulado (id, tipo_enmienda_articulado) VALUES
(nextval('parlamento.seq_tipo_enm_articulado'),'ADICION'),
(nextval('parlamento.seq_tipo_enm_articulado'),'MODIFICACION'),
(nextval('parlamento.seq_tipo_enm_articulado'),'SUPRESION');


INSERT INTO parlamento.tipo_enmienda_presup (id,sub_tipo_enmienda,tipo_enmienda) VALUES
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'ADICION','INGRESO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'CREACION','INGRESO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'DISMINUCION','INGRESO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'CREACION','GASTO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'AUMENTO','GASTO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'DISMINUCION','GASTO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'MODIFICACION','GASTO'),
(nextval('parlamento.seq_tipo_enm_presupuestaria'),'REDISTRIBUCION','GASTO');
