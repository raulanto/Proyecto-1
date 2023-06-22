create table auth_item_group
(
    code       varchar(64)  not null
        primary key,
    name       varchar(255) not null,
    created_at int          null,
    updated_at int          null
)
    charset = utf8
    row_format = DYNAMIC;

create table auth_rule
(
    name       varchar(64) not null
        primary key,
    data       text        null,
    created_at int         null,
    updated_at int         null
)
    charset = utf8
    row_format = DYNAMIC;

create table auth_item
(
    name        varchar(64) not null
        primary key,
    type        int         not null,
    description text        null,
    rule_name   varchar(64) null,
    data        text        null,
    created_at  int         null,
    updated_at  int         null,
    group_code  varchar(64) null,
    constraint auth_item_ibfk_1
        foreign key (rule_name) references auth_rule (name)
            on update cascade on delete set null,
    constraint fk_auth_item_group_code
        foreign key (group_code) references auth_item_group (code)
            on update cascade on delete set null
)
    charset = utf8
    row_format = DYNAMIC;

create index `idx-auth_item-type`
    on auth_item (type);

create index rule_name
    on auth_item (rule_name);

create table auth_item_child
(
    parent varchar(64) not null,
    child  varchar(64) not null,
    primary key (parent, child),
    constraint auth_item_child_ibfk_1
        foreign key (parent) references auth_item (name)
            on update cascade on delete cascade,
    constraint auth_item_child_ibfk_2
        foreign key (child) references auth_item (name)
            on update cascade on delete cascade
)
    charset = utf8
    row_format = DYNAMIC;

create index child
    on auth_item_child (child);

create table eg_aniogeneracion
(
    ID       int auto_increment
        primary key,
    gen_anio varchar(9) not null
)
    row_format = DYNAMIC;

create table eg_cuestionario
(
    ID                         int(11) unsigned zerofill auto_increment
        primary key,
    cues_apepat                varchar(30)  null,
    cues_apemat                varchar(30)  null,
    cues_nombre                varchar(50)  null,
    cues_fkGenAnio             int          null,
    cues_numeroTelefonico      varchar(20)  null,
    cues_correo                varchar(50)  null,
    cues_titulo                varchar(2)   null,
    cues_anioTitulo            varchar(4)   null,
    cues_razon                 varchar(100) null,
    cues_estudioAdicional      varchar(2)   null,
    cues_tipoEstudio           varchar(25)  null,
    cues_nombreInstituto       varchar(50)  null,
    cues_conclusionEstudio     varchar(2)   null,
    cues_certificado           varchar(2)   null,
    cues_interesEstudio        varchar(2)   null,
    cues_temaEstudio           varchar(255) null,
    cues_prioridadInteres      varchar(255) null,
    cues_trabajo               varchar(2)   null,
    cues_tiempoEmpleo          varchar(25)  null,
    cues_nombreEmpresa         varchar(50)  null,
    cues_domicilioEmpresa      varchar(255) null,
    cues_telefonoEmpresa       varchar(20)  null,
    cues_correoEmpresa         varchar(50)  null,
    cues_regimen               varchar(15)  null,
    cues_tipoTrabajo           varchar(15)  null,
    cues_examen                varchar(2)   null,
    cues_posicionPre           varchar(10)  null,
    cues_puestaPractica        varchar(12)  null,
    cues_ideaPropia            varchar(12)  null,
    cues_reconocimiento        varchar(12)  null,
    cues_posibilidad           varchar(12)  null,
    cues_desarrolloEquipo      varchar(12)  null,
    cues_sectorEconomico       varchar(5)   null,
    cues_trabajoEconomico      varchar(5)   null,
    cues_iniciativaEmpresarial varchar(5)   null,
    cues_desicionProfesional   varchar(5)   null,
    cues_resolucionProblema    varchar(5)   null,
    cues_desarolloProyecto     varchar(5)   null,
    cues_interaccion           varchar(5)   null,
    cues_diagnostico           varchar(5)   null,
    cues_fomento               varchar(5)   null,
    cues_eleccion              varchar(2)   null,
    cues_carreraCurso          varchar(2)   null,
    cues_sugerencia            text         null,
    constraint eg_cuestionario_ibfk_1
        foreign key (cues_fkGenAnio) references eg_aniogeneracion (ID)
            on update cascade
)
    collate = utf8mb4_spanish_ci
    row_format = DYNAMIC;

create index cues_fkRazon
    on eg_cuestionario (cues_razon);

create index cuestionario_ibfk_1
    on eg_cuestionario (cues_fkGenAnio);

create table migration
(
    version    varchar(180) not null
        primary key,
    apply_time int          null
)
    engine = MyISAM
    row_format = DYNAMIC;

create table tu_archivo_copy1
(
    ID               int auto_increment
        primary key,
    nombre           varchar(255) collate utf8mb4_unicode_ci null,
    tipo             varchar(255) collate utf8mb4_unicode_ci null,
    tamano           int default 0                           null,
    descripcioncorta varchar(255) collate utf8mb4_unicode_ci null,
    descripcionlarga mediumtext collate utf8mb4_unicode_ci   null,
    createdat        int                                     null,
    updatedat        int                                     null,
    titulo           varchar(255) collate utf8mb4_unicode_ci null,
    ruta             varchar(255) collate utf8mb4_unicode_ci null,
    descargas        int default 0                           null,
    fkuser           int                                     null,
    nombretemporal   varchar(255) collate utf8mb4_unicode_ci null
)
    row_format = DYNAMIC;

create index arc_fkuser
    on tu_archivo_copy1 (fkuser);

create table user
(
    id                 int auto_increment
        primary key,
    username           varchar(255)          not null,
    auth_key           varchar(32)           not null,
    password_hash      varchar(255)          not null,
    confirmation_token varchar(255)          null,
    status             int         default 1 not null,
    superadmin         smallint    default 0 null,
    created_at         int                   not null,
    updated_at         int                   not null,
    registration_ip    varchar(15)           null,
    bind_to_ip         varchar(255)          null,
    email              varchar(128)          null,
    email_confirmed    smallint(1) default 0 not null
)
    charset = utf8
    row_format = DYNAMIC;

create table auth_assignment
(
    item_name  varchar(64) not null,
    user_id    int         not null,
    created_at int         null,
    primary key (item_name, user_id),
    constraint auth_assignment_ibfk_1
        foreign key (item_name) references auth_item (name)
            on update cascade on delete cascade,
    constraint auth_assignment_ibfk_2
        foreign key (user_id) references user (id)
            on update cascade on delete cascade
)
    charset = utf8
    row_format = DYNAMIC;

create index user_id
    on auth_assignment (user_id);

create table tu_archivo
(
    ID               int auto_increment
        primary key,
    nombre           varchar(255) collate utf8mb4_unicode_ci null,
    tipo             varchar(255) collate utf8mb4_unicode_ci null,
    tamano           int default 0                           null,
    descripcioncorta varchar(255) collate utf8mb4_unicode_ci null,
    descripcionlarga mediumtext collate utf8mb4_unicode_ci   null,
    createdat        int                                     null,
    updatedat        int                                     null,
    titulo           varchar(255) collate utf8mb4_unicode_ci null,
    ruta             varchar(255) collate utf8mb4_unicode_ci null,
    descargas        int default 0                           null,
    fkuser           int                                     null,
    nombretemporal   varchar(255) collate utf8mb4_unicode_ci null,
    constraint tu_archivo_ibfk_1
        foreign key (fkuser) references user (id)
)
    row_format = DYNAMIC;

create index arc_fkuser
    on tu_archivo (fkuser);

create table tu_areaapoyo
(
    ID               int auto_increment
        primary key,
    clave            varchar(40)  null,
    nombre           varchar(255) null,
    correo           varchar(255) null,
    telefono         varchar(20)  null,
    horario          varchar(255) null,
    foto             varchar(255) null,
    nombre_encargado varchar(255) null,
    lugar            varchar(255) null,
    created_at       int          null,
    updated_at       int          null,
    fk_user          int          null,
    constraint tu_areaapoyo_ibfk_1
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_user
    on tu_areaapoyo (fk_user);

create table tu_departamento
(
    ID           int auto_increment
        primary key,
    nombre       varchar(255) null,
    nombre_largo varchar(255) null,
    clave        varchar(20)  null,
    encargado    varchar(255) null,
    created_at   int          null,
    updated_at   int          null,
    fk_user      int          null,
    constraint tu_departamento_ibfk_1
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_user
    on tu_departamento (fk_user);

create table tu_estatu
(
    ID         int auto_increment
        primary key,
    nombre     varchar(30) null,
    created_at int         null,
    update_at  int         null,
    fk_user    int         null,
    constraint tu_estatu_ibfk_1
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table tu_cicloescolar
(
    ID           int auto_increment
        primary key,
    nombre       varchar(30)  null,
    nombre_largo varchar(255) null,
    fecha_inicio datetime     null,
    fecha_fin    datetime     null,
    fk_user      int          null,
    fk_estatus   int          null,
    created_at   int          null,
    updated_at   int          null,
    constraint tu_cicloescolar_ibfk_1
        foreign key (fk_user) references user (id),
    constraint tu_cicloescolar_ibfk_2
        foreign key (fk_estatus) references tu_estatu (ID)
)
    row_format = DYNAMIC;

create index fk_estatus
    on tu_cicloescolar (fk_estatus);

create index fk_user
    on tu_cicloescolar (fk_user);

create table tu_coordinadorinstitucional
(
    ID               int auto_increment
        primary key,
    rfc              varchar(13)  null,
    clave            varchar(50)  null,
    nombre           varchar(255) null,
    app_paterno      varchar(50)  null,
    app_materno      varchar(50)  null,
    telefono         varchar(20)  null,
    foto             varchar(255) null,
    correo           varchar(255) null,
    fk_departamento  int          null,
    fk_estatus       int          null,
    fecha_asignacion datetime     null,
    fecha_deja_cargo datetime     null,
    created_at       int          null,
    updated_at       int          null,
    fk_user          int          null,
    constraint tu_coordinadorinstitucional_ibfk_1
        foreign key (fk_departamento) references tu_departamento (ID),
    constraint tu_coordinadorinstitucional_ibfk_2
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_coordinadorinstitucional_ibfk_3
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_departamento
    on tu_coordinadorinstitucional (fk_departamento);

create index fk_estatus
    on tu_coordinadorinstitucional (fk_estatus);

create index fk_user
    on tu_coordinadorinstitucional (fk_user);

create table tu_diagnostico
(
    ID                 int auto_increment
        primary key,
    fk_cicloescolar    int               null,
    nombre             varchar(255)      null,
    fechaapertura      datetime          null,
    fechacierre        datetime          null,
    foto_portada       varchar(255)      null,
    created_at         int               null,
    updated_at         int               null,
    fk_user            int               null,
    bloqueo            tinyint default 0 null,
    activo             tinyint default 0 null,
    activo_administrar tinyint default 0 null,
    constraint tu_diagnostico_ibfk_1
        foreign key (fk_cicloescolar) references tu_cicloescolar (ID),
    constraint tu_diagnostico_ibfk_2
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_cicloescolar
    on tu_diagnostico (fk_cicloescolar);

create index fk_user
    on tu_diagnostico (fk_user);

create index fk_user
    on tu_estatu (fk_user);

create table tu_modalidad
(
    ID            int auto_increment
        primary key,
    nombre        varchar(255) null,
    max_semestres varchar(3)   null,
    created_at    int          null,
    updated_at    int          null,
    fk_user       int          null,
    constraint tu_modalidad_ibfk_1
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table tu_carrera
(
    ID            int auto_increment
        primary key,
    nombre        varchar(100) null,
    nombre_largo  varchar(100) null,
    clave         varchar(50)  null,
    max_semestres varchar(3)   null,
    fk_estatus    int          null,
    fk_modalidad  int          null,
    plan          varchar(40)  null,
    creditos      varchar(10)  null,
    created_at    int          null,
    updated_at    int          null,
    fk_user       int          null,
    constraint tu_carrera_ibfk_1
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_carrera_ibfk_2
        foreign key (fk_modalidad) references tu_modalidad (ID),
    constraint tu_carrera_ibfk_3
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_estatus
    on tu_carrera (fk_estatus);

create index fk_modalidad
    on tu_carrera (fk_modalidad);

create index fk_user
    on tu_carrera (fk_user);

create index fk_user
    on tu_modalidad (fk_user);

create table tu_movimiento
(
    ID         int auto_increment
        primary key,
    nombre     varchar(50) null,
    horas      varchar(50) null,
    created_at int         null,
    updated_at int         null,
    fk_user    int         null,
    constraint tu_movimiento_ibfk_1
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table tu_docente
(
    ID               int auto_increment
        primary key,
    clave            varchar(12)  null,
    rfc              varchar(13)  null,
    curp             varchar(18)  null,
    nombre           varchar(255) null,
    ape_paterno      varchar(255) null,
    ape_materno      varchar(255) null,
    fecha_nacimiento date         null,
    fecha_ingreso    date         null,
    fk_movimiento    int          null,
    horas            int          null,
    fk_departamento  int          null,
    carrera          varchar(255) null,
    maestria         varchar(255) null,
    especialidad     varchar(255) null,
    doctorado        varchar(255) null,
    created_at       int          null,
    updated_at       int          null,
    fk_user          int          null,
    constraint tu_docente_ibfk_1
        foreign key (fk_movimiento) references tu_movimiento (ID),
    constraint tu_docente_ibfk_2
        foreign key (fk_departamento) references tu_departamento (ID),
    constraint tu_docente_ibfk_3
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table tu_coordinadordepartamento
(
    ID                   int auto_increment
        primary key,
    fk_docente           int      null,
    fk_departamento      int      null,
    fecha_asignacion     datetime null,
    fecha_inicio_labores datetime null,
    fk_coordinador_ins   int      null,
    fk_estatus           int      null,
    created_at           int      null,
    updated_at           int      null,
    fk_user              int      null,
    constraint tu_coordinadordepartamento_ibfk_1
        foreign key (fk_docente) references tu_docente (ID),
    constraint tu_coordinadordepartamento_ibfk_2
        foreign key (fk_departamento) references tu_departamento (ID),
    constraint tu_coordinadordepartamento_ibfk_3
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_coordinadordepartamento_ibfk_4
        foreign key (fk_coordinador_ins) references tu_coordinadorinstitucional (ID),
    constraint tu_coordinadordepartamento_ibfk_5
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table ti_asesor
(
    ID               int auto_increment
        primary key,
    fk_docente       int      null,
    fk_ciclo         int      null,
    fk_estatus       int      null,
    fk_coordinador   int      null,
    fecha_asignacion datetime null,
    num_tutorados    int      null,
    created_at       int      null,
    updated_at       int      null,
    observacion      text     null,
    fk_user          int      null,
    constraint ti_asesor_ibfk_1
        foreign key (fk_coordinador) references tu_coordinadordepartamento (ID),
    constraint ti_asesor_ibfk_2
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint ti_asesor_ibfk_3
        foreign key (fk_ciclo) references tu_cicloescolar (ID),
    constraint ti_asesor_ibfk_4
        foreign key (fk_docente) references tu_docente (ID),
    constraint ti_asesor_ibfk_5
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table ti_archivo
(
    ID               int auto_increment
        primary key,
    nombre           varchar(255) collate utf8mb4_unicode_ci null,
    tipo             varchar(255) collate utf8mb4_unicode_ci null,
    tamano           int default 0                           null,
    descripcioncorta varchar(255) collate utf8mb4_unicode_ci null,
    descripcionlarga mediumtext collate utf8mb4_unicode_ci   null,
    createdat        int                                     null,
    updatedat        int                                     null,
    titulo           varchar(255) collate utf8mb4_unicode_ci null,
    ruta             varchar(255) collate utf8mb4_unicode_ci null,
    descargas        int default 0                           null,
    fkuser           int                                     null,
    nombretemporal   varchar(255) collate utf8mb4_unicode_ci null,
    constraint ti_archivo_ibfk_1
        foreign key (fkuser) references ti_asesor (ID)
)
    row_format = DYNAMIC;

create index arc_fkuser
    on ti_archivo (fkuser);

create index fk_coordinador
    on ti_asesor (fk_coordinador);

create index fk_docente
    on ti_asesor (fk_docente);

create index fk_estatus
    on ti_asesor (fk_estatus);

create index fk_periodo
    on ti_asesor (fk_ciclo);

create index fk_user
    on ti_asesor (fk_user);

create index fk_coordinador_ins
    on tu_coordinadordepartamento (fk_coordinador_ins);

create index fk_departamento
    on tu_coordinadordepartamento (fk_departamento);

create index fk_docente
    on tu_coordinadordepartamento (fk_docente);

create index fk_estatus
    on tu_coordinadordepartamento (fk_estatus);

create index fk_user
    on tu_coordinadordepartamento (fk_user);

create index fk_departamento
    on tu_docente (fk_departamento);

create index fk_movimiento
    on tu_docente (fk_movimiento);

create index fk_user
    on tu_docente (fk_user);

create table tu_docentecarrera
(
    fk_docente int not null,
    fk_carrera int not null,
    fk_estatus int null,
    created_at int null,
    updated_at int null,
    primary key (fk_docente, fk_carrera),
    constraint tu_docentecarrera_ibfk_1
        foreign key (fk_docente) references tu_docente (ID),
    constraint tu_docentecarrera_ibfk_2
        foreign key (fk_carrera) references tu_carrera (ID),
    constraint tu_docentecarrera_ibfk_3
        foreign key (fk_estatus) references tu_estatu (ID)
)
    row_format = DYNAMIC;

create index fk_carrera
    on tu_docentecarrera (fk_carrera);

create index fk_estatus
    on tu_docentecarrera (fk_estatus);

create index fk_user
    on tu_movimiento (fk_user);

create table tu_periodo
(
    ID           int auto_increment
        primary key,
    nombre       varchar(255) null,
    nombrelargo  varchar(255) null,
    fecha_inicio datetime     null,
    fecha_fin    datetime     null,
    fk_ciclo     int          null,
    fk_user      int          null,
    fk_estatus   int          null,
    created_at   int          null,
    updated_at   int          null,
    constraint tu_periodo_ibfk_1
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_periodo_ibfk_2
        foreign key (fk_user) references user (id),
    constraint tu_periodo_ibfk_3
        foreign key (fk_ciclo) references tu_cicloescolar (ID)
)
    row_format = DYNAMIC;

create table tu_datoscomision
(
    ID                       int auto_increment
        primary key,
    fkperiodo                int  null,
    fecha_comision           date null,
    fecha_entrega_planeacion date null,
    fecha_entrega_reporte    date null,
    created_at               int  null,
    updated_at               int  null,
    fk_user                  int  null,
    constraint tu_datoscomision_ibfk_1
        foreign key (fkperiodo) references tu_periodo (ID),
    constraint tu_datoscomision_ibfk_2
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_user
    on tu_datoscomision (fk_user);

create index fkperiodo
    on tu_datoscomision (fkperiodo);

create table tu_grupo
(
    ID           int auto_increment
        primary key,
    nombre_corto varchar(255) null,
    nombre_largo varchar(255) null,
    fk_ciclo     int          null,
    fk_periodo   int          null,
    fk_estatus   int          null,
    fk_user      int          null,
    semestre     int          null,
    created_at   int          null,
    updated_at   int          null,
    constraint tu_grupo_ibfk_1
        foreign key (fk_periodo) references tu_periodo (ID),
    constraint tu_grupo_ibfk_2
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_grupo_ibfk_3
        foreign key (fk_user) references user (id),
    constraint tu_grupo_ibfk_4
        foreign key (fk_ciclo) references tu_cicloescolar (ID)
)
    row_format = DYNAMIC;

create table tu_estudiante
(
    matricula         varchar(20)  not null
        primary key,
    rfc               varchar(13)  null,
    curp              varchar(18)  null,
    nombre            varchar(100) null,
    ape_paterno       varchar(50)  null,
    ape_materno       varchar(50)  null,
    telefono          varchar(20)  null,
    fk_carrera        int          null,
    fk_grupo          int          null,
    fecha_nacimiento  date         null,
    fecha_ingreso     date         null,
    semestre          varchar(3)   null,
    calle             varchar(255) null,
    colonia           varchar(255) null,
    cp                varchar(10)  null,
    no_casa           varchar(10)  null,
    foto              varchar(255) null,
    num_seguro_social varchar(255) null,
    sexo              varchar(10)  null,
    nombre_tutor1     varchar(100) null,
    telefono_tutor1   varchar(20)  null,
    nombre_tutor2     varchar(100) null,
    telefono_tutor2   varchar(20)  null,
    created_at        int          null,
    updated_at        int          null,
    fk_user           int          null,
    constraint tu_estudiante_ibfk_1
        foreign key (fk_carrera) references tu_carrera (ID),
    constraint tu_estudiante_ibfk_2
        foreign key (fk_grupo) references tu_grupo (ID),
    constraint tu_estudiante_ibfk_3
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table ti_tutorado
(
    ID            int auto_increment
        primary key,
    fk_estudiante varchar(20) null,
    fk_tutor      int         null,
    fk_ciclo      int         null,
    semestre      varchar(2)  null,
    created_at    int         null,
    updated_at    int         null,
    fk_user       int         null,
    constraint ti_tutorado_ibfk_1
        foreign key (fk_tutor) references ti_asesor (ID),
    constraint ti_tutorado_ibfk_2
        foreign key (fk_estudiante) references tu_estudiante (matricula),
    constraint ti_tutorado_ibfk_4
        foreign key (fk_user) references user (id),
    constraint ti_tutorado_ibfk_5
        foreign key (fk_ciclo) references tu_cicloescolar (ID)
)
    row_format = DYNAMIC;

create index fk_ciclo
    on ti_tutorado (fk_ciclo);

create index fk_estudiante
    on ti_tutorado (fk_estudiante);

create index fk_tutor
    on ti_tutorado (fk_tutor);

create index fk_user
    on ti_tutorado (fk_user);

create table tu_bitacora
(
    ID                 int auto_increment
        primary key,
    fk_matricula       varchar(20) null,
    aspectos_atendidos text        null,
    fecha_hora         datetime    null,
    orientacion        text        null,
    fk_periodo         int         null,
    fk_area_canalizada int         null,
    semestre           varchar(3)  null,
    grupo              varchar(20) null,
    observacion        text        null,
    fk_estatus         int         null,
    created_at         int         null,
    update_at          int         null,
    fk_user            int         null,
    constraint tu_bitacora_ibfk_1
        foreign key (fk_matricula) references tu_estudiante (matricula),
    constraint tu_bitacora_ibfk_2
        foreign key (fk_periodo) references tu_periodo (ID),
    constraint tu_bitacora_ibfk_3
        foreign key (fk_area_canalizada) references tu_areaapoyo (ID),
    constraint tu_bitacora_ibfk_4
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_bitacora_ibfk_5
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_area_canalizada
    on tu_bitacora (fk_area_canalizada);

create index fk_estatus
    on tu_bitacora (fk_estatus);

create index fk_matricula
    on tu_bitacora (fk_matricula);

create index fk_periodo
    on tu_bitacora (fk_periodo);

create index fk_user
    on tu_bitacora (fk_user);

create table tu_bitacoraarchivo
(
    fk_bitacora    int not null,
    fk_archivo     int not null,
    created_at     int null,
    created_update int null,
    primary key (fk_bitacora, fk_archivo),
    constraint tu_bitacoraarchivo_ibfk_1
        foreign key (fk_bitacora) references tu_bitacora (ID),
    constraint tu_bitacoraarchivo_ibfk_2
        foreign key (fk_archivo) references tu_archivo (ID)
)
    row_format = DYNAMIC;

create index bitacoraarchivo_ibfk_2
    on tu_bitacoraarchivo (fk_archivo);

create table tu_cuestionario
(
    ID                            int auto_increment
        primary key,
    fk_estudiante                 varchar(20)  null,
    fk_diagnostico                int          null,
    nombre                        varchar(255) null,
    ape_paterno                   varchar(255) null,
    ape_materno                   varchar(255) null,
    fecha_nacimiento              date         null,
    lugar_nacimiento              varchar(255) null,
    correo_personal               varchar(255) null,
    nombre_preparatoria           varchar(255) null,
    estado_civil                  varchar(255) null,
    religion                      varchar(255) null,
    vivo_con                      varchar(255) null,
    especificar_otro              varchar(255) null,
    calle                         varchar(255) null,
    num_exterior                  varchar(255) null,
    num_interior                  varchar(255) null,
    colonia                       varchar(255) null,
    cp                            varchar(255) null,
    municipio                     varchar(255) null,
    estado                        varchar(255) null,
    nombre_padre                  varchar(255) null,
    domicilio                     varchar(255) null,
    grado_estudios                varchar(255) null,
    oficio_padre                  varchar(255) null,
    ingreso_mensual_padre         varchar(255) null,
    telefono_celular_padre        varchar(255) null,
    telefono_casa                 varchar(255) null,
    nombre_madre                  varchar(255) null,
    domicilio_madre               varchar(255) null,
    grado_estudios_padre          varchar(255) null,
    oficio_madre                  varchar(255) null,
    ingreso_mensual_madre         varchar(255) null,
    telefono_celular_madre        varchar(255) null,
    quien_es_tutor                varchar(255) null,
    especificar_tutor_otro        varchar(255) null,
    domicilio_tutor_otro          varchar(255) null,
    grado_estudios_otro           varchar(255) null,
    oficio_tutor_otro             varchar(255) null,
    telefono_celular_otro         varchar(255) null,
    telefono_casa_otro            varchar(255) null,
    depende_economicamente        varchar(255) null,
    de_quien_depende              varchar(255) null,
    nombre_depende_otro           varchar(255) null,
    parentesco_depende_otro       varchar(255) null,
    grado_estudios_depende_otro   varchar(255) null,
    oficio_depende_otro           varchar(255) null,
    telefono_celular_depende_otro varchar(255) null,
    telefono_casa_depende_otro    varchar(255) null,
    trabajas                      varchar(255) null,
    ocupacion                     varchar(255) null,
    sueldo                        varchar(255) null,
    horario_trabajo               varchar(255) null,
    dias_labor                    varchar(255) null,
    hermanos                      varchar(255) null,
    mayores_menores               varchar(255) null,
    nivel_estudios_hermanos       varchar(255) null,
    hermano_con_licenciatura      varchar(255) null,
    tiene_hijos                   varchar(255) null,
    cuantos_hijos                 int          null,
    tienes_beca                   varchar(255) null,
    becas                         varchar(255) null,
    transporte                    varchar(255) null,
    otro_transporte               varchar(255) null,
    recorrido_escuela             varchar(255) null,
    gasto_transporte              varchar(255) null,
    tiempo_traslado               varchar(255) null,
    fk_ciclo                      int          null,
    fk_user                       int          null,
    constraint tu_cuestionario_ibfk_1
        foreign key (fk_estudiante) references tu_estudiante (matricula),
    constraint tu_cuestionario_ibfk_2
        foreign key (fk_diagnostico) references tu_diagnostico (ID),
    constraint tu_cuestionario_ibfk_3
        foreign key (fk_ciclo) references tu_cicloescolar (ID),
    constraint tu_cuestionario_ibfk_4
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create index fk_diagnostico
    on tu_cuestionario (fk_diagnostico);

create index fk_estudiante
    on tu_cuestionario (fk_estudiante);

create index fk_user
    on tu_cuestionario (fk_user);

create index fkciclo
    on tu_cuestionario (fk_ciclo);

create index fk_carrera
    on tu_estudiante (fk_carrera);

create index fk_grupo
    on tu_estudiante (fk_grupo);

create index fk_user
    on tu_estudiante (fk_user);

create index fk_ciclo
    on tu_grupo (fk_ciclo);

create index fk_estatus
    on tu_grupo (fk_estatus);

create index fk_periodo
    on tu_grupo (fk_periodo);

create index fk_user
    on tu_grupo (fk_user);

create index fk_ciclo
    on tu_periodo (fk_ciclo);

create index fk_estatus
    on tu_periodo (fk_estatus);

create index fk_user
    on tu_periodo (fk_user);

create table tu_tutor
(
    ID               int auto_increment
        primary key,
    fk_docente       int      null,
    fk_ciclo         int      null,
    fk_estatus       int      null,
    fk_coordinador   int      null,
    fecha_asignacion datetime null,
    num_tutorados    int      null,
    created_at       int      null,
    updated_at       int      null,
    observacion      text     null,
    fk_user          int      null,
    constraint tu_tutor_ibfk_1
        foreign key (fk_coordinador) references tu_coordinadordepartamento (ID),
    constraint tu_tutor_ibfk_2
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_tutor_ibfk_3
        foreign key (fk_ciclo) references tu_cicloescolar (ID),
    constraint tu_tutor_ibfk_4
        foreign key (fk_docente) references tu_docente (ID),
    constraint tu_tutor_ibfk_5
        foreign key (fk_user) references user (id)
)
    row_format = DYNAMIC;

create table tu_planeacion
(
    ID             int auto_increment
        primary key,
    fk_tutor       int      null,
    fk_ciclo       int      null,
    fecha_creacion datetime null,
    fk_estatus     int      null,
    created_at     int      null,
    update_at      int      null,
    fk_user        int      null,
    constraint tu_planeacion_ibfk_1
        foreign key (fk_tutor) references tu_tutor (ID),
    constraint tu_planeacion_ibfk_3
        foreign key (fk_estatus) references tu_estatu (ID),
    constraint tu_planeacion_ibfk_4
        foreign key (fk_user) references user (id),
    constraint tu_planeacion_ibfk_5
        foreign key (fk_ciclo) references tu_cicloescolar (ID)
)
    row_format = DYNAMIC;

create index fk_ciclo
    on tu_planeacion (fk_ciclo);

create index fk_estatus
    on tu_planeacion (fk_estatus);

create index fk_tutor
    on tu_planeacion (fk_tutor);

create index fk_user
    on tu_planeacion (fk_user);

create table tu_planeaciondetalle
(
    ID            int auto_increment
        primary key,
    fk_planeacion int          null,
    actividad     text         null,
    proposito     varchar(255) null,
    descripcion   text         null,
    fecha_inicio  datetime     null,
    fecha_fin     datetime     null,
    lugar         varchar(255) null,
    observacion   text         null,
    created_at    int          null,
    updated_at    int          null,
    constraint tu_planeaciondetalle_ibfk_1
        foreign key (fk_planeacion) references tu_planeacion (ID)
)
    row_format = DYNAMIC;

create index fk_planeacion
    on tu_planeaciondetalle (fk_planeacion);

create index fk_coordinador
    on tu_tutor (fk_coordinador);

create index fk_docente
    on tu_tutor (fk_docente);

create index fk_estatus
    on tu_tutor (fk_estatus);

create index fk_periodo
    on tu_tutor (fk_ciclo);

create index fk_user
    on tu_tutor (fk_user);

create table tu_tutorado
(
    ID            int auto_increment
        primary key,
    fk_estudiante varchar(20) null,
    fk_tutor      int         null,
    fk_ciclo      int         null,
    semestre      varchar(2)  null,
    created_at    int         null,
    updated_at    int         null,
    fk_user       int         null,
    constraint tu_tutorado_ibfk_1
        foreign key (fk_tutor) references tu_tutor (ID),
    constraint tu_tutorado_ibfk_2
        foreign key (fk_estudiante) references tu_estudiante (matricula),
    constraint tu_tutorado_ibfk_4
        foreign key (fk_user) references user (id),
    constraint tu_tutorado_ibfk_5
        foreign key (fk_ciclo) references tu_cicloescolar (ID)
)
    row_format = DYNAMIC;

create index fk_ciclo
    on tu_tutorado (fk_ciclo);

create index fk_estudiante
    on tu_tutorado (fk_estudiante);

create index fk_tutor
    on tu_tutorado (fk_tutor);

create index fk_user
    on tu_tutorado (fk_user);

create table user_visit_log
(
    id         int auto_increment
        primary key,
    token      varchar(255) not null,
    ip         varchar(15)  not null,
    language   char(2)      not null,
    user_agent varchar(255) not null,
    user_id    int          null,
    visit_time int          not null,
    browser    varchar(30)  null,
    os         varchar(20)  null,
    constraint user_visit_log_ibfk_1
        foreign key (user_id) references user (id)
            on update cascade on delete set null
)
    charset = utf8
    row_format = DYNAMIC;

create index user_id
    on user_visit_log (user_id);


