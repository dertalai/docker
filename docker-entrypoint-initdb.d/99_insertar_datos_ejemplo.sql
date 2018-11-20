INSERT INTO parlamento.ggpp (id,letra_codigo_enmienda,nombre_abreviado,nombre_completo,ou_ldap,nombre_portavoz,texto_firma_portavoz) VALUES
(nextval('parlamento.seq_ggpp'),'S','SOCIALISTA','G.P. Socialista','PER. G. SOCIALISTA','Mario Jesús Jiménez Díaz',''),
(nextval('parlamento.seq_ggpp'),'P','POPULAR','G.P. Popular Andaluz','PER. G. SOCIALISTA',' Juan Manuel Moreno Bonilla',''),
(nextval('parlamento.seq_ggpp'),'I','IZQ. UNIDA','G.P. Izquierda Unida Los Verdes-Convocatoria por Andalucía','PER. G. IULV-CA','Antonio Maíllo Cañadas','');


INSERT INTO parlamento.proyecto_ley (id,activo,anio,flag_eliminado,expediente,f_fin_fiscalizacion,f_fin_registro,f_inicio_fiscalizacion,f_inicio_registro,fichero_access,nombre_fichero_pdf) VALUES
(nextval('parlamento.seq_proyecto_ley'),false,2007,NULL,'7-06/PL-000016',NULL,NULL,NULL,NULL,NULL,NULL),
(nextval('parlamento.seq_proyecto_ley'),false,2009,NULL,'8-08/PL-000004',NULL,NULL,NULL,NULL,NULL,NULL),
(nextval('parlamento.seq_proyecto_ley'),false,2010,NULL,'8-09/PL-000006',NULL,NULL,NULL,NULL,NULL,NULL),
(nextval('parlamento.seq_proyecto_ley'),false,2017,NULL,'10-16/PL-000004',NULL,NULL,NULL,NULL,NULL,NULL);
