create table if not exists rol(
	idrol text primary key not null,
	rol text
);

create table if not exists usuario(
	idusuario text primary key not null,
	nombre text,
	correo text,
	contra text,
	idrol text references rol(idrol)
);

create table if not exists proyecto(
	idproyecto text primary key not null,
	titulo text,
	descripcion text,
	areaprofundizacion text,
	modalidad text,
	pregunta text,
	unidadcronograma text,
	grupoinvestigacion text,
	ciudad text,
	fecha text,
	universidad text,
	facultad text,
	programa text,
	logouniversidad text,
	idusuario text references usuario(idusuario)
);

create table if not exists asesor(
	idasesor text primary key not null,
	titulo text,
	tipo text,
	idproyecto text references proyecto(idproyecto),
	idusuario text references usuario(idusuario)
);

create table if not exists conclusion(
	idconclusion text primary key not null,
	conclusion text,
	idproyecto text references proyecto(idproyecto)
);

create table if not exists referencia(
	idreferencia text primary key not null,
	fecha text,
	titulo text,
	ciudad text,
	editorial text,
	link text,
	paginas text,
	universidad text,
	volumen text,
	titulocongreso text,
	nombrerevista text,
	tipotesis text,
	tiporeferencia text,
	idproyecto text references proyecto(idproyecto)
);

create table if not exists autor(
	idautor text primary key not null,
	nombre1 text,
	nombre2 text,
	apellido1 text,
	apellido2 text,
	idreferencia text references referencia(idreferencia)
);

create table if not exists antecedente(
	idantecedente text primary key not null,
	objetivos text,
	metodologia text,
	conclusiones text,
	idreferencia text references referencia(idreferencia),
	idproyecto text references proyecto(idproyecto)
);

create table if not exists investigador(
	idinvestigador text primary key not null,
	documento text,
	correo text,
	titulo text,
	dedicatoria text,
	agradecimientos text,
	idproyecto text references proyecto(idproyecto)
);

create table if not exists palabraclave(
	idpalabraclave text primary key not null,
	palabra text,
	idproyecto text references proyecto(idproyecto)
);

create table if not exists texto(
	idtexto text primary key not null,
	texto text,
	tipo text,
	orden text,
	idreferencia text references referencia(idreferencia),
	idproyecto text references proyecto(idproyecto)
);

create table if not exists fasemetodologia(
	idfasemetodologia text primary key not null,
	descripcion text,
	orden text,
	idproyecto text references proyecto(idproyecto)
);

create table if not exists fasetexto(
	idfasetexto text primary key not null,
	idtexto text references texto(idtexto),
	idfasemetodologia text references fasemetodologia(idfasemetodologia)
);

create table if not exists objetivo(
	idobjetivo text primary key not null,
	objetivo text,
	tipo text,
	idproyecto text references proyecto(idproyecto)
);

create table if not exists cronograma(
	idcronograma text primary key not null,
	descripcion text,
	duracion text,
	idobjetivo text references objetivo(idobjetivo),
	idfasemetodologia text references fasemetodologia(idfasemetodologia),
	idproyecto text references proyecto(idproyecto)	
);

create table if not exists resultado(
	idresultado text primary key not null,
	resultado text,
	idobjetivo text references objetivo(idobjetivo),
	idproyecto text references proyecto(idproyecto)
);

-- Crear una tabla para registrar los errores de la aplicación
create table if not exists error(
	iderror text primary key not null,
	hora text,
	fecha text,
	procedimiento text,
	mensaje text
);