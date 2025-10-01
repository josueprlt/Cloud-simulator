--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    accepted_terms boolean DEFAULT false,
    project_id uuid
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: instance_types; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.instance_types (
    id integer NOT NULL,
    name character varying(255),
    service integer
);


ALTER TABLE public.instance_types OWNER TO directus;

--
-- Name: instance_types_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.instance_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instance_types_id_seq OWNER TO directus;

--
-- Name: instance_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.instance_types_id_seq OWNED BY public.instance_types.id;


--
-- Name: pricing; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.pricing (
    id integer NOT NULL,
    service integer,
    region integer,
    instance_type integer,
    price_per_unit numeric(10,5),
    unit character varying(255),
    currency character varying(255),
    updated_at timestamp without time zone
);


ALTER TABLE public.pricing OWNER TO directus;

--
-- Name: pricing_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.pricing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pricing_id_seq OWNER TO directus;

--
-- Name: pricing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.pricing_id_seq OWNED BY public.pricing.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.regions (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255)
);


ALTER TABLE public.regions OWNER TO directus;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO directus;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255)
);


ALTER TABLE public.services OWNER TO directus;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO directus;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: simulation_entries; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.simulation_entries (
    id integer NOT NULL,
    simulation integer,
    service integer,
    instance_type integer,
    quantity numeric(10,5),
    unit character varying(255),
    price_snapshot numeric(10,5)
);


ALTER TABLE public.simulation_entries OWNER TO directus;

--
-- Name: simulation_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.simulation_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simulation_entries_id_seq OWNER TO directus;

--
-- Name: simulation_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.simulation_entries_id_seq OWNED BY public.simulation_entries.id;


--
-- Name: simulations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.simulations (
    id integer NOT NULL,
    name character varying(255),
    region integer
);


ALTER TABLE public.simulations OWNER TO directus;

--
-- Name: simulations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.simulations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simulations_id_seq OWNER TO directus;

--
-- Name: simulations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.simulations_id_seq OWNED BY public.simulations.id;


--
-- Name: simulations_simulation_entries; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.simulations_simulation_entries (
    id integer NOT NULL,
    simulations_id integer,
    simulation_entries_id integer
);


ALTER TABLE public.simulations_simulation_entries OWNER TO directus;

--
-- Name: simulations_simulation_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.simulations_simulation_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simulations_simulation_entries_id_seq OWNER TO directus;

--
-- Name: simulations_simulation_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.simulations_simulation_entries_id_seq OWNED BY public.simulations_simulation_entries.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: instance_types id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.instance_types ALTER COLUMN id SET DEFAULT nextval('public.instance_types_id_seq'::regclass);


--
-- Name: pricing id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing ALTER COLUMN id SET DEFAULT nextval('public.pricing_id_seq'::regclass);


--
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: simulation_entries id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulation_entries ALTER COLUMN id SET DEFAULT nextval('public.simulation_entries_id_seq'::regclass);


--
-- Name: simulations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations ALTER COLUMN id SET DEFAULT nextval('public.simulations_id_seq'::regclass);


--
-- Name: simulations_simulation_entries id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations_simulation_entries ALTER COLUMN id SET DEFAULT nextval('public.simulations_simulation_entries_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
0b16b651-1975-4891-b32d-c48f495ebe94	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
bde32fbf-cac0-40fd-9e4b-9d0482a1f8af	7d7ad24c-6292-497b-9809-ec4d797b1df5	\N	711cd334-1d67-4b04-9ff9-f25a96bc8c93	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:20:30.137+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	27fc7a4b-bd46-414c-8883-99f3ae3089df	http://localhost:8055
2	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:20:32.413+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
61	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:48:04.015+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	1	http://localhost:8055
63	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:48:50.252+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	3	http://localhost:8055
64	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:49:13.7+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	2	http://localhost:8055
66	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:49:50.696+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	5	http://localhost:8055
67	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:50:05.893+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	6	http://localhost:8055
69	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:53:24.114+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	2	http://localhost:8055
70	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:53:33.85+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	3	http://localhost:8055
72	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:53:54.044+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	5	http://localhost:8055
74	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:54:12.35+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	7	http://localhost:8055
3	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:44:04.76+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
4	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:44:04.769+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	test	http://localhost:8055
5	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:44:12.851+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
62	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:48:17.311+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	2	http://localhost:8055
65	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:49:43.078+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	4	http://localhost:8055
68	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:52:59.751+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	1	http://localhost:8055
71	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:53:43.753+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	4	http://localhost:8055
73	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:54:03.635+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	6	http://localhost:8055
6	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:19:12.27+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	test	http://localhost:8055
7	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:19:12.28+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
8	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:19:12.282+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
9	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:19:25.626+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
10	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:19:25.633+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	simulations	http://localhost:8055
11	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:20:01.708+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
12	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:20:01.712+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	resources	http://localhost:8055
13	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:21:41.918+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
14	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:21:41.926+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	aws_prices	http://localhost:8055
15	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:35:43.952+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
16	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:35:43.956+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	services	http://localhost:8055
17	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:35:51.284+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
18	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:01.682+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
19	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:12.112+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
20	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:12.12+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	regions	http://localhost:8055
21	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:20.661+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
22	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:26.021+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
23	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:36.331+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	aws_prices	http://localhost:8055
24	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:36.335+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
27	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:44.01+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	simulations	http://localhost:8055
28	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:44.013+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
35	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:38:14.86+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	16	http://localhost:8055
36	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:38:32.069+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	17	http://localhost:8055
37	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:38:52.992+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	18	http://localhost:8055
38	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:39:14.212+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	19	http://localhost:8055
39	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:39:23.551+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	20	http://localhost:8055
40	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:39:30.564+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	21	http://localhost:8055
41	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:40:00.887+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
42	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:41:37.918+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
43	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:41:51.62+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	23	http://localhost:8055
44	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:42:08.459+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	24	http://localhost:8055
45	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:42:08.467+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	simulations	http://localhost:8055
75	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:54:31.406+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	1	http://localhost:8055
25	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:39.613+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	resources	http://localhost:8055
26	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:39.619+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
29	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:54.541+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
30	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:36:54.547+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	instance_types	http://localhost:8055
31	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:37:01.162+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	13	http://localhost:8055
32	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:37:38.273+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	14	http://localhost:8055
33	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:37:57.373+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	15	http://localhost:8055
34	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:37:57.382+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	pricing	http://localhost:8055
46	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:42:21.467+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	25	http://localhost:8055
47	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:42:34.84+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	26	http://localhost:8055
48	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:42:54.666+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
49	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:42:54.675+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	simulation_entries	http://localhost:8055
50	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:43:13.452+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
51	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:43:25.001+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
52	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:43:39.046+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
53	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:43:48.789+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
54	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:43:55.969+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
55	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:44:14.161+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	33	http://localhost:8055
56	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:44:49.445+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	34	http://localhost:8055
57	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:44:49.53+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	35	http://localhost:8055
58	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:44:49.534+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	simulations_simulation_entries	http://localhost:8055
59	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:44:49.578+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	36	http://localhost:8055
60	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:44:49.66+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	37	http://localhost:8055
76	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:54:47.154+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	3	http://localhost:8055
77	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:54:56.249+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	6	http://localhost:8055
78	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:55:05.303+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	2	http://localhost:8055
79	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:55:13.374+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	4	http://localhost:8055
80	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:55:22.167+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	5	http://localhost:8055
81	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:10:28.088+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	test	http://localhost:8055
82	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:10:28.097+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
83	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:10:28.099+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
services	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
regions	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
instance_types	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
pricing	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
simulations	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
simulation_entries	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
simulations_simulation_entries	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
6	services	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
7	services	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
8	services	code	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
9	regions	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
10	regions	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
11	regions	code	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
12	instance_types	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
13	instance_types	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
14	instance_types	service	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
15	pricing	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
16	pricing	service	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
17	pricing	region	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
18	pricing	instance_type	m2o	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
19	pricing	price_per_unit	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
20	pricing	unit	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
21	pricing	currency	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
23	pricing	updated_at	\N	datetime	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
24	simulations	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
25	simulations	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
26	simulations	region	m2o	select-dropdown-m2o	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
27	simulation_entries	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
28	simulation_entries	simulation	m2o	select-dropdown-m2o	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
29	simulation_entries	service	m2o	select-dropdown-m2o	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
30	simulation_entries	instance_type	m2o	select-dropdown-m2o	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
31	simulation_entries	quantity	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
32	simulation_entries	unit	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
33	simulation_entries	price_snapshot	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
34	simulations	entries	m2m	list-m2m	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
35	simulations_simulation_entries	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
36	simulations_simulation_entries	simulations_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
37	simulations_simulation_entries	simulation_entries_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-10-01 13:12:58.800529+00
20201029A	Remove System Relations	2025-10-01 13:12:58.808027+00
20201029B	Remove System Collections	2025-10-01 13:12:58.820342+00
20201029C	Remove System Fields	2025-10-01 13:12:58.833237+00
20201105A	Add Cascade System Relations	2025-10-01 13:12:58.910851+00
20201105B	Change Webhook URL Type	2025-10-01 13:12:58.92632+00
20210225A	Add Relations Sort Field	2025-10-01 13:12:58.935976+00
20210304A	Remove Locked Fields	2025-10-01 13:12:58.940798+00
20210312A	Webhooks Collections Text	2025-10-01 13:12:58.952401+00
20210331A	Add Refresh Interval	2025-10-01 13:12:58.957025+00
20210415A	Make Filesize Nullable	2025-10-01 13:12:58.971378+00
20210416A	Add Collections Accountability	2025-10-01 13:12:58.97984+00
20210422A	Remove Files Interface	2025-10-01 13:12:58.985062+00
20210506A	Rename Interfaces	2025-10-01 13:12:59.01079+00
20210510A	Restructure Relations	2025-10-01 13:12:59.033502+00
20210518A	Add Foreign Key Constraints	2025-10-01 13:12:59.041482+00
20210519A	Add System Fk Triggers	2025-10-01 13:12:59.079661+00
20210521A	Add Collections Icon Color	2025-10-01 13:12:59.085261+00
20210525A	Add Insights	2025-10-01 13:12:59.11618+00
20210608A	Add Deep Clone Config	2025-10-01 13:12:59.122334+00
20210626A	Change Filesize Bigint	2025-10-01 13:12:59.143736+00
20210716A	Add Conditions to Fields	2025-10-01 13:12:59.149083+00
20210721A	Add Default Folder	2025-10-01 13:12:59.162157+00
20210802A	Replace Groups	2025-10-01 13:12:59.171083+00
20210803A	Add Required to Fields	2025-10-01 13:12:59.175518+00
20210805A	Update Groups	2025-10-01 13:12:59.181562+00
20210805B	Change Image Metadata Structure	2025-10-01 13:12:59.187998+00
20210811A	Add Geometry Config	2025-10-01 13:12:59.192933+00
20210831A	Remove Limit Column	2025-10-01 13:12:59.19773+00
20210903A	Add Auth Provider	2025-10-01 13:12:59.222995+00
20210907A	Webhooks Collections Not Null	2025-10-01 13:12:59.234069+00
20210910A	Move Module Setup	2025-10-01 13:12:59.239741+00
20210920A	Webhooks URL Not Null	2025-10-01 13:12:59.249318+00
20210924A	Add Collection Organization	2025-10-01 13:12:59.257556+00
20210927A	Replace Fields Group	2025-10-01 13:12:59.269+00
20210927B	Replace M2M Interface	2025-10-01 13:12:59.273818+00
20210929A	Rename Login Action	2025-10-01 13:12:59.27747+00
20211007A	Update Presets	2025-10-01 13:12:59.285289+00
20211009A	Add Auth Data	2025-10-01 13:12:59.289462+00
20211016A	Add Webhook Headers	2025-10-01 13:12:59.293591+00
20211103A	Set Unique to User Token	2025-10-01 13:12:59.300601+00
20211103B	Update Special Geometry	2025-10-01 13:12:59.303767+00
20211104A	Remove Collections Listing	2025-10-01 13:12:59.308133+00
20211118A	Add Notifications	2025-10-01 13:12:59.327239+00
20211211A	Add Shares	2025-10-01 13:12:59.352727+00
20211230A	Add Project Descriptor	2025-10-01 13:12:59.357234+00
20220303A	Remove Default Project Color	2025-10-01 13:12:59.367906+00
20220308A	Add Bookmark Icon and Color	2025-10-01 13:12:59.372735+00
20220314A	Add Translation Strings	2025-10-01 13:12:59.377674+00
20220322A	Rename Field Typecast Flags	2025-10-01 13:12:59.382972+00
20220323A	Add Field Validation	2025-10-01 13:12:59.387505+00
20220325A	Fix Typecast Flags	2025-10-01 13:12:59.393138+00
20220325B	Add Default Language	2025-10-01 13:12:59.406012+00
20220402A	Remove Default Value Panel Icon	2025-10-01 13:12:59.417031+00
20220429A	Add Flows	2025-10-01 13:12:59.471147+00
20220429B	Add Color to Insights Icon	2025-10-01 13:12:59.478438+00
20220429C	Drop Non Null From IP of Activity	2025-10-01 13:12:59.48482+00
20220429D	Drop Non Null From Sender of Notifications	2025-10-01 13:12:59.491277+00
20220614A	Rename Hook Trigger to Event	2025-10-01 13:12:59.496268+00
20220801A	Update Notifications Timestamp Column	2025-10-01 13:12:59.506364+00
20220802A	Add Custom Aspect Ratios	2025-10-01 13:12:59.510903+00
20220826A	Add Origin to Accountability	2025-10-01 13:12:59.516976+00
20230401A	Update Material Icons	2025-10-01 13:12:59.527701+00
20230525A	Add Preview Settings	2025-10-01 13:12:59.531514+00
20230526A	Migrate Translation Strings	2025-10-01 13:12:59.544481+00
20230721A	Require Shares Fields	2025-10-01 13:12:59.551364+00
20230823A	Add Content Versioning	2025-10-01 13:12:59.572731+00
20230927A	Themes	2025-10-01 13:12:59.591855+00
20231009A	Update CSV Fields to Text	2025-10-01 13:12:59.597377+00
20231009B	Update Panel Options	2025-10-01 13:12:59.600954+00
20231010A	Add Extensions	2025-10-01 13:12:59.608118+00
20231215A	Add Focalpoints	2025-10-01 13:12:59.612753+00
20240122A	Add Report URL Fields	2025-10-01 13:12:59.617221+00
20240204A	Marketplace	2025-10-01 13:12:59.650119+00
20240305A	Change Useragent Type	2025-10-01 13:12:59.66431+00
20240311A	Deprecate Webhooks	2025-10-01 13:12:59.675929+00
20240422A	Public Registration	2025-10-01 13:12:59.68295+00
20240515A	Add Session Window	2025-10-01 13:12:59.687387+00
20240701A	Add Tus Data	2025-10-01 13:12:59.692219+00
20240716A	Update Files Date Fields	2025-10-01 13:12:59.700733+00
20240806A	Permissions Policies	2025-10-01 13:12:59.751989+00
20240817A	Update Icon Fields Length	2025-10-01 13:12:59.788995+00
20240909A	Separate Comments	2025-10-01 13:12:59.804401+00
20240909B	Consolidate Content Versioning	2025-10-01 13:12:59.809034+00
20240924A	Migrate Legacy Comments	2025-10-01 13:12:59.815782+00
20240924B	Populate Versioning Deltas	2025-10-01 13:12:59.82092+00
20250224A	Visual Editor	2025-10-01 13:12:59.826028+00
20250609A	License Banner	2025-10-01 13:12:59.832204+00
20250613A	Add Project ID	2025-10-01 13:12:59.849609+00
20250718A	Add Direction	2025-10-01 13:12:59.854341+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
711cd334-1d67-4b04-9ff9-f25a96bc8c93	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	regions	\N	\N	{"tabular":{"fields":["code","name"]}}	{"tabular":{"widths":{"code":160,"name":441.5260009765625}}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	instance_types	service	services	\N	\N	\N	\N	\N	nullify
2	pricing	service	services	\N	\N	\N	\N	\N	nullify
3	pricing	region	regions	\N	\N	\N	\N	\N	nullify
4	pricing	instance_type	instance_types	\N	\N	\N	\N	\N	nullify
5	simulations	region	regions	\N	\N	\N	\N	\N	nullify
6	simulation_entries	simulation	simulations	\N	\N	\N	\N	\N	nullify
7	simulation_entries	service	services	\N	\N	\N	\N	\N	nullify
8	simulation_entries	instance_type	instance_types	\N	\N	\N	\N	\N	nullify
9	simulations_simulation_entries	simulation_entries_id	simulation_entries	\N	\N	\N	simulations_id	\N	nullify
10	simulations_simulation_entries	simulations_id	simulations	entries	\N	\N	simulation_entries_id	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"01999fe7-9ac7-751b-8d05-12a3d32a1c9d"}	{"accepted_terms":true}	\N	\N
50	61	services	1	{"name":"Amazon EC2"}	{"name":"Amazon EC2"}	\N	\N
52	63	services	3	{"name":"Amazon RDS"}	{"name":"Amazon RDS"}	\N	\N
53	64	services	2	{"id":2,"name":"AWS Lambda","code":null}	{"name":"AWS Lambda"}	\N	\N
55	66	services	5	{"name":"Amazon EKS"}	{"name":"Amazon EKS"}	\N	\N
56	67	services	6	{"name":"Amazon S3"}	{"name":"Amazon S3"}	\N	\N
65	76	services	3	{"id":3,"name":"RDS","code":" AmazonRDS"}	{"name":"RDS","code":" AmazonRDS"}	\N	\N
66	77	services	6	{"id":6,"name":"S3","code":"AmazonS3"}	{"name":"S3","code":"AmazonS3"}	\N	\N
67	78	services	2	{"id":2,"name":"Lambda","code":" AWSLambda"}	{"name":"Lambda","code":" AWSLambda"}	\N	\N
68	79	services	4	{"id":4,"name":"ECS","code":"AmazonECS"}	{"name":"ECS","code":"AmazonECS"}	\N	\N
69	80	services	5	{"id":5,"name":"EKS","code":"AmazonEKS"}	{"name":"EKS","code":"AmazonEKS"}	\N	\N
51	62	services	2	{"name":"Lambda"}	{"name":"Lambda"}	\N	\N
54	65	services	4	{"name":"Amazon ECS"}	{"name":"Amazon ECS"}	\N	\N
2	3	directus_fields	1	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"test"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"test"}	\N	\N
3	4	directus_collections	test	{"singleton":false,"collection":"test"}	{"singleton":false,"collection":"test"}	\N	\N
4	5	directus_fields	2	{"sort":2,"interface":"input","special":null,"collection":"test","field":"testfield"}	{"sort":2,"interface":"input","special":null,"collection":"test","field":"testfield"}	\N	\N
57	68	regions	1	{"name":"US East (N. Virginia)","code":"\\tus-east-1"}	{"name":"US East (N. Virginia)","code":"\\tus-east-1"}	\N	\N
60	71	regions	4	{"name":"EU (Frankfurt)\\t","code":" eu-central-1"}	{"name":"EU (Frankfurt)\\t","code":" eu-central-1"}	\N	\N
62	73	regions	6	{"name":"Asia Pacific (Tokyo)\\t","code":" ap-northeast-1"}	{"name":"Asia Pacific (Tokyo)\\t","code":" ap-northeast-1"}	\N	\N
5	9	directus_fields	3	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulations"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulations"}	\N	\N
6	10	directus_collections	simulations	{"singleton":false,"collection":"simulations"}	{"singleton":false,"collection":"simulations"}	\N	\N
7	11	directus_fields	4	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"resources"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"resources"}	\N	\N
8	12	directus_collections	resources	{"singleton":false,"collection":"resources"}	{"singleton":false,"collection":"resources"}	\N	\N
9	13	directus_fields	5	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"aws_prices"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"aws_prices"}	\N	\N
10	14	directus_collections	aws_prices	{"singleton":false,"collection":"aws_prices"}	{"singleton":false,"collection":"aws_prices"}	\N	\N
11	15	directus_fields	6	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"services"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"services"}	\N	\N
12	16	directus_collections	services	{"singleton":false,"collection":"services"}	{"singleton":false,"collection":"services"}	\N	\N
13	17	directus_fields	7	{"sort":2,"interface":"input","special":null,"collection":"services","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"services","field":"name"}	\N	\N
14	18	directus_fields	8	{"sort":3,"interface":"input","special":null,"collection":"services","field":"code"}	{"sort":3,"interface":"input","special":null,"collection":"services","field":"code"}	\N	\N
15	19	directus_fields	9	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"regions"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"regions"}	\N	\N
16	20	directus_collections	regions	{"singleton":false,"collection":"regions"}	{"singleton":false,"collection":"regions"}	\N	\N
17	21	directus_fields	10	{"sort":2,"interface":"input","special":null,"collection":"regions","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"regions","field":"name"}	\N	\N
18	22	directus_fields	11	{"sort":3,"interface":"input","special":null,"collection":"regions","field":"code"}	{"sort":3,"interface":"input","special":null,"collection":"regions","field":"code"}	\N	\N
25	35	directus_fields	16	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"pricing","field":"service"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"pricing","field":"service"}	\N	\N
26	36	directus_fields	17	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"pricing","field":"region"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"pricing","field":"region"}	\N	\N
27	37	directus_fields	18	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"pricing","field":"instance_type"}	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"pricing","field":"instance_type"}	\N	\N
28	38	directus_fields	19	{"sort":5,"interface":"input","special":null,"collection":"pricing","field":"price_per_unit"}	{"sort":5,"interface":"input","special":null,"collection":"pricing","field":"price_per_unit"}	\N	\N
29	39	directus_fields	20	{"sort":6,"interface":"input","special":null,"collection":"pricing","field":"unit"}	{"sort":6,"interface":"input","special":null,"collection":"pricing","field":"unit"}	\N	\N
30	40	directus_fields	21	{"sort":7,"interface":"input","special":null,"collection":"pricing","field":"currency"}	{"sort":7,"interface":"input","special":null,"collection":"pricing","field":"currency"}	\N	\N
31	41	directus_fields	22	{"sort":8,"interface":"input","special":null,"collection":"pricing","field":"updated_field"}	{"sort":8,"interface":"input","special":null,"collection":"pricing","field":"updated_field"}	\N	\N
32	43	directus_fields	23	{"sort":8,"interface":"datetime","special":null,"collection":"pricing","field":"updated_at"}	{"sort":8,"interface":"datetime","special":null,"collection":"pricing","field":"updated_at"}	\N	\N
33	44	directus_fields	24	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulations"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulations"}	\N	\N
34	45	directus_collections	simulations	{"singleton":false,"collection":"simulations"}	{"singleton":false,"collection":"simulations"}	\N	\N
45	56	directus_fields	34	{"sort":4,"interface":"list-m2m","special":["m2m"],"collection":"simulations","field":"entries"}	{"sort":4,"interface":"list-m2m","special":["m2m"],"collection":"simulations","field":"entries"}	\N	\N
46	57	directus_fields	35	{"sort":1,"hidden":true,"field":"id","collection":"simulations_simulation_entries"}	{"sort":1,"hidden":true,"field":"id","collection":"simulations_simulation_entries"}	\N	\N
47	58	directus_collections	simulations_simulation_entries	{"hidden":true,"icon":"import_export","collection":"simulations_simulation_entries"}	{"hidden":true,"icon":"import_export","collection":"simulations_simulation_entries"}	\N	\N
48	59	directus_fields	36	{"sort":2,"hidden":true,"collection":"simulations_simulation_entries","field":"simulations_id"}	{"sort":2,"hidden":true,"collection":"simulations_simulation_entries","field":"simulations_id"}	\N	\N
49	60	directus_fields	37	{"sort":3,"hidden":true,"collection":"simulations_simulation_entries","field":"simulation_entries_id"}	{"sort":3,"hidden":true,"collection":"simulations_simulation_entries","field":"simulation_entries_id"}	\N	\N
58	69	regions	2	{"name":"US West (Oregon)","code":" us-west-2"}	{"name":"US West (Oregon)","code":" us-west-2"}	\N	\N
59	70	regions	3	{"name":"EU (Ireland)\\t","code":" eu-west-1"}	{"name":"EU (Ireland)\\t","code":" eu-west-1"}	\N	\N
61	72	regions	5	{"name":"EU (Paris)\\t","code":" eu-west-3"}	{"name":"EU (Paris)\\t","code":" eu-west-3"}	\N	\N
63	74	regions	7	{"name":"Asia Pacific (Singapore)\\t","code":" ap-southeast-1"}	{"name":"Asia Pacific (Singapore)\\t","code":" ap-southeast-1"}	\N	\N
19	29	directus_fields	12	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"instance_types"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"instance_types"}	\N	\N
20	30	directus_collections	instance_types	{"singleton":false,"collection":"instance_types"}	{"singleton":false,"collection":"instance_types"}	\N	\N
21	31	directus_fields	13	{"sort":2,"interface":"input","special":null,"collection":"instance_types","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"instance_types","field":"name"}	\N	\N
22	32	directus_fields	14	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"instance_types","field":"service"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{name}}"},"collection":"instance_types","field":"service"}	\N	\N
23	33	directus_fields	15	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"pricing"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"pricing"}	\N	\N
24	34	directus_collections	pricing	{"singleton":false,"collection":"pricing"}	{"singleton":false,"collection":"pricing"}	\N	\N
35	46	directus_fields	25	{"sort":2,"interface":"input","special":null,"collection":"simulations","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"simulations","field":"name"}	\N	\N
36	47	directus_fields	26	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"simulations","field":"region"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"simulations","field":"region"}	\N	\N
37	48	directus_fields	27	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulation_entries"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulation_entries"}	\N	\N
38	49	directus_collections	simulation_entries	{"singleton":false,"collection":"simulation_entries"}	{"singleton":false,"collection":"simulation_entries"}	\N	\N
39	50	directus_fields	28	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"simulation_entries","field":"simulation"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"simulation_entries","field":"simulation"}	\N	\N
40	51	directus_fields	29	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"simulation_entries","field":"service"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"simulation_entries","field":"service"}	\N	\N
41	52	directus_fields	30	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"required":false,"collection":"simulation_entries","field":"instance_type"}	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"required":false,"collection":"simulation_entries","field":"instance_type"}	\N	\N
42	53	directus_fields	31	{"sort":5,"interface":"input","special":null,"collection":"simulation_entries","field":"quantity"}	{"sort":5,"interface":"input","special":null,"collection":"simulation_entries","field":"quantity"}	\N	\N
43	54	directus_fields	32	{"sort":6,"interface":"input","special":null,"collection":"simulation_entries","field":"unit"}	{"sort":6,"interface":"input","special":null,"collection":"simulation_entries","field":"unit"}	\N	\N
44	55	directus_fields	33	{"sort":7,"interface":"input","special":null,"collection":"simulation_entries","field":"price_snapshot"}	{"sort":7,"interface":"input","special":null,"collection":"simulation_entries","field":"price_snapshot"}	\N	\N
64	75	services	1	{"id":1,"name":"EC2","code":" AmazonEC2"}	{"name":"EC2","code":" AmazonEC2"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
7d7ad24c-6292-497b-9809-ec4d797b1df5	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
p_iswvBH48-3nJsTVvj6YyFSaVD7e9P2vPJTWnZUVewfvFJFRFIGuntfIfpw0l9e	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:11:54.101+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	3ao1ekkjKw1LL4uNIWiJ5VQeTrP2Oh8udIMHNpWpfzjRi7B7HiDZD4h493SXH8Ot
3ao1ekkjKw1LL4uNIWiJ5VQeTrP2Oh8udIMHNpWpfzjRi7B7HiDZD4h493SXH8Ot	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 15:11:44.1+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	01999fe7-9ac7-751b-8d05-12a3d32a1c9d
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
27fc7a4b-bd46-414c-8883-99f3ae3089df	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$hPFw2a086BrG9B03t6pPxg$HGjy3p+0DAtjm/b7TmkYUPAwr8sk8Fb/+XexTjOQwz0	\N	\N	\N	\N	\N	\N	\N	active	7d7ad24c-6292-497b-9809-ec4d797b1df5	\N	2025-10-01 15:11:44.115+00	/settings/data-model	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: instance_types; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.instance_types (id, name, service) FROM stdin;
\.


--
-- Data for Name: pricing; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.pricing (id, service, region, instance_type, price_per_unit, unit, currency, updated_at) FROM stdin;
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.regions (id, name, code) FROM stdin;
1	US East (N. Virginia)	\tus-east-1
2	US West (Oregon)	 us-west-2
3	EU (Ireland)\t	 eu-west-1
4	EU (Frankfurt)\t	 eu-central-1
5	EU (Paris)\t	 eu-west-3
6	Asia Pacific (Tokyo)\t	 ap-northeast-1
7	Asia Pacific (Singapore)\t	 ap-southeast-1
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services (id, name, code) FROM stdin;
1	EC2	 AmazonEC2
3	RDS	 AmazonRDS
6	S3	AmazonS3
2	Lambda	 AWSLambda
4	ECS	AmazonECS
5	EKS	AmazonEKS
\.


--
-- Data for Name: simulation_entries; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulation_entries (id, simulation, service, instance_type, quantity, unit, price_snapshot) FROM stdin;
\.


--
-- Data for Name: simulations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulations (id, name, region) FROM stdin;
\.


--
-- Data for Name: simulations_simulation_entries; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulations_simulation_entries (id, simulations_id, simulation_entries_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 83, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 37, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 69, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: instance_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.instance_types_id_seq', 1, false);


--
-- Name: pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.pricing_id_seq', 1, false);


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.regions_id_seq', 7, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.services_id_seq', 6, true);


--
-- Name: simulation_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulation_entries_id_seq', 1, false);


--
-- Name: simulations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulations_id_seq', 1, false);


--
-- Name: simulations_simulation_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulations_simulation_entries_id_seq', 1, false);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: instance_types instance_types_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.instance_types
    ADD CONSTRAINT instance_types_pkey PRIMARY KEY (id);


--
-- Name: pricing pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pkey PRIMARY KEY (id);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: simulation_entries simulation_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulation_entries
    ADD CONSTRAINT simulation_entries_pkey PRIMARY KEY (id);


--
-- Name: simulations simulations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations
    ADD CONSTRAINT simulations_pkey PRIMARY KEY (id);


--
-- Name: simulations_simulation_entries simulations_simulation_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations_simulation_entries
    ADD CONSTRAINT simulations_simulation_entries_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: instance_types instance_types_service_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.instance_types
    ADD CONSTRAINT instance_types_service_foreign FOREIGN KEY (service) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: pricing pricing_instance_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_instance_type_foreign FOREIGN KEY (instance_type) REFERENCES public.instance_types(id) ON DELETE SET NULL;


--
-- Name: pricing pricing_region_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_region_foreign FOREIGN KEY (region) REFERENCES public.regions(id) ON DELETE SET NULL;


--
-- Name: pricing pricing_service_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_service_foreign FOREIGN KEY (service) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: simulation_entries simulation_entries_instance_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulation_entries
    ADD CONSTRAINT simulation_entries_instance_type_foreign FOREIGN KEY (instance_type) REFERENCES public.instance_types(id) ON DELETE SET NULL;


--
-- Name: simulation_entries simulation_entries_service_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulation_entries
    ADD CONSTRAINT simulation_entries_service_foreign FOREIGN KEY (service) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: simulation_entries simulation_entries_simulation_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulation_entries
    ADD CONSTRAINT simulation_entries_simulation_foreign FOREIGN KEY (simulation) REFERENCES public.simulations(id) ON DELETE SET NULL;


--
-- Name: simulations simulations_region_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations
    ADD CONSTRAINT simulations_region_foreign FOREIGN KEY (region) REFERENCES public.regions(id) ON DELETE SET NULL;


--
-- Name: simulations_simulation_entries simulations_simulation_entries_simulation_entries_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations_simulation_entries
    ADD CONSTRAINT simulations_simulation_entries_simulation_entries_id_foreign FOREIGN KEY (simulation_entries_id) REFERENCES public.simulation_entries(id) ON DELETE SET NULL;


--
-- Name: simulations_simulation_entries simulations_simulation_entries_simulations_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations_simulation_entries
    ADD CONSTRAINT simulations_simulation_entries_simulations_id_foreign FOREIGN KEY (simulations_id) REFERENCES public.simulations(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

