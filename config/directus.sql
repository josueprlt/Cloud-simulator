--
-- PostgreSQL database dump
--

\restrict U7AnIdxrs5H8UavtiBTIFwjenTUrwuo9iYv5dCsSJMC6f7IDhnTd6D9LcNmjnsu

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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
-- Name: comparisons; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.comparisons (
    id integer NOT NULL,
    name character varying(255),
    simulation_baseline integer,
    simulation_comparison integer,
    cost_difference numeric(10,5),
    percentage_change numeric(10,5),
    created_at timestamp without time zone
);


ALTER TABLE public.comparisons OWNER TO directus;

--
-- Name: comparisons_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.comparisons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comparisons_id_seq OWNER TO directus;

--
-- Name: comparisons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.comparisons_id_seq OWNED BY public.comparisons.id;


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
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text
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
    service integer,
    vcpu integer,
    memory character varying(255),
    category character varying(255)
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
-- Name: prices; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.prices (
    id integer NOT NULL,
    sku character varying(255),
    service integer,
    region integer,
    instance_type integer,
    os character varying(255),
    price_per_unit real,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.prices OWNER TO directus;

--
-- Name: prices_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.prices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prices_id_seq OWNER TO directus;

--
-- Name: prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.prices_id_seq OWNED BY public.prices.id;


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.recommendations (
    id integer NOT NULL,
    simulation_id integer,
    resource_id integer,
    type character varying(255),
    prioprity character varying(255),
    title character varying(255),
    description text,
    current_cost numeric(10,5),
    optimized_cost numeric(10,5),
    potential_savings numeric(10,5),
    implementation_effort character varying(255),
    applied boolean DEFAULT false,
    created_at timestamp without time zone
);


ALTER TABLE public.recommendations OWNER TO directus;

--
-- Name: recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.recommendations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recommendations_id_seq OWNER TO directus;

--
-- Name: recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.recommendations_id_seq OWNED BY public.recommendations.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.regions (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    country character varying(255)
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
-- Name: resources; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    service integer,
    region integer,
    instance_type integer,
    configuration json,
    unit_price numeric(10,5),
    monthly_cost numeric(10,5),
    created_at timestamp without time zone,
    resource_name character varying(255),
    simulations_id integer
);


ALTER TABLE public.resources OWNER TO directus;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resources_id_seq OWNER TO directus;

--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


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
-- Name: simulations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.simulations (
    id integer NOT NULL,
    name character varying(255),
    description text,
    status character varying(255),
    scenario_type character varying(255),
    monthly_coast numeric(10,5),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
-- Name: comparisons id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comparisons ALTER COLUMN id SET DEFAULT nextval('public.comparisons_id_seq'::regclass);


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
-- Name: prices id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.prices ALTER COLUMN id SET DEFAULT nextval('public.prices_id_seq'::regclass);


--
-- Name: recommendations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.recommendations ALTER COLUMN id SET DEFAULT nextval('public.recommendations_id_seq'::regclass);


--
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: simulations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations ALTER COLUMN id SET DEFAULT nextval('public.simulations_id_seq'::regclass);


--
-- Data for Name: comparisons; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.comparisons (id, name, simulation_baseline, simulation_comparison, cost_difference, percentage_change, created_at) FROM stdin;
\.


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
<<<<<<< HEAD
1	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:17:52.841+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	1	http://localhost:8055
492	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:36.96+00	172.21.0.1	node	services	8	\N
2	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:11.104+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	2	http://localhost:8055
3	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:14.721+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	3	http://localhost:8055
4	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:16.263+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	4	http://localhost:8055
5	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:17.499+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	5	http://localhost:8055
6	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:19.837+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	6	http://localhost:8055
7	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:47.287+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	7	http://localhost:8055
8	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:48.592+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	8	http://localhost:8055
9	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:19:49.719+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	9	http://localhost:8055
10	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:06.745+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	10	http://localhost:8055
11	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:08.746+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	11	http://localhost:8055
12	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:11.915+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	10	http://localhost:8055
13	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:11.924+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	12	http://localhost:8055
14	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:11.93+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	11	http://localhost:8055
15	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:11.937+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	13	http://localhost:8055
16	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:35.374+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	2	http://localhost:8055
17	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:35.382+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	1	http://localhost:8055
18	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:35.389+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	3	http://localhost:8055
19	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:35.395+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	4	http://localhost:8055
20	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:35.404+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	5	http://localhost:8055
21	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:35.411+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	6	http://localhost:8055
22	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:38.238+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	2	http://localhost:8055
23	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:38.245+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	3	http://localhost:8055
24	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:38.251+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	1	http://localhost:8055
25	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:38.257+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	4	http://localhost:8055
26	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:38.262+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	5	http://localhost:8055
27	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:38.268+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	6	http://localhost:8055
28	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:40.427+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	2	http://localhost:8055
29	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:40.434+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	3	http://localhost:8055
30	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:40.442+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	4	http://localhost:8055
31	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:40.448+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	1	http://localhost:8055
32	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:40.455+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	5	http://localhost:8055
33	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:40.462+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	6	http://localhost:8055
34	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:43.245+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	2	http://localhost:8055
35	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:43.251+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	3	http://localhost:8055
36	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:43.256+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	4	http://localhost:8055
37	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:43.262+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	5	http://localhost:8055
38	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:43.268+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	1	http://localhost:8055
39	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:43.274+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	6	http://localhost:8055
40	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:45.681+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	2	http://localhost:8055
41	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:45.689+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	3	http://localhost:8055
42	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:45.695+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	4	http://localhost:8055
43	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:45.701+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	5	http://localhost:8055
44	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:45.706+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	6	http://localhost:8055
45	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:20:45.71+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	1	http://localhost:8055
46	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:21:02.107+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	pricing	http://localhost:8055
47	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:21:08.031+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	test	http://localhost:8055
48	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:22:16.112+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	simulations_simulation_entries	http://localhost:8055
49	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:22:33.093+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	simulation_entries	http://localhost:8055
50	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:22:37.332+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	simulations	http://localhost:8055
51	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:22:49.511+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	14	http://localhost:8055
52	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:22:49.515+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	prices	http://localhost:8055
53	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:23:01.53+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	15	http://localhost:8055
54	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:23:32.017+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	16	http://localhost:8055
55	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:23:50.709+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	17	http://localhost:8055
56	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:24:16.086+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	18	http://localhost:8055
57	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:24:23.423+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	19	http://localhost:8055
58	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:25:59.065+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	20	http://localhost:8055
59	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:26:23.097+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	21	http://localhost:8055
60	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:26:34.672+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	22	http://localhost:8055
61	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:27:02.789+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	23	http://localhost:8055
62	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:27:02.792+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	simulations	http://localhost:8055
63	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:27:11.041+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	24	http://localhost:8055
64	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:27:22.631+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	25	http://localhost:8055
65	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:29:38.417+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	26	http://localhost:8055
66	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:30:44.384+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	27	http://localhost:8055
67	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:31:56.383+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	28	http://localhost:8055
68	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:32:32.856+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	29	http://localhost:8055
69	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:32:42.714+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	30	http://localhost:8055
70	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:33:18.17+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
71	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:33:18.173+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	resources	http://localhost:8055
72	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:34:09.868+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	32	http://localhost:8055
73	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:34:18.238+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	33	http://localhost:8055
74	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:34:37.837+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
75	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:34:53.755+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
76	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:35:11.735+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
77	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:37:20.613+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	37	http://localhost:8055
78	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:37:31.281+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	37	http://localhost:8055
79	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:37:56.499+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
80	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:38:07.149+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
81	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:38:46.679+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
82	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:39:08.319+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
83	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:39:57.6+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	42	http://localhost:8055
84	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:20.229+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
85	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:23.862+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	42	http://localhost:8055
86	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:43.2+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
87	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.393+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
88	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.4+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	32	http://localhost:8055
89	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.406+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	33	http://localhost:8055
90	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.411+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
91	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.418+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
92	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.424+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
93	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.431+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
94	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.439+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
95	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.444+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
96	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.449+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
97	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.454+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
98	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:40:47.462+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
99	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:41:02.619+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
100	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:41:20.554+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
101	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:44:43.237+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	47	http://localhost:8055
102	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:47:15.293+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	47	http://localhost:8055
103	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:47:43.862+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	48	http://localhost:8055
104	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:49:45.206+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	simulations	1	http://localhost:8055
105	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:51:15.784+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
106	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:51:32.176+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	49	http://localhost:8055
107	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:51:43.665+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
108	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:54:33.975+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	2	http://localhost:8055
109	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:54:45.181+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	49	http://localhost:8055
110	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 21:56:17.777+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	3	http://localhost:8055
111	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:01:14.794+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	48	http://localhost:8055
112	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:02:20.335+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	50	http://localhost:8055
113	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:03:31.453+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	32	http://localhost:8055
114	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:03:36.115+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	33	http://localhost:8055
115	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:03:48.243+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	51	http://localhost:8055
116	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:04:07.993+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
117	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:04:35.498+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	50	http://localhost:8055
118	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:04:57.62+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	53	http://localhost:8055
119	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:34.892+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
120	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.087+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
121	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.094+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
122	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.098+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
123	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.103+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
124	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.109+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	51	http://localhost:8055
125	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.113+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
126	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.116+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
127	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.12+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
128	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.129+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
129	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.138+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
130	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.153+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
131	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.158+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
132	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.163+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
133	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:51.167+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
134	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.879+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	51	http://localhost:8055
135	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.886+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
136	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.894+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
137	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.902+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
138	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.908+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
139	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.913+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
140	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.919+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
141	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.924+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
142	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.93+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
143	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.935+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
144	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.94+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
145	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.945+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
146	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.951+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
147	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:52.956+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
148	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.522+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	51	http://localhost:8055
149	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.528+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
150	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.535+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
151	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.541+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
152	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.55+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
153	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.557+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
154	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.564+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
155	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.571+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
156	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.576+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
157	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.58+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
158	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.585+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
159	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.59+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
160	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.596+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
161	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:54.602+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
162	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.174+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	51	http://localhost:8055
163	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.181+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
164	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.186+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
165	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.201+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
166	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.206+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
167	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.21+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
168	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.214+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
169	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.218+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
170	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.222+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
171	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.227+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
172	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.234+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
173	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.239+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
174	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.244+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
175	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:57.249+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
176	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.25+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	51	http://localhost:8055
177	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.256+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
178	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.261+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	31	http://localhost:8055
179	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.265+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	34	http://localhost:8055
180	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.27+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	35	http://localhost:8055
181	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.275+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	36	http://localhost:8055
182	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.281+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	38	http://localhost:8055
183	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.286+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	39	http://localhost:8055
184	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.292+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	40	http://localhost:8055
185	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.296+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	41	http://localhost:8055
186	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.302+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
187	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.306+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
188	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.311+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
189	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:05:59.316+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
469	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:44.202+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	64	http://localhost:8055
470	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:44.208+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	recommendations	http://localhost:8055
478	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:05:17.188+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	71	http://localhost:8055
479	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:05:30.504+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	72	http://localhost:8055
480	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:05:39.113+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	73	http://localhost:8055
481	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:06:08.385+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	74	http://localhost:8055
482	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:06:48.895+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	75	http://localhost:8055
483	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:07:05.936+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	76	http://localhost:8055
493	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:36.988+00	172.21.0.1	node	instance_types	116	\N
190	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:06:15.591+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	2	http://localhost:8055
191	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:06:23.346+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	3	http://localhost:8055
192	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:10:38.316+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	53	http://localhost:8055
193	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:11:58.525+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	54	http://localhost:8055
194	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:12:24.595+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	52	http://localhost:8055
195	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:13:51.063+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	55	http://localhost:8055
196	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:14:01.117+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	54	http://localhost:8055
197	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:15:06.095+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	56	http://localhost:8055
198	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:15:35.745+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
199	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:15:46.645+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	2	http://localhost:8055
200	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:15:53.694+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	3	http://localhost:8055
201	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:16:24.905+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	56	http://localhost:8055
202	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:16:24.909+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	55	http://localhost:8055
203	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:17:44.925+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	57	http://localhost:8055
204	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:17:45.014+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	58	http://localhost:8055
205	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:17:45.018+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	simulations_simulations	http://localhost:8055
206	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:17:45.054+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	59	http://localhost:8055
207	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:17:45.112+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	60	http://localhost:8055
208	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:18:00.835+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	57	http://localhost:8055
209	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:19:07.148+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	61	http://localhost:8055
210	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:20:17.13+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
211	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:20:47.746+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
212	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:20:55.656+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	2	http://localhost:8055
213	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:21:04.443+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	3	http://localhost:8055
214	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:21:53.436+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
215	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:21:55.796+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
216	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:22:19.205+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
217	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:22:57.314+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
218	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:24:44.204+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
219	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:24:55.669+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
220	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:26:22.892+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	62	http://localhost:8055
222	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:27:11.39+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	simulations_simulations	http://localhost:8055
223	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:27:11.392+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	58	http://localhost:8055
224	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:27:11.393+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	59	http://localhost:8055
225	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:27:11.394+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	60	http://localhost:8055
226	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:29:05.402+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	63	http://localhost:8055
227	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:30:41.848+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
228	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:36:17.48+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	43	http://localhost:8055
229	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:36:25.734+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	44	http://localhost:8055
230	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:36:29.571+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	45	http://localhost:8055
231	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:36:32.568+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	46	http://localhost:8055
232	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:43:26.468+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	2	http://localhost:8055
233	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:43:26.469+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	3	http://localhost:8055
234	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:43:26.469+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	4	http://localhost:8055
235	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:43:26.471+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	5	http://localhost:8055
236	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.67+00	172.21.0.1	node	instance_types	6	\N
237	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.699+00	172.21.0.1	node	instance_types	7	\N
238	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.723+00	172.21.0.1	node	instance_types	8	\N
239	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.745+00	172.21.0.1	node	instance_types	9	\N
240	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.768+00	172.21.0.1	node	instance_types	10	\N
241	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.795+00	172.21.0.1	node	instance_types	11	\N
242	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.818+00	172.21.0.1	node	instance_types	12	\N
243	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.84+00	172.21.0.1	node	instance_types	13	\N
244	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.887+00	172.21.0.1	node	instance_types	14	\N
245	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.907+00	172.21.0.1	node	instance_types	15	\N
246	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.929+00	172.21.0.1	node	instance_types	16	\N
247	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.952+00	172.21.0.1	node	instance_types	17	\N
248	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.973+00	172.21.0.1	node	instance_types	18	\N
249	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:18.996+00	172.21.0.1	node	instance_types	19	\N
250	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.017+00	172.21.0.1	node	instance_types	20	\N
251	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.036+00	172.21.0.1	node	instance_types	21	\N
252	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.059+00	172.21.0.1	node	instance_types	22	\N
253	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.079+00	172.21.0.1	node	instance_types	23	\N
254	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.1+00	172.21.0.1	node	instance_types	24	\N
255	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.125+00	172.21.0.1	node	instance_types	25	\N
256	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.146+00	172.21.0.1	node	instance_types	26	\N
257	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.168+00	172.21.0.1	node	instance_types	27	\N
258	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.188+00	172.21.0.1	node	instance_types	28	\N
259	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.213+00	172.21.0.1	node	instance_types	29	\N
260	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.235+00	172.21.0.1	node	instance_types	30	\N
261	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.261+00	172.21.0.1	node	instance_types	31	\N
262	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.284+00	172.21.0.1	node	instance_types	32	\N
263	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.305+00	172.21.0.1	node	instance_types	33	\N
264	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.324+00	172.21.0.1	node	instance_types	34	\N
265	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.346+00	172.21.0.1	node	instance_types	35	\N
266	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.371+00	172.21.0.1	node	instance_types	36	\N
267	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.407+00	172.21.0.1	node	instance_types	37	\N
268	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.43+00	172.21.0.1	node	instance_types	38	\N
269	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.451+00	172.21.0.1	node	instance_types	39	\N
270	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.473+00	172.21.0.1	node	instance_types	40	\N
271	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.493+00	172.21.0.1	node	instance_types	41	\N
272	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.511+00	172.21.0.1	node	instance_types	42	\N
273	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.531+00	172.21.0.1	node	instance_types	43	\N
274	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:47:19.569+00	172.21.0.1	node	instance_types	44	\N
275	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.63+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	6	http://localhost:8055
276	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.631+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	7	http://localhost:8055
277	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.632+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	8	http://localhost:8055
278	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.632+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	9	http://localhost:8055
279	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.633+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	10	http://localhost:8055
280	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.633+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	11	http://localhost:8055
281	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.634+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	12	http://localhost:8055
282	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.634+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	13	http://localhost:8055
283	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.635+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	14	http://localhost:8055
284	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.636+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	15	http://localhost:8055
285	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.636+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	16	http://localhost:8055
286	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.637+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	17	http://localhost:8055
337	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.808+00	172.21.0.1	node	instance_types	56	\N
287	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.638+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	18	http://localhost:8055
288	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.638+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	19	http://localhost:8055
289	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.639+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	20	http://localhost:8055
290	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.639+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	21	http://localhost:8055
291	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.64+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	22	http://localhost:8055
292	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.641+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	23	http://localhost:8055
293	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.641+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	24	http://localhost:8055
294	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.642+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	25	http://localhost:8055
295	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.642+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	26	http://localhost:8055
296	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.643+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	27	http://localhost:8055
297	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.643+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	28	http://localhost:8055
298	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.644+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	29	http://localhost:8055
299	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:24.644+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	30	http://localhost:8055
300	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.079+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	31	http://localhost:8055
301	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.08+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	32	http://localhost:8055
302	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.08+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	33	http://localhost:8055
303	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.081+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	34	http://localhost:8055
304	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.082+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	35	http://localhost:8055
305	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.082+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	36	http://localhost:8055
306	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.083+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	37	http://localhost:8055
307	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.083+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	38	http://localhost:8055
308	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.084+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	39	http://localhost:8055
309	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.084+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	40	http://localhost:8055
310	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.085+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	41	http://localhost:8055
311	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.086+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	42	http://localhost:8055
312	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.086+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	43	http://localhost:8055
313	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:48:29.087+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	instance_types	44	http://localhost:8055
314	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.415+00	172.21.0.1	node	instance_types	45	\N
315	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.439+00	172.21.0.1	node	prices	1	\N
316	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.461+00	172.21.0.1	node	instance_types	46	\N
317	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.472+00	172.21.0.1	node	prices	2	\N
318	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.494+00	172.21.0.1	node	instance_types	47	\N
319	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.508+00	172.21.0.1	node	prices	3	\N
320	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.528+00	172.21.0.1	node	instance_types	48	\N
321	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.54+00	172.21.0.1	node	prices	4	\N
322	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.561+00	172.21.0.1	node	instance_types	49	\N
323	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.574+00	172.21.0.1	node	prices	5	\N
324	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.594+00	172.21.0.1	node	instance_types	50	\N
325	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.606+00	172.21.0.1	node	prices	6	\N
326	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.628+00	172.21.0.1	node	instance_types	51	\N
327	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.647+00	172.21.0.1	node	prices	7	\N
328	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.668+00	172.21.0.1	node	instance_types	52	\N
329	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.679+00	172.21.0.1	node	prices	8	\N
330	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.704+00	172.21.0.1	node	prices	9	\N
331	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.723+00	172.21.0.1	node	instance_types	53	\N
332	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.733+00	172.21.0.1	node	prices	10	\N
333	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.751+00	172.21.0.1	node	instance_types	54	\N
334	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.76+00	172.21.0.1	node	prices	11	\N
335	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.78+00	172.21.0.1	node	instance_types	55	\N
336	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.791+00	172.21.0.1	node	prices	12	\N
338	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.82+00	172.21.0.1	node	prices	13	\N
339	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.837+00	172.21.0.1	node	instance_types	57	\N
340	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.848+00	172.21.0.1	node	prices	14	\N
341	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.867+00	172.21.0.1	node	instance_types	58	\N
342	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.879+00	172.21.0.1	node	prices	15	\N
343	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.896+00	172.21.0.1	node	instance_types	59	\N
344	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.907+00	172.21.0.1	node	prices	16	\N
345	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.926+00	172.21.0.1	node	instance_types	60	\N
346	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.94+00	172.21.0.1	node	prices	17	\N
347	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.958+00	172.21.0.1	node	instance_types	61	\N
348	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.974+00	172.21.0.1	node	prices	18	\N
349	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:44.994+00	172.21.0.1	node	instance_types	62	\N
350	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.005+00	172.21.0.1	node	prices	19	\N
351	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.025+00	172.21.0.1	node	instance_types	63	\N
352	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.038+00	172.21.0.1	node	prices	20	\N
353	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.055+00	172.21.0.1	node	instance_types	64	\N
354	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.066+00	172.21.0.1	node	prices	21	\N
355	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.087+00	172.21.0.1	node	instance_types	65	\N
356	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.099+00	172.21.0.1	node	prices	22	\N
357	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.118+00	172.21.0.1	node	instance_types	66	\N
358	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.128+00	172.21.0.1	node	prices	23	\N
359	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.152+00	172.21.0.1	node	instance_types	67	\N
360	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.165+00	172.21.0.1	node	prices	24	\N
361	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.189+00	172.21.0.1	node	instance_types	68	\N
362	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.2+00	172.21.0.1	node	prices	25	\N
363	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.217+00	172.21.0.1	node	instance_types	69	\N
364	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.23+00	172.21.0.1	node	prices	26	\N
365	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.248+00	172.21.0.1	node	instance_types	70	\N
366	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.26+00	172.21.0.1	node	prices	27	\N
367	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.28+00	172.21.0.1	node	instance_types	71	\N
368	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.29+00	172.21.0.1	node	prices	28	\N
369	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.308+00	172.21.0.1	node	instance_types	72	\N
370	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.32+00	172.21.0.1	node	prices	29	\N
371	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.339+00	172.21.0.1	node	instance_types	73	\N
372	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.352+00	172.21.0.1	node	prices	30	\N
373	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.368+00	172.21.0.1	node	instance_types	74	\N
374	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.38+00	172.21.0.1	node	prices	31	\N
375	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.396+00	172.21.0.1	node	instance_types	75	\N
376	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.406+00	172.21.0.1	node	prices	32	\N
377	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.428+00	172.21.0.1	node	prices	33	\N
378	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.448+00	172.21.0.1	node	instance_types	76	\N
379	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.46+00	172.21.0.1	node	prices	34	\N
380	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.478+00	172.21.0.1	node	instance_types	77	\N
381	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.487+00	172.21.0.1	node	prices	35	\N
382	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.506+00	172.21.0.1	node	instance_types	78	\N
383	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.516+00	172.21.0.1	node	prices	36	\N
384	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.533+00	172.21.0.1	node	instance_types	79	\N
385	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.543+00	172.21.0.1	node	prices	37	\N
386	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.563+00	172.21.0.1	node	instance_types	80	\N
387	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.573+00	172.21.0.1	node	prices	38	\N
388	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.589+00	172.21.0.1	node	instance_types	81	\N
389	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.6+00	172.21.0.1	node	prices	39	\N
390	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.615+00	172.21.0.1	node	instance_types	82	\N
391	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.626+00	172.21.0.1	node	prices	40	\N
392	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.645+00	172.21.0.1	node	prices	41	\N
393	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.663+00	172.21.0.1	node	instance_types	83	\N
394	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.674+00	172.21.0.1	node	prices	42	\N
395	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.693+00	172.21.0.1	node	instance_types	84	\N
396	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.703+00	172.21.0.1	node	prices	43	\N
397	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.722+00	172.21.0.1	node	instance_types	85	\N
398	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.732+00	172.21.0.1	node	prices	44	\N
399	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.747+00	172.21.0.1	node	instance_types	86	\N
400	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.758+00	172.21.0.1	node	prices	45	\N
401	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.778+00	172.21.0.1	node	instance_types	87	\N
402	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.788+00	172.21.0.1	node	prices	46	\N
403	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.805+00	172.21.0.1	node	instance_types	88	\N
404	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.815+00	172.21.0.1	node	prices	47	\N
405	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.83+00	172.21.0.1	node	instance_types	89	\N
406	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.842+00	172.21.0.1	node	prices	48	\N
407	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.859+00	172.21.0.1	node	instance_types	90	\N
408	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.871+00	172.21.0.1	node	prices	49	\N
409	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.888+00	172.21.0.1	node	instance_types	91	\N
410	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.899+00	172.21.0.1	node	prices	50	\N
411	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.913+00	172.21.0.1	node	instance_types	92	\N
412	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.924+00	172.21.0.1	node	prices	51	\N
413	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.941+00	172.21.0.1	node	instance_types	93	\N
414	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.951+00	172.21.0.1	node	prices	52	\N
415	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.968+00	172.21.0.1	node	instance_types	94	\N
416	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.978+00	172.21.0.1	node	prices	53	\N
417	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:45.996+00	172.21.0.1	node	instance_types	95	\N
418	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.007+00	172.21.0.1	node	prices	54	\N
419	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.024+00	172.21.0.1	node	instance_types	96	\N
420	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.034+00	172.21.0.1	node	prices	55	\N
421	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.05+00	172.21.0.1	node	instance_types	97	\N
422	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.061+00	172.21.0.1	node	prices	56	\N
423	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.081+00	172.21.0.1	node	instance_types	98	\N
424	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.091+00	172.21.0.1	node	prices	57	\N
425	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.111+00	172.21.0.1	node	prices	58	\N
426	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.127+00	172.21.0.1	node	instance_types	99	\N
427	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.137+00	172.21.0.1	node	prices	59	\N
428	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.153+00	172.21.0.1	node	instance_types	100	\N
429	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.162+00	172.21.0.1	node	prices	60	\N
430	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.178+00	172.21.0.1	node	instance_types	101	\N
431	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.188+00	172.21.0.1	node	prices	61	\N
432	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.209+00	172.21.0.1	node	prices	62	\N
433	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.225+00	172.21.0.1	node	instance_types	102	\N
434	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.234+00	172.21.0.1	node	prices	63	\N
435	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.255+00	172.21.0.1	node	prices	64	\N
436	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.275+00	172.21.0.1	node	prices	65	\N
437	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.291+00	172.21.0.1	node	instance_types	103	\N
438	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.301+00	172.21.0.1	node	prices	66	\N
439	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.316+00	172.21.0.1	node	instance_types	104	\N
440	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.325+00	172.21.0.1	node	prices	67	\N
441	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.344+00	172.21.0.1	node	instance_types	105	\N
442	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.357+00	172.21.0.1	node	prices	68	\N
443	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.374+00	172.21.0.1	node	instance_types	106	\N
444	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.383+00	172.21.0.1	node	prices	69	\N
445	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.407+00	172.21.0.1	node	instance_types	107	\N
446	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.426+00	172.21.0.1	node	prices	70	\N
447	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.443+00	172.21.0.1	node	instance_types	108	\N
448	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.454+00	172.21.0.1	node	prices	71	\N
449	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.474+00	172.21.0.1	node	instance_types	109	\N
450	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.485+00	172.21.0.1	node	prices	72	\N
451	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.499+00	172.21.0.1	node	instance_types	110	\N
452	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.51+00	172.21.0.1	node	prices	73	\N
453	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.528+00	172.21.0.1	node	prices	74	\N
454	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.545+00	172.21.0.1	node	instance_types	111	\N
455	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.555+00	172.21.0.1	node	prices	75	\N
456	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.57+00	172.21.0.1	node	instance_types	112	\N
457	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.58+00	172.21.0.1	node	prices	76	\N
458	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.62+00	172.21.0.1	node	prices	77	\N
459	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.638+00	172.21.0.1	node	instance_types	113	\N
460	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.649+00	172.21.0.1	node	prices	78	\N
461	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.67+00	172.21.0.1	node	prices	79	\N
462	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.686+00	172.21.0.1	node	instance_types	114	\N
463	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.695+00	172.21.0.1	node	prices	80	\N
464	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.712+00	172.21.0.1	node	prices	81	\N
465	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.732+00	172.21.0.1	node	prices	82	\N
466	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 22:50:46.747+00	172.21.0.1	node	instance_types	115	\N
467	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:10:43.053+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	services	7	http://localhost:8055
468	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:13:39.962+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	resources	1	http://localhost:8055
471	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:02:10.095+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	65	http://localhost:8055
472	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:02:39.405+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	66	http://localhost:8055
473	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:03:08.583+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	67	http://localhost:8055
474	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:03:46.866+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	67	http://localhost:8055
475	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:04:22.207+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	68	http://localhost:8055
476	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:04:36.895+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	69	http://localhost:8055
477	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:05:02.849+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	70	http://localhost:8055
484	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:07:25.107+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	77	http://localhost:8055
485	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:07:25.11+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_collections	comparisons	http://localhost:8055
486	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:07:36.766+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	78	http://localhost:8055
487	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:08:01.204+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	79	http://localhost:8055
488	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:08:21.405+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	80	http://localhost:8055
489	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:08:30.196+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	81	http://localhost:8055
490	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:08:38.09+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	82	http://localhost:8055
491	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:09:09.706+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	directus_fields	83	http://localhost:8055
494	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.011+00	172.21.0.1	node	prices	1	\N
495	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.041+00	172.21.0.1	node	instance_types	117	\N
496	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.057+00	172.21.0.1	node	prices	2	\N
497	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.079+00	172.21.0.1	node	instance_types	118	\N
498	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.092+00	172.21.0.1	node	prices	3	\N
499	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.116+00	172.21.0.1	node	instance_types	119	\N
500	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:10:37.138+00	172.21.0.1	node	prices	4	\N
501	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.801+00	172.21.0.1	node	prices	1	\N
502	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.831+00	172.21.0.1	node	prices	2	\N
503	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.857+00	172.21.0.1	node	prices	3	\N
504	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.88+00	172.21.0.1	node	prices	4	\N
505	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.902+00	172.21.0.1	node	instance_types	120	\N
506	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.915+00	172.21.0.1	node	prices	5	\N
507	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.934+00	172.21.0.1	node	instance_types	121	\N
508	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.947+00	172.21.0.1	node	prices	6	\N
509	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.968+00	172.21.0.1	node	instance_types	122	\N
510	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:04.981+00	172.21.0.1	node	prices	7	\N
511	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:05.012+00	172.21.0.1	node	instance_types	123	\N
512	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:05.023+00	172.21.0.1	node	prices	8	\N
513	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:05.047+00	172.21.0.1	node	prices	9	\N
514	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:14:05.065+00	172.21.0.1	node	instance_types	124	\N
=======
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
84	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:37:00.811+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	prices	http://localhost:8055
85	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:37:05.304+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	resources	http://localhost:8055
86	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:35.502+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	64	http://localhost:8055
87	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:45.071+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	65	http://localhost:8055
88	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:48.746+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	66	http://localhost:8055
89	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:50.549+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	67	http://localhost:8055
90	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:53.036+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	68	http://localhost:8055
91	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:55.132+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	69	http://localhost:8055
92	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:57.594+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	70	http://localhost:8055
93	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 06:59:59.607+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	71	http://localhost:8055
94	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:01.261+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	72	http://localhost:8055
95	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:09.593+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	73	http://localhost:8055
96	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:11.992+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	74	http://localhost:8055
97	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:15.22+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	75	http://localhost:8055
98	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:16.969+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	76	http://localhost:8055
99	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:25.191+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	77	http://localhost:8055
100	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:30.375+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	78	http://localhost:8055
101	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:32.722+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	79	http://localhost:8055
102	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:34.729+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	80	http://localhost:8055
103	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:36.893+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	81	http://localhost:8055
104	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:00:39.462+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	82	http://localhost:8055
106	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 09:17:42.137+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	simulations	2	http://localhost:8055
107	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:09:39.798+00	172.19.0.1	node	services	8	\N
108	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.016+00	172.19.0.1	node	regions	45	\N
109	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.042+00	172.19.0.1	node	regions	46	\N
3	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:44:04.76+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
4	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:44:04.769+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	test	http://localhost:8055
5	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 13:44:12.851+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
62	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:48:17.311+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	2	http://localhost:8055
65	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:49:43.078+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	services	4	http://localhost:8055
68	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:52:59.751+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	1	http://localhost:8055
71	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:53:43.753+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	4	http://localhost:8055
73	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 14:54:03.635+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	regions	6	http://localhost:8055
105	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 07:16:36.669+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	27fc7a4b-bd46-414c-8883-99f3ae3089df	http://localhost:8055
110	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.061+00	172.19.0.1	node	regions	47	\N
111	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.08+00	172.19.0.1	node	regions	48	\N
112	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.102+00	172.19.0.1	node	regions	49	\N
113	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.126+00	172.19.0.1	node	regions	50	\N
114	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.145+00	172.19.0.1	node	regions	51	\N
115	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.165+00	172.19.0.1	node	regions	52	\N
116	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.187+00	172.19.0.1	node	regions	53	\N
117	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.205+00	172.19.0.1	node	regions	54	\N
118	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.218+00	172.19.0.1	node	regions	55	\N
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
119	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.237+00	172.19.0.1	node	regions	56	\N
120	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.251+00	172.19.0.1	node	regions	57	\N
121	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.269+00	172.19.0.1	node	regions	58	\N
122	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.286+00	172.19.0.1	node	regions	59	\N
123	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.303+00	172.19.0.1	node	regions	60	\N
124	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.32+00	172.19.0.1	node	regions	61	\N
125	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.336+00	172.19.0.1	node	regions	62	\N
126	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.351+00	172.19.0.1	node	regions	63	\N
127	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.367+00	172.19.0.1	node	regions	64	\N
128	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.388+00	172.19.0.1	node	regions	65	\N
129	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.403+00	172.19.0.1	node	regions	66	\N
130	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.415+00	172.19.0.1	node	regions	67	\N
131	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.429+00	172.19.0.1	node	regions	68	\N
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
132	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.444+00	172.19.0.1	node	regions	69	\N
133	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.458+00	172.19.0.1	node	regions	70	\N
134	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.472+00	172.19.0.1	node	regions	71	\N
135	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.486+00	172.19.0.1	node	regions	72	\N
136	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.5+00	172.19.0.1	node	regions	73	\N
137	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.515+00	172.19.0.1	node	regions	74	\N
138	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.529+00	172.19.0.1	node	regions	75	\N
139	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.546+00	172.19.0.1	node	regions	76	\N
140	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.572+00	172.19.0.1	node	regions	77	\N
141	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:28.598+00	172.19.0.1	node	regions	78	\N
221	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.95+00	172.19.0.1	node	instance_types	154	\N
222	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.969+00	172.19.0.1	node	prices	124	\N
223	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.004+00	172.19.0.1	node	instance_types	155	\N
224	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.022+00	172.19.0.1	node	prices	125	\N
225	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.055+00	172.19.0.1	node	instance_types	156	\N
226	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.074+00	172.19.0.1	node	prices	126	\N
227	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.106+00	172.19.0.1	node	instance_types	157	\N
228	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.125+00	172.19.0.1	node	prices	127	\N
229	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.162+00	172.19.0.1	node	instance_types	158	\N
230	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.18+00	172.19.0.1	node	prices	128	\N
231	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.217+00	172.19.0.1	node	instance_types	159	\N
232	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.242+00	172.19.0.1	node	prices	129	\N
233	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.277+00	172.19.0.1	node	instance_types	160	\N
234	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.299+00	172.19.0.1	node	prices	130	\N
235	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.337+00	172.19.0.1	node	instance_types	161	\N
236	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.354+00	172.19.0.1	node	prices	131	\N
237	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.387+00	172.19.0.1	node	instance_types	162	\N
238	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.408+00	172.19.0.1	node	prices	132	\N
239	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.439+00	172.19.0.1	node	instance_types	163	\N
240	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.455+00	172.19.0.1	node	prices	133	\N
241	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.486+00	172.19.0.1	node	instance_types	164	\N
242	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.507+00	172.19.0.1	node	prices	134	\N
243	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.538+00	172.19.0.1	node	instance_types	165	\N
244	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.559+00	172.19.0.1	node	prices	135	\N
245	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.59+00	172.19.0.1	node	instance_types	166	\N
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
142	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.344+00	172.19.0.1	node	instance_types	116	\N
143	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.377+00	172.19.0.1	node	prices	83	\N
144	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.423+00	172.19.0.1	node	instance_types	117	\N
145	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.441+00	172.19.0.1	node	prices	84	\N
146	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.479+00	172.19.0.1	node	instance_types	118	\N
147	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.499+00	172.19.0.1	node	prices	85	\N
148	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.538+00	172.19.0.1	node	instance_types	119	\N
149	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.557+00	172.19.0.1	node	prices	86	\N
150	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.591+00	172.19.0.1	node	instance_types	120	\N
151	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.611+00	172.19.0.1	node	prices	87	\N
152	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.644+00	172.19.0.1	node	instance_types	121	\N
153	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.665+00	172.19.0.1	node	prices	88	\N
154	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.7+00	172.19.0.1	node	instance_types	122	\N
155	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.718+00	172.19.0.1	node	prices	89	\N
156	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.757+00	172.19.0.1	node	instance_types	123	\N
157	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.781+00	172.19.0.1	node	prices	90	\N
158	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.831+00	172.19.0.1	node	prices	91	\N
159	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.875+00	172.19.0.1	node	instance_types	124	\N
160	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.898+00	172.19.0.1	node	prices	92	\N
161	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.938+00	172.19.0.1	node	instance_types	125	\N
162	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:54.963+00	172.19.0.1	node	prices	93	\N
163	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.006+00	172.19.0.1	node	instance_types	126	\N
164	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.03+00	172.19.0.1	node	prices	94	\N
165	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.076+00	172.19.0.1	node	instance_types	127	\N
166	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.101+00	172.19.0.1	node	prices	95	\N
167	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.189+00	172.19.0.1	node	instance_types	128	\N
168	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.244+00	172.19.0.1	node	prices	96	\N
169	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.338+00	172.19.0.1	node	instance_types	129	\N
170	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.384+00	172.19.0.1	node	prices	97	\N
171	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.43+00	172.19.0.1	node	instance_types	130	\N
172	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.457+00	172.19.0.1	node	prices	98	\N
173	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.507+00	172.19.0.1	node	instance_types	131	\N
174	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.536+00	172.19.0.1	node	prices	99	\N
175	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.573+00	172.19.0.1	node	instance_types	132	\N
176	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.597+00	172.19.0.1	node	prices	100	\N
177	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.64+00	172.19.0.1	node	instance_types	133	\N
178	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.669+00	172.19.0.1	node	prices	101	\N
81	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:10:28.088+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	test	http://localhost:8055
82	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:10:28.097+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
83	delete	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-01 15:10:28.099+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
179	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.714+00	172.19.0.1	node	instance_types	134	\N
180	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.74+00	172.19.0.1	node	prices	102	\N
181	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.771+00	172.19.0.1	node	instance_types	135	\N
182	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.787+00	172.19.0.1	node	prices	103	\N
183	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.825+00	172.19.0.1	node	instance_types	136	\N
184	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.842+00	172.19.0.1	node	prices	104	\N
185	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.878+00	172.19.0.1	node	instance_types	137	\N
186	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.9+00	172.19.0.1	node	prices	105	\N
187	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.938+00	172.19.0.1	node	instance_types	138	\N
188	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:55.96+00	172.19.0.1	node	prices	106	\N
189	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.002+00	172.19.0.1	node	instance_types	139	\N
190	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.024+00	172.19.0.1	node	prices	107	\N
191	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.067+00	172.19.0.1	node	instance_types	140	\N
192	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.087+00	172.19.0.1	node	prices	108	\N
193	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.124+00	172.19.0.1	node	instance_types	141	\N
194	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.149+00	172.19.0.1	node	prices	109	\N
195	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.201+00	172.19.0.1	node	instance_types	142	\N
196	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.222+00	172.19.0.1	node	prices	110	\N
197	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.266+00	172.19.0.1	node	instance_types	143	\N
198	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.29+00	172.19.0.1	node	prices	111	\N
199	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.331+00	172.19.0.1	node	instance_types	144	\N
200	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.354+00	172.19.0.1	node	prices	112	\N
201	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.387+00	172.19.0.1	node	instance_types	145	\N
202	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.405+00	172.19.0.1	node	prices	113	\N
203	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.435+00	172.19.0.1	node	instance_types	146	\N
204	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.457+00	172.19.0.1	node	prices	114	\N
205	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.492+00	172.19.0.1	node	prices	115	\N
206	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.524+00	172.19.0.1	node	instance_types	147	\N
207	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.542+00	172.19.0.1	node	prices	116	\N
208	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.577+00	172.19.0.1	node	instance_types	148	\N
209	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.597+00	172.19.0.1	node	prices	117	\N
210	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.63+00	172.19.0.1	node	instance_types	149	\N
211	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.65+00	172.19.0.1	node	prices	118	\N
212	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.691+00	172.19.0.1	node	instance_types	150	\N
213	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.711+00	172.19.0.1	node	prices	119	\N
214	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.747+00	172.19.0.1	node	instance_types	151	\N
215	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.768+00	172.19.0.1	node	prices	120	\N
216	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.802+00	172.19.0.1	node	instance_types	152	\N
217	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.821+00	172.19.0.1	node	prices	121	\N
218	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.854+00	172.19.0.1	node	instance_types	153	\N
219	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.873+00	172.19.0.1	node	prices	122	\N
220	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:56.913+00	172.19.0.1	node	prices	123	\N
246	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.61+00	172.19.0.1	node	prices	136	\N
247	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.649+00	172.19.0.1	node	instance_types	167	\N
248	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.666+00	172.19.0.1	node	prices	137	\N
249	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.695+00	172.19.0.1	node	instance_types	168	\N
250	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.713+00	172.19.0.1	node	prices	138	\N
251	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.744+00	172.19.0.1	node	instance_types	169	\N
252	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.762+00	172.19.0.1	node	prices	139	\N
253	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.8+00	172.19.0.1	node	prices	140	\N
254	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.834+00	172.19.0.1	node	instance_types	170	\N
255	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.857+00	172.19.0.1	node	prices	141	\N
256	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.895+00	172.19.0.1	node	instance_types	171	\N
257	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.917+00	172.19.0.1	node	prices	142	\N
258	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.95+00	172.19.0.1	node	instance_types	172	\N
259	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:57.971+00	172.19.0.1	node	prices	143	\N
260	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.014+00	172.19.0.1	node	prices	144	\N
261	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.05+00	172.19.0.1	node	instance_types	173	\N
262	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.07+00	172.19.0.1	node	prices	145	\N
263	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.114+00	172.19.0.1	node	prices	146	\N
264	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.149+00	172.19.0.1	node	prices	147	\N
265	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.18+00	172.19.0.1	node	instance_types	174	\N
266	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.2+00	172.19.0.1	node	prices	148	\N
267	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.233+00	172.19.0.1	node	instance_types	175	\N
268	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.254+00	172.19.0.1	node	prices	149	\N
269	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.287+00	172.19.0.1	node	instance_types	176	\N
270	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.307+00	172.19.0.1	node	prices	150	\N
271	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.342+00	172.19.0.1	node	instance_types	177	\N
272	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.363+00	172.19.0.1	node	prices	151	\N
273	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.398+00	172.19.0.1	node	instance_types	178	\N
274	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.42+00	172.19.0.1	node	prices	152	\N
275	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.454+00	172.19.0.1	node	instance_types	179	\N
276	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.475+00	172.19.0.1	node	prices	153	\N
277	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.523+00	172.19.0.1	node	instance_types	180	\N
278	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.549+00	172.19.0.1	node	prices	154	\N
279	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.581+00	172.19.0.1	node	instance_types	181	\N
280	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.601+00	172.19.0.1	node	prices	155	\N
281	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.642+00	172.19.0.1	node	prices	156	\N
282	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.675+00	172.19.0.1	node	instance_types	182	\N
283	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.698+00	172.19.0.1	node	prices	157	\N
284	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.735+00	172.19.0.1	node	instance_types	183	\N
285	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.752+00	172.19.0.1	node	prices	158	\N
286	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.793+00	172.19.0.1	node	prices	159	\N
287	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.828+00	172.19.0.1	node	instance_types	184	\N
288	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.848+00	172.19.0.1	node	prices	160	\N
289	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.898+00	172.19.0.1	node	prices	161	\N
290	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.942+00	172.19.0.1	node	instance_types	185	\N
291	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:58.97+00	172.19.0.1	node	prices	162	\N
292	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.016+00	172.19.0.1	node	prices	163	\N
293	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.074+00	172.19.0.1	node	prices	164	\N
294	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.114+00	172.19.0.1	node	instance_types	186	\N
295	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.137+00	172.19.0.1	node	prices	165	\N
296	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.185+00	172.19.0.1	node	prices	166	\N
297	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.225+00	172.19.0.1	node	instance_types	187	\N
298	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.277+00	172.19.0.1	node	prices	167	\N
299	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.336+00	172.19.0.1	node	instance_types	188	\N
300	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.361+00	172.19.0.1	node	prices	168	\N
301	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.413+00	172.19.0.1	node	prices	169	\N
302	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.449+00	172.19.0.1	node	instance_types	189	\N
303	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.469+00	172.19.0.1	node	prices	170	\N
304	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.504+00	172.19.0.1	node	instance_types	190	\N
305	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.524+00	172.19.0.1	node	prices	171	\N
306	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.56+00	172.19.0.1	node	instance_types	191	\N
307	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.581+00	172.19.0.1	node	prices	172	\N
308	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.626+00	172.19.0.1	node	prices	173	\N
309	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.664+00	172.19.0.1	node	instance_types	192	\N
310	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.687+00	172.19.0.1	node	prices	174	\N
311	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.728+00	172.19.0.1	node	instance_types	193	\N
312	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.75+00	172.19.0.1	node	prices	175	\N
313	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.79+00	172.19.0.1	node	instance_types	194	\N
314	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.812+00	172.19.0.1	node	prices	176	\N
315	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.846+00	172.19.0.1	node	instance_types	195	\N
316	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.865+00	172.19.0.1	node	prices	177	\N
317	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.904+00	172.19.0.1	node	prices	178	\N
318	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.946+00	172.19.0.1	node	prices	179	\N
319	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:19:59.98+00	172.19.0.1	node	instance_types	196	\N
320	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00+00	172.19.0.1	node	prices	180	\N
321	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00.041+00	172.19.0.1	node	prices	181	\N
322	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00.084+00	172.19.0.1	node	prices	182	\N
323	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00.115+00	172.19.0.1	node	instance_types	197	\N
324	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00.134+00	172.19.0.1	node	prices	183	\N
325	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00.167+00	172.19.0.1	node	instance_types	198	\N
326	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:00.19+00	172.19.0.1	node	prices	184	\N
327	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:47:47.927+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	simulation_entries	1	http://localhost:8055
328	create	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:47:47.936+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	simulations_simulation_entries	1	http://localhost:8055
329	update	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:47:47.943+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	simulations	2	http://localhost:8055
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
services	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
regions	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
instance_types	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
prices	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
simulations	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
resources	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
recommendations	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
comparisons	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
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
64	recommendations	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
7	services	id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
8	services	name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
9	services	code	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
10	regions	id	\N	\N	\N	\N	\N	f	f	1	full	\N	\N	\N	f	\N	\N	\N
12	regions	code	\N	\N	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
11	regions	name	\N	\N	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
13	regions	country	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
65	recommendations	simulation_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
66	recommendations	resource_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
67	recommendations	type	\N	select-dropdown	{"choices":[{"text":"cost_optimization","value":"cost_optimization"},{"text":"performance","value":"performance"},{"text":"security","value":"security"}]}	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
61	resources	simulations_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	15	full	\N	\N	\N	f	\N	\N	\N
68	recommendations	prioprity	\N	select-dropdown	{"choices":[{"text":"high","value":"high"},{"text":"medium","value":"medium"},{"text":"low","value":"low"}]}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
69	recommendations	title	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
70	recommendations	description	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
71	recommendations	current_cost	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
72	recommendations	optimized_cost	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
73	recommendations	potential_savings	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N
74	recommendations	implementation_effort	\N	select-dropdown	{"choices":[{"text":"easy","value":"easy"},{"text":"medium","value":"medium"},{"text":"hard","value":"hard"}]}	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N
75	recommendations	applied	cast-boolean	boolean	\N	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N
76	recommendations	created_at	\N	datetime	\N	\N	\N	f	f	13	full	\N	\N	\N	f	\N	\N	\N
77	comparisons	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
78	comparisons	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
79	comparisons	simulation_baseline	m2o	select-dropdown-m2o	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
80	comparisons	simulation_comparison	m2o	select-dropdown-m2o	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
51	resources	resource_name	\N	input	\N	\N	\N	f	f	1	full	\N	\N	\N	f	\N	\N	\N
81	comparisons	cost_difference	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
31	resources	id	\N	input	\N	\N	\N	t	t	3	full	\N	\N	\N	f	\N	\N	\N
34	resources	service	m2o	select-dropdown-m2o	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
35	resources	region	m2o	select-dropdown-m2o	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
2	instance_types	id	\N	\N	\N	\N	\N	f	f	1	full	\N	\N	\N	f	\N	\N	\N
3	instance_types	name	\N	\N	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
4	instance_types	service	\N	\N	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
5	instance_types	vcpu	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
6	instance_types	memory	\N	\N	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
1	instance_types	category	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
14	prices	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
15	prices	sku	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
16	prices	service	m2o	select-dropdown-m2o	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
17	prices	region	m2o	select-dropdown-m2o	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
18	prices	instance_type	m2o	select-dropdown-m2o	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
19	prices	os	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
20	prices	price_per_unit	\N	input	{"min":0}	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
21	prices	created_at	\N	datetime	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
22	prices	updated_at	\N	datetime	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
23	simulations	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
24	simulations	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
25	simulations	description	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
26	simulations	status	\N	select-dropdown	{"choices":[{"text":"draft","value":"draft","icon":"draft_orders"},{"text":"active","value":"active","icon":"notifications_active"},{"text":"archived","value":"archived","icon":"archive"}]}	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
27	simulations	scenario_type	\N	select-dropdown	{"choices":[{"text":"current","value":"current"},{"text":"proposed","value":"proposed"},{"text":"optimized","value":"optimized"}]}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
28	simulations	monthly_coast	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
29	simulations	created_at	\N	datetime	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
30	simulations	updated_at	\N	datetime	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
82	comparisons	percentage_change	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
83	comparisons	created_at	\N	datetime	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
36	resources	instance_type	m2o	select-dropdown-m2o	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
38	resources	configuration	cast-json	input-code	{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"}	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
39	resources	unit_price	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
40	resources	monthly_cost	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
63	simulations	resources	o2m	list-o2m	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
41	resources	created_at	\N	datetime	\N	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N
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
20250813A	Add MCP	2025-10-01 13:47:51.110765+00
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
<<<<<<< HEAD
3	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	resources	\N	\N	{"tabular":{"fields":["region","resource_name","service","simulation_id","id"]}}	\N	\N	\N	bookmark	\N
2	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
5	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	simulations	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
7	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	prices	\N	\N	{"tabular":{"fields":["instance_type","region","service","sku","os","price_per_unit","created_at","updated_at"],"page":1}}	\N	\N	\N	bookmark	\N
4	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	services	\N	\N	{"tabular":{"limit":1000,"page":1}}	\N	\N	\N	bookmark	\N
6	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	instance_types	\N	\N	{"tabular":{"page":1,"fields":["memory","name","service","vcpu","service.id"]}}	\N	\N	\N	bookmark	\N
8	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N	bookmark	\N
1	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	regions	\N	\N	{"tabular":{"fields":["code","name","country"],"page":1}}	{"tabular":{"widths":{"code":160,"name":441.5260009765625}}}	\N	\N	bookmark	\N
=======
1	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	regions	\N	\N	{"tabular":{"fields":["code","name","id"],"page":1}}	{"tabular":{"widths":{"code":160,"name":441.5260009765625}}}	\N	\N	bookmark	\N
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	prices	service	services	\N	\N	\N	\N	\N	nullify
2	prices	region	regions	\N	\N	\N	\N	\N	nullify
3	prices	instance_type	instance_types	\N	\N	\N	\N	\N	nullify
5	resources	service	services	\N	\N	\N	\N	\N	nullify
6	resources	region	regions	\N	\N	\N	\N	\N	nullify
7	resources	instance_type	instance_types	\N	\N	\N	\N	\N	nullify
17	resources	simulations_id	simulations	resources	\N	\N	\N	\N	nullify
18	recommendations	simulation_id	simulations	\N	\N	\N	\N	\N	nullify
19	recommendations	resource_id	resources	\N	\N	\N	\N	\N	nullify
20	comparisons	simulation_baseline	simulations	\N	\N	\N	\N	\N	nullify
21	comparisons	simulation_comparison	simulations	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
<<<<<<< HEAD
1	1	directus_fields	1	{"sort":1,"interface":"input","special":null,"collection":"instance_types","field":"category"}	{"sort":1,"interface":"input","special":null,"collection":"instance_types","field":"category"}	\N	\N
397	469	directus_fields	64	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"recommendations"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"recommendations"}	\N	\N
2	2	directus_fields	2	{"special":null,"collection":"instance_types","field":"id"}	{"special":null,"collection":"instance_types","field":"id"}	\N	\N
3	3	directus_fields	3	{"special":null,"collection":"instance_types","field":"name"}	{"special":null,"collection":"instance_types","field":"name"}	\N	\N
4	4	directus_fields	4	{"special":null,"collection":"instance_types","field":"service"}	{"special":null,"collection":"instance_types","field":"service"}	\N	\N
5	5	directus_fields	5	{"special":null,"collection":"instance_types","field":"vcpu"}	{"special":null,"collection":"instance_types","field":"vcpu"}	\N	\N
6	6	directus_fields	6	{"special":null,"collection":"instance_types","field":"memory"}	{"special":null,"collection":"instance_types","field":"memory"}	\N	\N
7	7	directus_fields	7	{"special":null,"collection":"services","field":"id"}	{"special":null,"collection":"services","field":"id"}	\N	\N
8	8	directus_fields	8	{"special":null,"collection":"services","field":"name"}	{"special":null,"collection":"services","field":"name"}	\N	\N
9	9	directus_fields	9	{"special":null,"collection":"services","field":"code"}	{"special":null,"collection":"services","field":"code"}	\N	\N
10	10	directus_fields	10	{"special":null,"collection":"regions","field":"id"}	{"special":null,"collection":"regions","field":"id"}	\N	\N
11	11	directus_fields	11	{"special":null,"collection":"regions","field":"name"}	{"special":null,"collection":"regions","field":"name"}	\N	\N
12	12	directus_fields	10	{"id":10,"collection":"regions","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"regions","field":"id","sort":1,"group":null}	\N	\N
13	13	directus_fields	12	{"sort":2,"group":null,"collection":"regions","field":"code"}	{"sort":2,"group":null,"collection":"regions","field":"code"}	\N	\N
14	14	directus_fields	11	{"id":11,"collection":"regions","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"regions","field":"name","sort":3,"group":null}	\N	\N
15	15	directus_fields	13	{"sort":4,"group":null,"collection":"regions","field":"country"}	{"sort":4,"group":null,"collection":"regions","field":"country"}	\N	\N
16	16	directus_fields	2	{"id":2,"collection":"instance_types","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"id","sort":1,"group":null}	\N	\N
17	17	directus_fields	1	{"id":1,"collection":"instance_types","field":"category","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"category","sort":2,"group":null}	\N	\N
18	18	directus_fields	3	{"id":3,"collection":"instance_types","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"name","sort":3,"group":null}	\N	\N
19	19	directus_fields	4	{"id":4,"collection":"instance_types","field":"service","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"service","sort":4,"group":null}	\N	\N
20	20	directus_fields	5	{"id":5,"collection":"instance_types","field":"vcpu","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"vcpu","sort":5,"group":null}	\N	\N
21	21	directus_fields	6	{"id":6,"collection":"instance_types","field":"memory","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"memory","sort":6,"group":null}	\N	\N
22	22	directus_fields	2	{"id":2,"collection":"instance_types","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"id","sort":1,"group":null}	\N	\N
23	23	directus_fields	3	{"id":3,"collection":"instance_types","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"name","sort":2,"group":null}	\N	\N
24	24	directus_fields	1	{"id":1,"collection":"instance_types","field":"category","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"category","sort":3,"group":null}	\N	\N
25	25	directus_fields	4	{"id":4,"collection":"instance_types","field":"service","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"service","sort":4,"group":null}	\N	\N
26	26	directus_fields	5	{"id":5,"collection":"instance_types","field":"vcpu","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"vcpu","sort":5,"group":null}	\N	\N
27	27	directus_fields	6	{"id":6,"collection":"instance_types","field":"memory","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"memory","sort":6,"group":null}	\N	\N
28	28	directus_fields	2	{"id":2,"collection":"instance_types","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"id","sort":1,"group":null}	\N	\N
29	29	directus_fields	3	{"id":3,"collection":"instance_types","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"name","sort":2,"group":null}	\N	\N
30	30	directus_fields	4	{"id":4,"collection":"instance_types","field":"service","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"service","sort":3,"group":null}	\N	\N
31	31	directus_fields	1	{"id":1,"collection":"instance_types","field":"category","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"category","sort":4,"group":null}	\N	\N
32	32	directus_fields	5	{"id":5,"collection":"instance_types","field":"vcpu","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"vcpu","sort":5,"group":null}	\N	\N
33	33	directus_fields	6	{"id":6,"collection":"instance_types","field":"memory","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"memory","sort":6,"group":null}	\N	\N
34	34	directus_fields	2	{"id":2,"collection":"instance_types","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"id","sort":1,"group":null}	\N	\N
35	35	directus_fields	3	{"id":3,"collection":"instance_types","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"name","sort":2,"group":null}	\N	\N
36	36	directus_fields	4	{"id":4,"collection":"instance_types","field":"service","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"service","sort":3,"group":null}	\N	\N
37	37	directus_fields	5	{"id":5,"collection":"instance_types","field":"vcpu","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"vcpu","sort":4,"group":null}	\N	\N
38	38	directus_fields	1	{"id":1,"collection":"instance_types","field":"category","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"category","sort":5,"group":null}	\N	\N
39	39	directus_fields	6	{"id":6,"collection":"instance_types","field":"memory","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"memory","sort":6,"group":null}	\N	\N
40	40	directus_fields	2	{"id":2,"collection":"instance_types","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"id","sort":1,"group":null}	\N	\N
41	41	directus_fields	3	{"id":3,"collection":"instance_types","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"name","sort":2,"group":null}	\N	\N
42	42	directus_fields	4	{"id":4,"collection":"instance_types","field":"service","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"service","sort":3,"group":null}	\N	\N
43	43	directus_fields	5	{"id":5,"collection":"instance_types","field":"vcpu","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"vcpu","sort":4,"group":null}	\N	\N
44	44	directus_fields	6	{"id":6,"collection":"instance_types","field":"memory","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"memory","sort":5,"group":null}	\N	\N
45	45	directus_fields	1	{"id":1,"collection":"instance_types","field":"category","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"instance_types","field":"category","sort":6,"group":null}	\N	\N
46	51	directus_fields	14	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"prices"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"prices"}	\N	\N
47	52	directus_collections	prices	{"singleton":false,"collection":"prices"}	{"singleton":false,"collection":"prices"}	\N	\N
48	53	directus_fields	15	{"sort":2,"interface":"input","special":null,"collection":"prices","field":"sku"}	{"sort":2,"interface":"input","special":null,"collection":"prices","field":"sku"}	\N	\N
49	54	directus_fields	16	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"prices","field":"service"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"prices","field":"service"}	\N	\N
50	55	directus_fields	17	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"prices","field":"region"}	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"prices","field":"region"}	\N	\N
51	56	directus_fields	18	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"prices","field":"instance_type"}	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"prices","field":"instance_type"}	\N	\N
52	57	directus_fields	19	{"sort":6,"interface":"input","special":null,"collection":"prices","field":"os"}	{"sort":6,"interface":"input","special":null,"collection":"prices","field":"os"}	\N	\N
53	58	directus_fields	20	{"sort":7,"interface":"input","special":null,"options":{"min":0},"collection":"prices","field":"price_per_unit"}	{"sort":7,"interface":"input","special":null,"options":{"min":0},"collection":"prices","field":"price_per_unit"}	\N	\N
54	59	directus_fields	21	{"sort":8,"interface":"datetime","special":null,"collection":"prices","field":"created_at"}	{"sort":8,"interface":"datetime","special":null,"collection":"prices","field":"created_at"}	\N	\N
55	60	directus_fields	22	{"sort":9,"interface":"datetime","special":null,"collection":"prices","field":"updated_at"}	{"sort":9,"interface":"datetime","special":null,"collection":"prices","field":"updated_at"}	\N	\N
56	61	directus_fields	23	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulations"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"simulations"}	\N	\N
57	62	directus_collections	simulations	{"singleton":false,"collection":"simulations"}	{"singleton":false,"collection":"simulations"}	\N	\N
58	63	directus_fields	24	{"sort":2,"interface":"input","special":null,"collection":"simulations","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"simulations","field":"name"}	\N	\N
59	64	directus_fields	25	{"sort":3,"interface":"input","special":null,"collection":"simulations","field":"description"}	{"sort":3,"interface":"input","special":null,"collection":"simulations","field":"description"}	\N	\N
60	65	directus_fields	26	{"sort":4,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"draft","value":"draft","icon":"draft_orders"},{"text":"active","value":"active","icon":"notifications_active"},{"text":"archived","value":"archived","icon":"archive"}]},"collection":"simulations","field":"status"}	{"sort":4,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"draft","value":"draft","icon":"draft_orders"},{"text":"active","value":"active","icon":"notifications_active"},{"text":"archived","value":"archived","icon":"archive"}]},"collection":"simulations","field":"status"}	\N	\N
61	66	directus_fields	27	{"sort":5,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"current","value":"current"},{"text":"proposed","value":"proposed"},{"text":"optimized","value":"optimized"}]},"collection":"simulations","field":"scenario_type"}	{"sort":5,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"current","value":"current"},{"text":"proposed","value":"proposed"},{"text":"optimized","value":"optimized"}]},"collection":"simulations","field":"scenario_type"}	\N	\N
62	67	directus_fields	28	{"sort":6,"interface":"input","special":null,"collection":"simulations","field":"monthly_coast"}	{"sort":6,"interface":"input","special":null,"collection":"simulations","field":"monthly_coast"}	\N	\N
63	68	directus_fields	29	{"sort":7,"interface":"datetime","special":null,"collection":"simulations","field":"created_at"}	{"sort":7,"interface":"datetime","special":null,"collection":"simulations","field":"created_at"}	\N	\N
64	69	directus_fields	30	{"sort":8,"interface":"datetime","special":null,"collection":"simulations","field":"updated_at"}	{"sort":8,"interface":"datetime","special":null,"collection":"simulations","field":"updated_at"}	\N	\N
65	70	directus_fields	31	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"resources"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"resources"}	\N	\N
66	71	directus_collections	resources	{"singleton":false,"collection":"resources"}	{"singleton":false,"collection":"resources"}	\N	\N
67	72	directus_fields	32	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation_id"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation_id"}	\N	\N
68	73	directus_fields	33	{"sort":3,"interface":"input","special":null,"collection":"resources","field":"resource_name"}	{"sort":3,"interface":"input","special":null,"collection":"resources","field":"resource_name"}	\N	\N
69	74	directus_fields	34	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"service"}	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"service"}	\N	\N
70	75	directus_fields	35	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"region"}	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"region"}	\N	\N
71	76	directus_fields	36	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"instance_type"}	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"instance_type"}	\N	\N
72	77	directus_fields	37	{"sort":7,"interface":"input","special":null,"collection":"resources","field":"configuration"}	{"sort":7,"interface":"input","special":null,"collection":"resources","field":"configuration"}	\N	\N
73	79	directus_fields	38	{"sort":7,"interface":"input-code","special":["cast-json"],"options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"collection":"resources","field":"configuration"}	{"sort":7,"interface":"input-code","special":["cast-json"],"options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"collection":"resources","field":"configuration"}	\N	\N
74	80	directus_fields	39	{"sort":8,"interface":"input","special":null,"collection":"resources","field":"unit_price"}	{"sort":8,"interface":"input","special":null,"collection":"resources","field":"unit_price"}	\N	\N
75	81	directus_fields	40	{"sort":9,"interface":"input","special":null,"collection":"resources","field":"monthly_cost"}	{"sort":9,"interface":"input","special":null,"collection":"resources","field":"monthly_cost"}	\N	\N
76	82	directus_fields	41	{"sort":10,"interface":"datetime","special":null,"collection":"resources","field":"created_at"}	{"sort":10,"interface":"datetime","special":null,"collection":"resources","field":"created_at"}	\N	\N
77	83	directus_fields	42	{"sort":11,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation"}	{"sort":11,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation"}	\N	\N
78	84	directus_fields	43	{"sort":12,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"services"}	{"sort":12,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"services"}	\N	\N
79	86	directus_fields	44	{"sort":13,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulations"}	{"sort":13,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulations"}	\N	\N
80	87	directus_fields	31	{"id":31,"collection":"resources","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"id","sort":1,"group":null}	\N	\N
81	88	directus_fields	32	{"id":32,"collection":"resources","field":"simulation_id","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulation_id","sort":2,"group":null}	\N	\N
82	89	directus_fields	33	{"id":33,"collection":"resources","field":"resource_name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"resource_name","sort":3,"group":null}	\N	\N
83	90	directus_fields	34	{"id":34,"collection":"resources","field":"service","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"service","sort":4,"group":null}	\N	\N
84	91	directus_fields	35	{"id":35,"collection":"resources","field":"region","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"region","sort":5,"group":null}	\N	\N
85	92	directus_fields	36	{"id":36,"collection":"resources","field":"instance_type","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_type","sort":6,"group":null}	\N	\N
86	93	directus_fields	38	{"id":38,"collection":"resources","field":"configuration","special":["cast-json"],"interface":"input-code","options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"configuration","sort":7,"group":null}	\N	\N
87	94	directus_fields	39	{"id":39,"collection":"resources","field":"unit_price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"unit_price","sort":8,"group":null}	\N	\N
88	95	directus_fields	40	{"id":40,"collection":"resources","field":"monthly_cost","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"monthly_cost","sort":9,"group":null}	\N	\N
89	96	directus_fields	41	{"id":41,"collection":"resources","field":"created_at","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"created_at","sort":10,"group":null}	\N	\N
90	97	directus_fields	44	{"id":44,"collection":"resources","field":"simulations","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulations","sort":11,"group":null}	\N	\N
91	98	directus_fields	43	{"id":43,"collection":"resources","field":"services","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"services","sort":12,"group":null}	\N	\N
92	99	directus_fields	45	{"sort":13,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"regions"}	{"sort":13,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"regions"}	\N	\N
93	100	directus_fields	46	{"sort":14,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"instance_types"}	{"sort":14,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"instance_types"}	\N	\N
94	101	directus_fields	47	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
95	103	directus_fields	48	{"sort":9,"interface":"list-o2m","special":["o2m"],"options":{"sort":null},"collection":"simulations","field":"ressources"}	{"sort":9,"interface":"list-o2m","special":["o2m"],"options":{"sort":null},"collection":"simulations","field":"ressources"}	\N	\N
96	104	simulations	1	{"name":"Architecture actuelle","description":"Infrastructure de production actuelle","status":"active","scenario_type":"current","monthly_coast":"0","created_at":"2025-10-01T12:00:00"}	{"name":"Architecture actuelle","description":"Infrastructure de production actuelle","status":"active","scenario_type":"current","monthly_coast":"0","created_at":"2025-10-01T12:00:00"}	\N	\N
97	105	resources	1	{"simulation_id":1,"resource_name":"Production Web Servers","service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.0832","monthly_cost":"182.19","created_at":"2025-10-01T12:00:00"}	{"simulation_id":1,"resource_name":"Production Web Servers","service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.0832","monthly_cost":"182.19","created_at":"2025-10-01T12:00:00"}	\N	\N
98	106	directus_fields	49	{"sort":15,"interface":"input","special":null,"collection":"resources","field":"os"}	{"sort":15,"interface":"input","special":null,"collection":"resources","field":"os"}	\N	\N
99	107	resources	1	{"id":1,"simulation_id":1,"resource_name":"Production Web Servers","service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"182.19000","created_at":"2025-10-01T12:00:00","services":null,"simulations":null,"regions":null,"instance_types":null,"os":"Linux"}	{"os":"Linux"}	\N	\N
100	108	resources	2	{"simulation_id":1,"resource_name":"Production Web Servers 2","service":1,"region":19,"instance_type":3,"configuration":{"quantity":4,"hours_per_month":630,"os":"Linux"},"os":"Linux","unit_price":"0.0220","monthly_cost":"55.44","created_at":"2025-10-01T23:54:00"}	{"simulation_id":1,"resource_name":"Production Web Servers 2","service":1,"region":19,"instance_type":3,"configuration":{"quantity":4,"hours_per_month":630,"os":"Linux"},"os":"Linux","unit_price":"0.0220","monthly_cost":"55.44","created_at":"2025-10-01T23:54:00"}	\N	\N
101	110	resources	3	{"simulation_id":1,"resource_name":"Production Web Servers 3","service":1,"region":29,"instance_type":4,"configuration":{"quantity":5,"hours_per_month":830,"os":"Linux"},"unit_price":"0.0832","monthly_cost":"345.28","created_at":"2025-10-01T23:56:00"}	{"simulation_id":1,"resource_name":"Production Web Servers 3","service":1,"region":29,"instance_type":4,"configuration":{"quantity":5,"hours_per_month":830,"os":"Linux"},"unit_price":"0.0832","monthly_cost":"345.28","created_at":"2025-10-01T23:56:00"}	\N	\N
102	112	directus_fields	50	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
103	115	directus_fields	51	{"sort":15,"interface":"input","special":null,"collection":"resources","field":"resource_name"}	{"sort":15,"interface":"input","special":null,"collection":"resources","field":"resource_name"}	\N	\N
104	116	directus_fields	52	{"sort":16,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation_id"}	{"sort":16,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation_id"}	\N	\N
105	118	directus_fields	53	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
106	119	resources	1	{"id":1,"service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"182.19000","created_at":"2025-10-01T12:00:00","services":null,"simulations":null,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 1","simulation_id":1}	{"resource_name":"Production Web Servers 1","simulation_id":1}	\N	\N
107	120	directus_fields	31	{"id":31,"collection":"resources","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"id","sort":1,"group":null}	\N	\N
108	121	directus_fields	34	{"id":34,"collection":"resources","field":"service","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"service","sort":2,"group":null}	\N	\N
109	122	directus_fields	35	{"id":35,"collection":"resources","field":"region","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"region","sort":3,"group":null}	\N	\N
110	123	directus_fields	36	{"id":36,"collection":"resources","field":"instance_type","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_type","sort":4,"group":null}	\N	\N
111	124	directus_fields	51	{"id":51,"collection":"resources","field":"resource_name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"resource_name","sort":5,"group":null}	\N	\N
238	270	instance_types	40	{"name":"m5d.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	{"name":"m5d.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	\N	\N
239	271	instance_types	41	{"name":"i3en.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"i3en.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
112	125	directus_fields	38	{"id":38,"collection":"resources","field":"configuration","special":["cast-json"],"interface":"input-code","options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"configuration","sort":6,"group":null}	\N	\N
113	126	directus_fields	39	{"id":39,"collection":"resources","field":"unit_price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"unit_price","sort":7,"group":null}	\N	\N
114	127	directus_fields	40	{"id":40,"collection":"resources","field":"monthly_cost","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"monthly_cost","sort":8,"group":null}	\N	\N
115	128	directus_fields	41	{"id":41,"collection":"resources","field":"created_at","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"created_at","sort":9,"group":null}	\N	\N
116	129	directus_fields	44	{"id":44,"collection":"resources","field":"simulations","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulations","sort":10,"group":null}	\N	\N
117	130	directus_fields	43	{"id":43,"collection":"resources","field":"services","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"services","sort":11,"group":null}	\N	\N
118	131	directus_fields	45	{"id":45,"collection":"resources","field":"regions","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"regions","sort":12,"group":null}	\N	\N
119	132	directus_fields	46	{"id":46,"collection":"resources","field":"instance_types","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_types","sort":13,"group":null}	\N	\N
120	133	directus_fields	52	{"id":52,"collection":"resources","field":"simulation_id","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulation_id","sort":14,"group":null}	\N	\N
121	134	directus_fields	51	{"id":51,"collection":"resources","field":"resource_name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"resource_name","sort":1,"group":null}	\N	\N
122	135	directus_fields	31	{"id":31,"collection":"resources","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"id","sort":2,"group":null}	\N	\N
123	136	directus_fields	34	{"id":34,"collection":"resources","field":"service","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"service","sort":3,"group":null}	\N	\N
124	137	directus_fields	35	{"id":35,"collection":"resources","field":"region","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"region","sort":4,"group":null}	\N	\N
125	138	directus_fields	36	{"id":36,"collection":"resources","field":"instance_type","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_type","sort":5,"group":null}	\N	\N
126	139	directus_fields	38	{"id":38,"collection":"resources","field":"configuration","special":["cast-json"],"interface":"input-code","options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"configuration","sort":6,"group":null}	\N	\N
127	140	directus_fields	39	{"id":39,"collection":"resources","field":"unit_price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"unit_price","sort":7,"group":null}	\N	\N
128	141	directus_fields	40	{"id":40,"collection":"resources","field":"monthly_cost","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"monthly_cost","sort":8,"group":null}	\N	\N
129	142	directus_fields	41	{"id":41,"collection":"resources","field":"created_at","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"created_at","sort":9,"group":null}	\N	\N
130	143	directus_fields	44	{"id":44,"collection":"resources","field":"simulations","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulations","sort":10,"group":null}	\N	\N
131	144	directus_fields	43	{"id":43,"collection":"resources","field":"services","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"services","sort":11,"group":null}	\N	\N
132	145	directus_fields	45	{"id":45,"collection":"resources","field":"regions","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"regions","sort":12,"group":null}	\N	\N
133	146	directus_fields	46	{"id":46,"collection":"resources","field":"instance_types","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_types","sort":13,"group":null}	\N	\N
134	147	directus_fields	52	{"id":52,"collection":"resources","field":"simulation_id","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulation_id","sort":14,"group":null}	\N	\N
135	148	directus_fields	51	{"id":51,"collection":"resources","field":"resource_name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"resource_name","sort":1,"group":null}	\N	\N
136	149	directus_fields	31	{"id":31,"collection":"resources","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"id","sort":2,"group":null}	\N	\N
137	150	directus_fields	34	{"id":34,"collection":"resources","field":"service","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"service","sort":3,"group":null}	\N	\N
138	151	directus_fields	35	{"id":35,"collection":"resources","field":"region","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"region","sort":4,"group":null}	\N	\N
139	152	directus_fields	36	{"id":36,"collection":"resources","field":"instance_type","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_type","sort":5,"group":null}	\N	\N
140	153	directus_fields	38	{"id":38,"collection":"resources","field":"configuration","special":["cast-json"],"interface":"input-code","options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"configuration","sort":6,"group":null}	\N	\N
141	154	directus_fields	39	{"id":39,"collection":"resources","field":"unit_price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"unit_price","sort":7,"group":null}	\N	\N
142	155	directus_fields	52	{"id":52,"collection":"resources","field":"simulation_id","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulation_id","sort":8,"group":null}	\N	\N
143	156	directus_fields	40	{"id":40,"collection":"resources","field":"monthly_cost","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"monthly_cost","sort":9,"group":null}	\N	\N
144	157	directus_fields	41	{"id":41,"collection":"resources","field":"created_at","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"created_at","sort":10,"group":null}	\N	\N
145	158	directus_fields	44	{"id":44,"collection":"resources","field":"simulations","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulations","sort":11,"group":null}	\N	\N
146	159	directus_fields	43	{"id":43,"collection":"resources","field":"services","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"services","sort":12,"group":null}	\N	\N
147	160	directus_fields	45	{"id":45,"collection":"resources","field":"regions","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"regions","sort":13,"group":null}	\N	\N
148	161	directus_fields	46	{"id":46,"collection":"resources","field":"instance_types","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_types","sort":14,"group":null}	\N	\N
149	162	directus_fields	51	{"id":51,"collection":"resources","field":"resource_name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"resource_name","sort":1,"group":null}	\N	\N
150	163	directus_fields	31	{"id":31,"collection":"resources","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"id","sort":2,"group":null}	\N	\N
151	164	directus_fields	52	{"id":52,"collection":"resources","field":"simulation_id","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulation_id","sort":3,"group":null}	\N	\N
152	165	directus_fields	34	{"id":34,"collection":"resources","field":"service","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"service","sort":4,"group":null}	\N	\N
153	166	directus_fields	35	{"id":35,"collection":"resources","field":"region","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"region","sort":5,"group":null}	\N	\N
154	167	directus_fields	36	{"id":36,"collection":"resources","field":"instance_type","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_type","sort":6,"group":null}	\N	\N
155	168	directus_fields	38	{"id":38,"collection":"resources","field":"configuration","special":["cast-json"],"interface":"input-code","options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"configuration","sort":7,"group":null}	\N	\N
156	169	directus_fields	39	{"id":39,"collection":"resources","field":"unit_price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"unit_price","sort":8,"group":null}	\N	\N
157	170	directus_fields	40	{"id":40,"collection":"resources","field":"monthly_cost","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"monthly_cost","sort":9,"group":null}	\N	\N
158	171	directus_fields	41	{"id":41,"collection":"resources","field":"created_at","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"created_at","sort":10,"group":null}	\N	\N
159	172	directus_fields	44	{"id":44,"collection":"resources","field":"simulations","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulations","sort":11,"group":null}	\N	\N
160	173	directus_fields	43	{"id":43,"collection":"resources","field":"services","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"services","sort":12,"group":null}	\N	\N
161	174	directus_fields	45	{"id":45,"collection":"resources","field":"regions","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"regions","sort":13,"group":null}	\N	\N
162	175	directus_fields	46	{"id":46,"collection":"resources","field":"instance_types","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_types","sort":14,"group":null}	\N	\N
163	176	directus_fields	51	{"id":51,"collection":"resources","field":"resource_name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"resource_name","sort":1,"group":null}	\N	\N
164	177	directus_fields	52	{"id":52,"collection":"resources","field":"simulation_id","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulation_id","sort":2,"group":null}	\N	\N
165	178	directus_fields	31	{"id":31,"collection":"resources","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"id","sort":3,"group":null}	\N	\N
166	179	directus_fields	34	{"id":34,"collection":"resources","field":"service","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"service","sort":4,"group":null}	\N	\N
167	180	directus_fields	35	{"id":35,"collection":"resources","field":"region","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"region","sort":5,"group":null}	\N	\N
168	181	directus_fields	36	{"id":36,"collection":"resources","field":"instance_type","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_type","sort":6,"group":null}	\N	\N
169	182	directus_fields	38	{"id":38,"collection":"resources","field":"configuration","special":["cast-json"],"interface":"input-code","options":{"template":"{\\n\\"quantity\\": 3,\\n\\"hours_per_month\\": 730,\\n\\"storage_gb\\": 500,\\n\\"os\\": \\"Linux\\"\\n}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"configuration","sort":7,"group":null}	\N	\N
170	183	directus_fields	39	{"id":39,"collection":"resources","field":"unit_price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"unit_price","sort":8,"group":null}	\N	\N
171	184	directus_fields	40	{"id":40,"collection":"resources","field":"monthly_cost","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"monthly_cost","sort":9,"group":null}	\N	\N
172	185	directus_fields	41	{"id":41,"collection":"resources","field":"created_at","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"created_at","sort":10,"group":null}	\N	\N
173	186	directus_fields	44	{"id":44,"collection":"resources","field":"simulations","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"simulations","sort":11,"group":null}	\N	\N
174	187	directus_fields	43	{"id":43,"collection":"resources","field":"services","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"services","sort":12,"group":null}	\N	\N
175	188	directus_fields	45	{"id":45,"collection":"resources","field":"regions","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"regions","sort":13,"group":null}	\N	\N
176	189	directus_fields	46	{"id":46,"collection":"resources","field":"instance_types","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"resources","field":"instance_types","sort":14,"group":null}	\N	\N
398	470	directus_collections	recommendations	{"singleton":false,"collection":"recommendations"}	{"singleton":false,"collection":"recommendations"}	\N	\N
401	473	directus_fields	67	{"sort":4,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"cost_optimization","value":"cost_optimization"}]},"collection":"recommendations","field":"type"}	{"sort":4,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"cost_optimization","value":"cost_optimization"}]},"collection":"recommendations","field":"type"}	\N	\N
402	474	directus_fields	67	{"id":67,"collection":"recommendations","field":"type","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"cost_optimization","value":"cost_optimization"},{"text":"performance","value":"performance"},{"text":"security","value":"security"}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"recommendations","field":"type","options":{"choices":[{"text":"cost_optimization","value":"cost_optimization"},{"text":"performance","value":"performance"},{"text":"security","value":"security"}]}}	\N	\N
177	190	resources	2	{"id":2,"service":1,"region":19,"instance_type":3,"configuration":{"quantity":4,"hours_per_month":630,"os":"Linux"},"unit_price":"0.02200","monthly_cost":"55.44000","created_at":"2025-10-01T23:54:00","services":null,"simulations":null,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 2","simulation_id":1}	{"resource_name":"Production Web Servers 2","simulation_id":1}	\N	\N
178	191	resources	3	{"id":3,"service":1,"region":29,"instance_type":4,"configuration":{"quantity":5,"hours_per_month":830,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"345.28000","created_at":"2025-10-01T23:56:00","services":null,"simulations":null,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 3","simulation_id":1}	{"resource_name":"Production Web Servers 3","simulation_id":1}	\N	\N
179	193	directus_fields	54	{"sort":9,"interface":"list-o2m-tree-view","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m-tree-view","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
180	195	directus_fields	55	{"sort":15,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation_id"}	{"sort":15,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulation_id"}	\N	\N
181	197	directus_fields	56	{"sort":9,"interface":"list-o2m-tree-view","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m-tree-view","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
182	198	resources	1	{"id":1,"service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"182.19000","created_at":"2025-10-01T12:00:00","services":null,"simulations":1,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 1","simulation_id":null}	{"simulations":1}	\N	\N
183	199	resources	2	{"id":2,"service":1,"region":19,"instance_type":3,"configuration":{"quantity":4,"hours_per_month":630,"os":"Linux"},"unit_price":"0.02200","monthly_cost":"55.44000","created_at":"2025-10-01T23:54:00","services":null,"simulations":1,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 2","simulation_id":null}	{"simulations":1}	\N	\N
184	200	resources	3	{"id":3,"service":1,"region":29,"instance_type":4,"configuration":{"quantity":5,"hours_per_month":830,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"345.28000","created_at":"2025-10-01T23:56:00","services":null,"simulations":1,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 3","simulation_id":null}	{"simulations":1}	\N	\N
185	203	directus_fields	57	{"sort":9,"interface":"list-m2m","special":["m2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-m2m","special":["m2m"],"collection":"simulations","field":"resources"}	\N	\N
186	204	directus_fields	58	{"sort":1,"hidden":true,"field":"id","collection":"simulations_simulations"}	{"sort":1,"hidden":true,"field":"id","collection":"simulations_simulations"}	\N	\N
187	205	directus_collections	simulations_simulations	{"hidden":true,"icon":"import_export","collection":"simulations_simulations"}	{"hidden":true,"icon":"import_export","collection":"simulations_simulations"}	\N	\N
188	206	directus_fields	59	{"sort":2,"hidden":true,"collection":"simulations_simulations","field":"simulations_id"}	{"sort":2,"hidden":true,"collection":"simulations_simulations","field":"simulations_id"}	\N	\N
189	207	directus_fields	60	{"sort":3,"hidden":true,"collection":"simulations_simulations","field":"related_simulations_id"}	{"sort":3,"hidden":true,"collection":"simulations_simulations","field":"related_simulations_id"}	\N	\N
190	209	directus_fields	61	{"sort":15,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulations_id"}	{"sort":15,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"resources","field":"simulations_id"}	\N	\N
191	210	directus_fields	62	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
192	211	resources	1	{"id":1,"service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"182.19000","created_at":"2025-10-01T12:00:00","services":null,"simulations":1,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 1","simulations_id":1}	{"simulations_id":1}	\N	\N
193	212	resources	2	{"id":2,"service":1,"region":19,"instance_type":3,"configuration":{"quantity":4,"hours_per_month":630,"os":"Linux"},"unit_price":"0.02200","monthly_cost":"55.44000","created_at":"2025-10-01T23:54:00","services":null,"simulations":1,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 2","simulations_id":1}	{"simulations_id":1}	\N	\N
194	213	resources	3	{"id":3,"service":1,"region":29,"instance_type":4,"configuration":{"quantity":5,"hours_per_month":830,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"345.28000","created_at":"2025-10-01T23:56:00","services":null,"simulations":1,"regions":null,"instance_types":null,"resource_name":"Production Web Servers 3","simulations_id":1}	{"simulations_id":1}	\N	\N
195	214	directus_fields	62	{"id":62,"collection":"simulations","field":"resources","special":["o2m"],"interface":"list-o2m","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"simulations","field":"resources","hidden":true}	\N	\N
196	215	directus_fields	62	{"id":62,"collection":"simulations","field":"resources","special":["o2m"],"interface":"list-o2m","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"simulations","field":"resources","hidden":false}	\N	\N
197	216	directus_fields	62	{"id":62,"collection":"simulations","field":"resources","special":["o2m"],"interface":"list-o2m","options":null,"display":"related-values","display_options":{"template":"{{service}}{{region}}"},"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"simulations","field":"resources","display":"related-values","display_options":{"template":"{{service}}{{region}}"}}	\N	\N
198	217	directus_fields	62	{"id":62,"collection":"simulations","field":"resources","special":["o2m"],"interface":"list-o2m","options":{"template":"{{service}}"},"display":"related-values","display_options":{"template":"{{service}}{{region}}"},"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"simulations","field":"resources","options":{"template":"{{service}}"}}	\N	\N
240	272	instance_types	42	{"name":"r6i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	{"name":"r6i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	\N	\N
199	218	directus_fields	62	{"id":62,"collection":"simulations","field":"resources","special":["o2m"],"interface":"list-o2m","options":{"template":"{{service}}"},"display":"related-values","display_options":{"template":null},"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"simulations","field":"resources","display_options":{"template":null}}	\N	\N
200	219	directus_fields	62	{"id":62,"collection":"simulations","field":"resources","special":["o2m"],"interface":"list-o2m","options":{"template":null},"display":"related-values","display_options":{"template":null},"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"simulations","field":"resources","options":{"template":null}}	\N	\N
202	226	directus_fields	63	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	{"sort":9,"interface":"list-o2m","special":["o2m"],"collection":"simulations","field":"resources"}	\N	\N
203	227	resources	1	{"id":1,"service":1,"region":11,"instance_type":2,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"182.19000","created_at":"2025-10-01T12:00:00","services":3,"simulations":1,"regions":17,"instance_types":2,"resource_name":"Production Web Servers 1","simulations_id":1}	{"services":3,"regions":17,"instance_types":2}	\N	\N
204	236	instance_types	6	{"name":"x2idn.metal","service":7,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.metal","service":7,"vcpu":"128","memory":"2048 GiB"}	\N	\N
205	237	instance_types	7	{"name":"c5d.metal","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.metal","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
206	238	instance_types	8	{"name":"c5d.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
207	239	instance_types	9	{"name":"r5dn.12xlarge","service":7,"vcpu":"48","memory":"384 GiB"}	{"name":"r5dn.12xlarge","service":7,"vcpu":"48","memory":"384 GiB"}	\N	\N
208	240	instance_types	10	{"name":"m6i.large","service":7,"vcpu":"2","memory":"8 GiB"}	{"name":"m6i.large","service":7,"vcpu":"2","memory":"8 GiB"}	\N	\N
209	241	instance_types	11	{"name":"m5.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	{"name":"m5.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	\N	\N
210	242	instance_types	12	{"name":"m6i.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	{"name":"m6i.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	\N	\N
211	243	instance_types	13	{"name":"c6g.metal","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c6g.metal","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
212	244	instance_types	14	{"name":"d2.8xlarge","service":7,"vcpu":"36","memory":"244 GiB"}	{"name":"d2.8xlarge","service":7,"vcpu":"36","memory":"244 GiB"}	\N	\N
213	245	instance_types	15	{"name":"i4i.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"i4i.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
214	246	instance_types	16	{"name":"c6in.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c6in.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
215	247	instance_types	17	{"name":"i3en.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"i3en.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
216	248	instance_types	18	{"name":"c6i.32xlarge","service":7,"vcpu":"128","memory":"256 GiB"}	{"name":"c6i.32xlarge","service":7,"vcpu":"128","memory":"256 GiB"}	\N	\N
217	249	instance_types	19	{"name":"r5dn.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"r5dn.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
218	250	instance_types	20	{"name":"c6in.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	{"name":"c6in.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	\N	\N
219	251	instance_types	21	{"name":"c5a.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	{"name":"c5a.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	\N	\N
220	252	instance_types	22	{"name":"inf1.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"inf1.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
221	253	instance_types	23	{"name":"r5dn.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	{"name":"r5dn.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	\N	\N
222	254	instance_types	24	{"name":"x2idn.32xlarge","service":7,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.32xlarge","service":7,"vcpu":"128","memory":"2048 GiB"}	\N	\N
223	255	instance_types	25	{"name":"u-6tb1.112xlarge","service":7,"vcpu":"448","memory":"6144 GiB"}	{"name":"u-6tb1.112xlarge","service":7,"vcpu":"448","memory":"6144 GiB"}	\N	\N
224	256	instance_types	26	{"name":"c6in.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	{"name":"c6in.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	\N	\N
225	257	instance_types	27	{"name":"i3en.metal","service":7,"vcpu":"96","memory":"768 GiB"}	{"name":"i3en.metal","service":7,"vcpu":"96","memory":"768 GiB"}	\N	\N
226	258	instance_types	28	{"name":"c6g.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	{"name":"c6g.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	\N	\N
227	259	instance_types	29	{"name":"i4i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	{"name":"i4i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	\N	\N
228	260	instance_types	30	{"name":"r5n.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	{"name":"r5n.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	\N	\N
229	261	instance_types	31	{"name":"m5d.2xlarge","service":7,"vcpu":"8","memory":"32 GiB"}	{"name":"m5d.2xlarge","service":7,"vcpu":"8","memory":"32 GiB"}	\N	\N
230	262	instance_types	32	{"name":"c6i.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c6i.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
231	263	instance_types	33	{"name":"r5dn.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	{"name":"r5dn.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	\N	\N
232	264	instance_types	34	{"name":"c5a.4xlarge","service":7,"vcpu":"16","memory":"32 GiB"}	{"name":"c5a.4xlarge","service":7,"vcpu":"16","memory":"32 GiB"}	\N	\N
233	265	instance_types	35	{"name":"m6g.large","service":7,"vcpu":"2","memory":"8 GiB"}	{"name":"m6g.large","service":7,"vcpu":"2","memory":"8 GiB"}	\N	\N
234	266	instance_types	36	{"name":"c5a.large","service":7,"vcpu":"2","memory":"4 GiB"}	{"name":"c5a.large","service":7,"vcpu":"2","memory":"4 GiB"}	\N	\N
235	267	instance_types	37	{"name":"r5dn.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	{"name":"r5dn.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	\N	\N
236	268	instance_types	38	{"name":"i4i.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"i4i.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
237	269	instance_types	39	{"name":"c5.metal","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c5.metal","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
241	273	instance_types	43	{"name":"m5.12xlarge","service":7,"vcpu":"48","memory":"192 GiB"}	{"name":"m5.12xlarge","service":7,"vcpu":"48","memory":"192 GiB"}	\N	\N
242	274	instance_types	44	{"name":"x1.32xlarge","service":7,"vcpu":"128","memory":"1952 GiB"}	{"name":"x1.32xlarge","service":7,"vcpu":"128","memory":"1952 GiB"}	\N	\N
243	314	instance_types	45	{"name":"x2idn.metal","service":7,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.metal","service":7,"vcpu":"128","memory":"2048 GiB"}	\N	\N
244	315	prices	1	{"sku":"ASAJBV2BNW4TK2AC","service":7,"region":15,"instance_type":45,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"ASAJBV2BNW4TK2AC","service":7,"region":15,"instance_type":45,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
245	316	instance_types	46	{"name":"c5d.metal","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.metal","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
246	317	prices	2	{"sku":"2MJHSZ8K32A878HY","service":7,"region":15,"instance_type":46,"os":"Windows","price_per_unit":4.416,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"2MJHSZ8K32A878HY","service":7,"region":15,"instance_type":46,"os":"Windows","price_per_unit":4.416,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
247	318	instance_types	47	{"name":"c5d.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
248	319	prices	3	{"sku":"MQRX2N7GEX3K5BPR","service":7,"region":15,"instance_type":47,"os":"RHEL","price_per_unit":7.277,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"MQRX2N7GEX3K5BPR","service":7,"region":15,"instance_type":47,"os":"RHEL","price_per_unit":7.277,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
249	320	instance_types	48	{"name":"r5dn.12xlarge","service":7,"vcpu":"48","memory":"384 GiB"}	{"name":"r5dn.12xlarge","service":7,"vcpu":"48","memory":"384 GiB"}	\N	\N
250	321	prices	4	{"sku":"JJC7VV7EUWNQ7U7V","service":7,"region":15,"instance_type":48,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"JJC7VV7EUWNQ7U7V","service":7,"region":15,"instance_type":48,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
251	322	instance_types	49	{"name":"m6i.large","service":7,"vcpu":"2","memory":"8 GiB"}	{"name":"m6i.large","service":7,"vcpu":"2","memory":"8 GiB"}	\N	\N
252	323	prices	5	{"sku":"4Y3K6MNSSJUDKTS2","service":7,"region":15,"instance_type":49,"os":"Windows","price_per_unit":0.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"4Y3K6MNSSJUDKTS2","service":7,"region":15,"instance_type":49,"os":"Windows","price_per_unit":0.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
253	324	instance_types	50	{"name":"m5.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	{"name":"m5.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	\N	\N
254	325	prices	6	{"sku":"CMBYZZ3KTUNXB2MQ","service":7,"region":15,"instance_type":50,"os":"Linux","price_per_unit":0.322,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"CMBYZZ3KTUNXB2MQ","service":7,"region":15,"instance_type":50,"os":"Linux","price_per_unit":0.322,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
255	326	instance_types	51	{"name":"m6i.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	{"name":"m6i.xlarge","service":7,"vcpu":"4","memory":"16 GiB"}	\N	\N
256	327	prices	7	{"sku":"CS2EAT4BBKX282YT","service":7,"region":15,"instance_type":51,"os":"Ubuntu Pro","price_per_unit":0.261,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"CS2EAT4BBKX282YT","service":7,"region":15,"instance_type":51,"os":"Ubuntu Pro","price_per_unit":0.261,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
257	328	instance_types	52	{"name":"c6g.metal","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c6g.metal","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
258	329	prices	8	{"sku":"EUNMXQYZDDD3SU8N","service":7,"region":15,"instance_type":52,"os":"SUSE","price_per_unit":3.0434,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"EUNMXQYZDDD3SU8N","service":7,"region":15,"instance_type":52,"os":"SUSE","price_per_unit":3.0434,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
259	330	prices	9	{"sku":"2KKVCKPSRZ69KDT8","service":7,"region":15,"instance_type":46,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"2KKVCKPSRZ69KDT8","service":7,"region":15,"instance_type":46,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
260	331	instance_types	53	{"name":"d2.8xlarge","service":7,"vcpu":"36","memory":"244 GiB"}	{"name":"d2.8xlarge","service":7,"vcpu":"36","memory":"244 GiB"}	\N	\N
261	332	prices	10	{"sku":"BBSEDDW6NBJA7BKC","service":7,"region":15,"instance_type":53,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"BBSEDDW6NBJA7BKC","service":7,"region":15,"instance_type":53,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
262	333	instance_types	54	{"name":"i4i.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"i4i.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
263	334	prices	11	{"sku":"F4T76YYBGENXKG25","service":7,"region":15,"instance_type":54,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"F4T76YYBGENXKG25","service":7,"region":15,"instance_type":54,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
264	335	instance_types	55	{"name":"c6in.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c6in.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
265	336	prices	12	{"sku":"ZDF83CTQAU8SE5XQ","service":7,"region":15,"instance_type":55,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"ZDF83CTQAU8SE5XQ","service":7,"region":15,"instance_type":55,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
266	337	instance_types	56	{"name":"i3en.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"i3en.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
267	338	prices	13	{"sku":"2RZRZY3PKHFCV2UU","service":7,"region":15,"instance_type":56,"os":"Linux","price_per_unit":0.365,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"2RZRZY3PKHFCV2UU","service":7,"region":15,"instance_type":56,"os":"Linux","price_per_unit":0.365,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
268	339	instance_types	57	{"name":"c6i.32xlarge","service":7,"vcpu":"128","memory":"256 GiB"}	{"name":"c6i.32xlarge","service":7,"vcpu":"128","memory":"256 GiB"}	\N	\N
269	340	prices	14	{"sku":"D5JZ2YUV4KKDHT2T","service":7,"region":15,"instance_type":57,"os":"Windows","price_per_unit":13.184,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"D5JZ2YUV4KKDHT2T","service":7,"region":15,"instance_type":57,"os":"Windows","price_per_unit":13.184,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
270	341	instance_types	58	{"name":"r5dn.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"r5dn.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
271	342	prices	15	{"sku":"ZAPMFFJKRJU3R5CF","service":7,"region":15,"instance_type":58,"os":"Linux","price_per_unit":0.2886,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"ZAPMFFJKRJU3R5CF","service":7,"region":15,"instance_type":58,"os":"Linux","price_per_unit":0.2886,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
272	343	instance_types	59	{"name":"c6in.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	{"name":"c6in.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	\N	\N
273	344	prices	16	{"sku":"MQSEQKYJG3J7XAJA","service":7,"region":15,"instance_type":59,"os":"Windows","price_per_unit":0.48892,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"MQSEQKYJG3J7XAJA","service":7,"region":15,"instance_type":59,"os":"Windows","price_per_unit":0.48892,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
274	345	instance_types	60	{"name":"c5a.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	{"name":"c5a.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	\N	\N
275	346	prices	17	{"sku":"K3SMWU6AY3HECJDP","service":7,"region":15,"instance_type":60,"os":"Linux","price_per_unit":8.479,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"K3SMWU6AY3HECJDP","service":7,"region":15,"instance_type":60,"os":"Linux","price_per_unit":8.479,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
276	347	instance_types	61	{"name":"inf1.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"inf1.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
277	348	prices	18	{"sku":"46XDJYY2FHPQK86E","service":7,"region":15,"instance_type":61,"os":"Linux","price_per_unit":6.249,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	{"sku":"46XDJYY2FHPQK86E","service":7,"region":15,"instance_type":61,"os":"Linux","price_per_unit":6.249,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:44"}	\N	\N
278	349	instance_types	62	{"name":"r5dn.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	{"name":"r5dn.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	\N	\N
279	350	prices	19	{"sku":"DCCMGMP4QWH42S22","service":7,"region":15,"instance_type":62,"os":"Windows","price_per_unit":0.442,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"DCCMGMP4QWH42S22","service":7,"region":15,"instance_type":62,"os":"Windows","price_per_unit":0.442,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
280	351	instance_types	63	{"name":"x2idn.32xlarge","service":7,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.32xlarge","service":7,"vcpu":"128","memory":"2048 GiB"}	\N	\N
281	352	prices	20	{"sku":"M24YR38EZ3RCKNV6","service":7,"region":15,"instance_type":63,"os":"Windows","price_per_unit":40.296,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"M24YR38EZ3RCKNV6","service":7,"region":15,"instance_type":63,"os":"Windows","price_per_unit":40.296,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
282	353	instance_types	64	{"name":"u-6tb1.112xlarge","service":7,"vcpu":"448","memory":"6144 GiB"}	{"name":"u-6tb1.112xlarge","service":7,"vcpu":"448","memory":"6144 GiB"}	\N	\N
283	354	prices	21	{"sku":"M226ANPSW5N2ZUUA","service":7,"region":15,"instance_type":64,"os":"RHEL","price_per_unit":77.0098,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"M226ANPSW5N2ZUUA","service":7,"region":15,"instance_type":64,"os":"RHEL","price_per_unit":77.0098,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
284	355	instance_types	65	{"name":"c6in.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	{"name":"c6in.12xlarge","service":7,"vcpu":"48","memory":"96 GiB"}	\N	\N
285	356	prices	22	{"sku":"F4VQX8TVBFBDJT8F","service":7,"region":15,"instance_type":65,"os":"Linux","price_per_unit":3.65904,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"F4VQX8TVBFBDJT8F","service":7,"region":15,"instance_type":65,"os":"Linux","price_per_unit":3.65904,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
286	357	instance_types	66	{"name":"i3en.metal","service":7,"vcpu":"96","memory":"768 GiB"}	{"name":"i3en.metal","service":7,"vcpu":"96","memory":"768 GiB"}	\N	\N
287	358	prices	23	{"sku":"EY7WB9D3MPP74S3V","service":7,"region":15,"instance_type":66,"os":"Linux","price_per_unit":14.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"EY7WB9D3MPP74S3V","service":7,"region":15,"instance_type":66,"os":"Linux","price_per_unit":14.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
288	359	instance_types	67	{"name":"c6g.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	{"name":"c6g.xlarge","service":7,"vcpu":"4","memory":"8 GiB"}	\N	\N
289	360	prices	24	{"sku":"SKQ7V8BYARK8QPWC","service":7,"region":15,"instance_type":67,"os":"SUSE","price_per_unit":0.2496,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"SKQ7V8BYARK8QPWC","service":7,"region":15,"instance_type":67,"os":"SUSE","price_per_unit":0.2496,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
290	361	instance_types	68	{"name":"i4i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	{"name":"i4i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	\N	\N
291	362	prices	25	{"sku":"VUJWJ43YRA549PU4","service":7,"region":15,"instance_type":68,"os":"Ubuntu Pro","price_per_unit":14.656,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"VUJWJ43YRA549PU4","service":7,"region":15,"instance_type":68,"os":"Ubuntu Pro","price_per_unit":14.656,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
292	363	instance_types	69	{"name":"r5n.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	{"name":"r5n.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	\N	\N
293	364	prices	26	{"sku":"5AP4B6TES68GAMNF","service":7,"region":15,"instance_type":69,"os":"SUSE","price_per_unit":3.304,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"5AP4B6TES68GAMNF","service":7,"region":15,"instance_type":69,"os":"SUSE","price_per_unit":3.304,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
294	365	instance_types	70	{"name":"m5d.2xlarge","service":7,"vcpu":"8","memory":"32 GiB"}	{"name":"m5d.2xlarge","service":7,"vcpu":"8","memory":"32 GiB"}	\N	\N
321	392	prices	41	{"sku":"TTFAMWM9C75AKH8B","service":7,"region":15,"instance_type":70,"os":"Windows","price_per_unit":1.004,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"TTFAMWM9C75AKH8B","service":7,"region":15,"instance_type":70,"os":"Windows","price_per_unit":1.004,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
295	366	prices	27	{"sku":"8MKAA6VT83UZQFP5","service":7,"region":15,"instance_type":70,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"8MKAA6VT83UZQFP5","service":7,"region":15,"instance_type":70,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
296	367	instance_types	71	{"name":"c6i.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c6i.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
297	368	prices	28	{"sku":"73MPNA62D9M89QF4","service":7,"region":15,"instance_type":71,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"73MPNA62D9M89QF4","service":7,"region":15,"instance_type":71,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
298	369	instance_types	72	{"name":"r5dn.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	{"name":"r5dn.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	\N	\N
299	370	prices	29	{"sku":"XW8GAV8E42N3F476","service":7,"region":15,"instance_type":72,"os":"Windows","price_per_unit":17.008,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"XW8GAV8E42N3F476","service":7,"region":15,"instance_type":72,"os":"Windows","price_per_unit":17.008,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
300	371	instance_types	73	{"name":"c5a.4xlarge","service":7,"vcpu":"16","memory":"32 GiB"}	{"name":"c5a.4xlarge","service":7,"vcpu":"16","memory":"32 GiB"}	\N	\N
301	372	prices	30	{"sku":"59VZZCB8WVKHFH9V","service":7,"region":15,"instance_type":73,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"59VZZCB8WVKHFH9V","service":7,"region":15,"instance_type":73,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
302	373	instance_types	74	{"name":"m6g.large","service":7,"vcpu":"2","memory":"8 GiB"}	{"name":"m6g.large","service":7,"vcpu":"2","memory":"8 GiB"}	\N	\N
303	374	prices	31	{"sku":"R38YQE2VV7GA9G7Y","service":7,"region":15,"instance_type":74,"os":"Linux","price_per_unit":0.1016,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"R38YQE2VV7GA9G7Y","service":7,"region":15,"instance_type":74,"os":"Linux","price_per_unit":0.1016,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
304	375	instance_types	75	{"name":"c5a.large","service":7,"vcpu":"2","memory":"4 GiB"}	{"name":"c5a.large","service":7,"vcpu":"2","memory":"4 GiB"}	\N	\N
305	376	prices	32	{"sku":"W8DWGGQKZBVAN92Z","service":7,"region":15,"instance_type":75,"os":"Linux","price_per_unit":0.171,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"W8DWGGQKZBVAN92Z","service":7,"region":15,"instance_type":75,"os":"Linux","price_per_unit":0.171,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
306	377	prices	33	{"sku":"NSBFZXBV9Z632WFE","service":7,"region":15,"instance_type":48,"os":"Linux","price_per_unit":5.62224,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"NSBFZXBV9Z632WFE","service":7,"region":15,"instance_type":48,"os":"Linux","price_per_unit":5.62224,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
307	378	instance_types	76	{"name":"r5dn.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	{"name":"r5dn.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	\N	\N
308	379	prices	34	{"sku":"YR6NWE8T4FCV9YCS","service":7,"region":15,"instance_type":76,"os":"Windows","price_per_unit":11.0976,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"YR6NWE8T4FCV9YCS","service":7,"region":15,"instance_type":76,"os":"Windows","price_per_unit":11.0976,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
309	380	instance_types	77	{"name":"i4i.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"i4i.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
310	381	prices	35	{"sku":"TCUF4AQ6VRAFT3QN","service":7,"region":15,"instance_type":77,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"TCUF4AQ6VRAFT3QN","service":7,"region":15,"instance_type":77,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
311	382	instance_types	78	{"name":"c5.metal","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c5.metal","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
312	383	prices	36	{"sku":"YYG8EUQR4PQSEJDU","service":7,"region":15,"instance_type":78,"os":"Windows","price_per_unit":5.472,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"YYG8EUQR4PQSEJDU","service":7,"region":15,"instance_type":78,"os":"Windows","price_per_unit":5.472,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
313	384	instance_types	79	{"name":"m5d.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	{"name":"m5d.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	\N	\N
314	385	prices	37	{"sku":"UNFU8GZARWXJSEY2","service":7,"region":15,"instance_type":79,"os":"Ubuntu Pro","price_per_unit":2.6,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"UNFU8GZARWXJSEY2","service":7,"region":15,"instance_type":79,"os":"Ubuntu Pro","price_per_unit":2.6,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
315	386	instance_types	80	{"name":"i3en.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"i3en.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
316	387	prices	38	{"sku":"6789AM2FPAFYK6DH","service":7,"region":15,"instance_type":80,"os":"Windows","price_per_unit":1.265,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"6789AM2FPAFYK6DH","service":7,"region":15,"instance_type":80,"os":"Windows","price_per_unit":1.265,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
317	388	instance_types	81	{"name":"r6i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	{"name":"r6i.metal","service":7,"vcpu":"128","memory":"1024 GiB"}	\N	\N
318	389	prices	39	{"sku":"K64RPFBV2R3WU6KM","service":7,"region":15,"instance_type":81,"os":"Linux","price_per_unit":10.752,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"K64RPFBV2R3WU6KM","service":7,"region":15,"instance_type":81,"os":"Linux","price_per_unit":10.752,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
319	390	instance_types	82	{"name":"m5.12xlarge","service":7,"vcpu":"48","memory":"192 GiB"}	{"name":"m5.12xlarge","service":7,"vcpu":"48","memory":"192 GiB"}	\N	\N
320	391	prices	40	{"sku":"7WB5V3H76287EU5S","service":7,"region":15,"instance_type":82,"os":"Windows","price_per_unit":5.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"7WB5V3H76287EU5S","service":7,"region":15,"instance_type":82,"os":"Windows","price_per_unit":5.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
420	492	services	8	{"code":"AmazonEC2","name":"Amazon AmazonEC2"}	{"code":"AmazonEC2","name":"Amazon AmazonEC2"}	\N	\N
322	393	instance_types	83	{"name":"x1.32xlarge","service":7,"vcpu":"128","memory":"1952 GiB"}	{"name":"x1.32xlarge","service":7,"vcpu":"128","memory":"1952 GiB"}	\N	\N
323	394	prices	42	{"sku":"VA5SUTF8FP8N3AXN","service":7,"region":15,"instance_type":83,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"VA5SUTF8FP8N3AXN","service":7,"region":15,"instance_type":83,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
324	395	instance_types	84	{"name":"r7g.medium","service":7,"vcpu":"1","memory":"8 GiB"}	{"name":"r7g.medium","service":7,"vcpu":"1","memory":"8 GiB"}	\N	\N
325	396	prices	43	{"sku":"SAA526WFDWBR8DKJ","service":7,"region":15,"instance_type":84,"os":"Ubuntu Pro","price_per_unit":0.0732,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"SAA526WFDWBR8DKJ","service":7,"region":15,"instance_type":84,"os":"Ubuntu Pro","price_per_unit":0.0732,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
326	397	instance_types	85	{"name":"c6i.4xlarge","service":7,"vcpu":"16","memory":"32 GiB"}	{"name":"c6i.4xlarge","service":7,"vcpu":"16","memory":"32 GiB"}	\N	\N
327	398	prices	44	{"sku":"SRKPZJTPF33QB59X","service":7,"region":15,"instance_type":85,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"SRKPZJTPF33QB59X","service":7,"region":15,"instance_type":85,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
328	399	instance_types	86	{"name":"c6i.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c6i.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
329	400	prices	45	{"sku":"DMK6SQHM6DH8WT5W","service":7,"region":15,"instance_type":86,"os":"SUSE","price_per_unit":5.597,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"DMK6SQHM6DH8WT5W","service":7,"region":15,"instance_type":86,"os":"SUSE","price_per_unit":5.597,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
330	401	instance_types	87	{"name":"m5.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	{"name":"m5.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	\N	\N
331	402	prices	46	{"sku":"XJGBGA7YH2P82QTY","service":7,"region":15,"instance_type":87,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"XJGBGA7YH2P82QTY","service":7,"region":15,"instance_type":87,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
332	403	instance_types	88	{"name":"x1e.4xlarge","service":7,"vcpu":"16","memory":"488 GiB"}	{"name":"x1e.4xlarge","service":7,"vcpu":"16","memory":"488 GiB"}	\N	\N
333	404	prices	47	{"sku":"K5R438HR4MPH2ETV","service":7,"region":15,"instance_type":88,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"K5R438HR4MPH2ETV","service":7,"region":15,"instance_type":88,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
334	405	instance_types	89	{"name":"c6g.2xlarge","service":7,"vcpu":"8","memory":"16 GiB"}	{"name":"c6g.2xlarge","service":7,"vcpu":"8","memory":"16 GiB"}	\N	\N
335	406	prices	48	{"sku":"GGE9SKRP5EH6ACVP","service":7,"region":15,"instance_type":89,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0.62,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"GGE9SKRP5EH6ACVP","service":7,"region":15,"instance_type":89,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0.62,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
336	407	instance_types	90	{"name":"r5d.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	{"name":"r5d.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	\N	\N
337	408	prices	49	{"sku":"224TXKFMK98VD2H8","service":7,"region":15,"instance_type":90,"os":"Ubuntu Pro","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"224TXKFMK98VD2H8","service":7,"region":15,"instance_type":90,"os":"Ubuntu Pro","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
338	409	instance_types	91	{"name":"c6in.large","service":7,"vcpu":"2","memory":"4 GiB"}	{"name":"c6in.large","service":7,"vcpu":"2","memory":"4 GiB"}	\N	\N
339	410	prices	50	{"sku":"N2PWZHQJM7CUE2TC","service":7,"region":15,"instance_type":91,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"N2PWZHQJM7CUE2TC","service":7,"region":15,"instance_type":91,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
340	411	instance_types	92	{"name":"c6in.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	{"name":"c6in.24xlarge","service":7,"vcpu":"96","memory":"192 GiB"}	\N	\N
341	412	prices	51	{"sku":"QBGHQAG9TXN2XRJD","service":7,"region":15,"instance_type":92,"os":"RHEL","price_per_unit":44.35488,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"QBGHQAG9TXN2XRJD","service":7,"region":15,"instance_type":92,"os":"RHEL","price_per_unit":44.35488,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
342	413	instance_types	93	{"name":"r5dn.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"r5dn.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
343	414	prices	52	{"sku":"YMSW32ECA33XM27M","service":7,"region":15,"instance_type":93,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"YMSW32ECA33XM27M","service":7,"region":15,"instance_type":93,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
344	415	instance_types	94	{"name":"r7gd.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"r7gd.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
345	416	prices	53	{"sku":"QP28KQ4KEYYBW6ZG","service":7,"region":15,"instance_type":94,"os":"RHEL","price_per_unit":0.8334,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	{"sku":"QP28KQ4KEYYBW6ZG","service":7,"region":15,"instance_type":94,"os":"RHEL","price_per_unit":0.8334,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:45"}	\N	\N
346	417	instance_types	95	{"name":"r5d.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	{"name":"r5d.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	\N	\N
347	418	prices	54	{"sku":"62BDZCJBE2GU364K","service":7,"region":15,"instance_type":95,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"62BDZCJBE2GU364K","service":7,"region":15,"instance_type":95,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
348	419	instance_types	96	{"name":"c5a.8xlarge","service":7,"vcpu":"32","memory":"64 GiB"}	{"name":"c5a.8xlarge","service":7,"vcpu":"32","memory":"64 GiB"}	\N	\N
349	420	prices	55	{"sku":"AJKXPN4NGVUKNQRT","service":7,"region":15,"instance_type":96,"os":"RHEL","price_per_unit":2.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"AJKXPN4NGVUKNQRT","service":7,"region":15,"instance_type":96,"os":"RHEL","price_per_unit":2.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
350	421	instance_types	97	{"name":"c5.large","service":7,"vcpu":"2","memory":"4 GiB"}	{"name":"c5.large","service":7,"vcpu":"2","memory":"4 GiB"}	\N	\N
351	422	prices	56	{"sku":"D5XUX8VW63W4VRH7","service":7,"region":15,"instance_type":97,"os":"Ubuntu Pro","price_per_unit":0.118,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"D5XUX8VW63W4VRH7","service":7,"region":15,"instance_type":97,"os":"Ubuntu Pro","price_per_unit":0.118,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
352	423	instance_types	98	{"name":"c5a.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	{"name":"c5a.16xlarge","service":7,"vcpu":"64","memory":"128 GiB"}	\N	\N
353	424	prices	57	{"sku":"RF9QAKYUZUBPYKQY","service":7,"region":15,"instance_type":98,"os":"RHEL","price_per_unit":11.667,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"RF9QAKYUZUBPYKQY","service":7,"region":15,"instance_type":98,"os":"RHEL","price_per_unit":11.667,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
354	425	prices	58	{"sku":"PRFRZD5R8C7ZVWK3","service":7,"region":15,"instance_type":51,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"PRFRZD5R8C7ZVWK3","service":7,"region":15,"instance_type":51,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
355	426	instance_types	99	{"name":"i3en.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	{"name":"i3en.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	\N	\N
356	427	prices	59	{"sku":"HEVRVMP9YZFBURXS","service":7,"region":15,"instance_type":99,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"HEVRVMP9YZFBURXS","service":7,"region":15,"instance_type":99,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
357	428	instance_types	100	{"name":"i3en.24xlarge","service":7,"vcpu":"96","memory":"768 GiB"}	{"name":"i3en.24xlarge","service":7,"vcpu":"96","memory":"768 GiB"}	\N	\N
358	429	prices	60	{"sku":"4M98HYM3J5Z46AWP","service":7,"region":15,"instance_type":100,"os":"Linux","price_per_unit":15.878,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"4M98HYM3J5Z46AWP","service":7,"region":15,"instance_type":100,"os":"Linux","price_per_unit":15.878,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
359	430	instance_types	101	{"name":"m6i.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	{"name":"m6i.8xlarge","service":7,"vcpu":"32","memory":"128 GiB"}	\N	\N
360	431	prices	61	{"sku":"AU72RP7VJUVCNDRH","service":7,"region":15,"instance_type":101,"os":"Red Hat Enterprise Linux with HA","price_per_unit":3.0288,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"AU72RP7VJUVCNDRH","service":7,"region":15,"instance_type":101,"os":"Red Hat Enterprise Linux with HA","price_per_unit":3.0288,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
361	432	prices	62	{"sku":"F8HJ3NCTTYKMEJWH","service":7,"region":15,"instance_type":80,"os":"RHEL","price_per_unit":1.303,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"F8HJ3NCTTYKMEJWH","service":7,"region":15,"instance_type":80,"os":"RHEL","price_per_unit":1.303,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
362	433	instance_types	102	{"name":"r6i.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	{"name":"r6i.8xlarge","service":7,"vcpu":"32","memory":"256 GiB"}	\N	\N
363	434	prices	63	{"sku":"KV6EJ6STDMSYT892","service":7,"region":15,"instance_type":102,"os":"RHEL","price_per_unit":3.5744,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"KV6EJ6STDMSYT892","service":7,"region":15,"instance_type":102,"os":"RHEL","price_per_unit":3.5744,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
364	435	prices	64	{"sku":"ZDA867EN25M7J2RP","service":7,"region":15,"instance_type":80,"os":"SUSE","price_per_unit":1.39,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"ZDA867EN25M7J2RP","service":7,"region":15,"instance_type":80,"os":"SUSE","price_per_unit":1.39,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
365	436	prices	65	{"sku":"S527DJBR37ZD82WG","service":7,"region":15,"instance_type":53,"os":"Ubuntu Pro","price_per_unit":7.063,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"S527DJBR37ZD82WG","service":7,"region":15,"instance_type":53,"os":"Ubuntu Pro","price_per_unit":7.063,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
366	437	instance_types	103	{"name":"r5d.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	{"name":"r5d.2xlarge","service":7,"vcpu":"8","memory":"64 GiB"}	\N	\N
367	438	prices	66	{"sku":"6GV6TRXN67XJK43Q","service":7,"region":15,"instance_type":103,"os":"Windows","price_per_unit":1.309,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"6GV6TRXN67XJK43Q","service":7,"region":15,"instance_type":103,"os":"Windows","price_per_unit":1.309,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
368	439	instance_types	104	{"name":"r6g.12xlarge","service":7,"vcpu":"48","memory":"384 GiB"}	{"name":"r6g.12xlarge","service":7,"vcpu":"48","memory":"384 GiB"}	\N	\N
369	440	prices	67	{"sku":"5QQ3CDA54WA4SF89","service":7,"region":15,"instance_type":104,"os":"Ubuntu Pro","price_per_unit":3.3096,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"5QQ3CDA54WA4SF89","service":7,"region":15,"instance_type":104,"os":"Ubuntu Pro","price_per_unit":3.3096,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
370	441	instance_types	105	{"name":"r5n.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	{"name":"r5n.xlarge","service":7,"vcpu":"4","memory":"32 GiB"}	\N	\N
371	442	prices	68	{"sku":"DBV2CP3SH6SW44EJ","service":7,"region":15,"instance_type":105,"os":"Windows","price_per_unit":0.581,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"DBV2CP3SH6SW44EJ","service":7,"region":15,"instance_type":105,"os":"Windows","price_per_unit":0.581,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
372	443	instance_types	106	{"name":"r5dn.4xlarge","service":7,"vcpu":"16","memory":"128 GiB"}	{"name":"r5dn.4xlarge","service":7,"vcpu":"16","memory":"128 GiB"}	\N	\N
373	444	prices	69	{"sku":"C5TUM9HCPAEYJS3Y","service":7,"region":15,"instance_type":106,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"C5TUM9HCPAEYJS3Y","service":7,"region":15,"instance_type":106,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
374	445	instance_types	107	{"name":"c5.9xlarge","service":7,"vcpu":"36","memory":"72 GiB"}	{"name":"c5.9xlarge","service":7,"vcpu":"36","memory":"72 GiB"}	\N	\N
375	446	prices	70	{"sku":"BXY45PCG93MXNU65","service":7,"region":15,"instance_type":107,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"BXY45PCG93MXNU65","service":7,"region":15,"instance_type":107,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
376	447	instance_types	108	{"name":"m5d.12xlarge","service":7,"vcpu":"48","memory":"192 GiB"}	{"name":"m5d.12xlarge","service":7,"vcpu":"48","memory":"192 GiB"}	\N	\N
377	448	prices	71	{"sku":"Q43N23NMCM5M72TG","service":7,"region":15,"instance_type":108,"os":"Linux","price_per_unit":9.576,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"Q43N23NMCM5M72TG","service":7,"region":15,"instance_type":108,"os":"Linux","price_per_unit":9.576,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
378	449	instance_types	109	{"name":"r7gd.large","service":7,"vcpu":"2","memory":"16 GiB"}	{"name":"r7gd.large","service":7,"vcpu":"2","memory":"16 GiB"}	\N	\N
379	450	prices	72	{"sku":"AHGDT97G6TSZY3SX","service":7,"region":15,"instance_type":109,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"AHGDT97G6TSZY3SX","service":7,"region":15,"instance_type":109,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
380	451	instance_types	110	{"name":"x2iedn.8xlarge","service":7,"vcpu":"32","memory":"1024 GiB"}	{"name":"x2iedn.8xlarge","service":7,"vcpu":"32","memory":"1024 GiB"}	\N	\N
381	452	prices	73	{"sku":"4ECE9GMJ3XCHYWXS","service":7,"region":15,"instance_type":110,"os":"Linux","price_per_unit":9.524,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"4ECE9GMJ3XCHYWXS","service":7,"region":15,"instance_type":110,"os":"Linux","price_per_unit":9.524,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
382	453	prices	74	{"sku":"JPVM2NP8RXVNH2ES","service":7,"region":15,"instance_type":76,"os":"Windows","price_per_unit":34.44032,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"JPVM2NP8RXVNH2ES","service":7,"region":15,"instance_type":76,"os":"Windows","price_per_unit":34.44032,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
383	454	instance_types	111	{"name":"r7gd.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	{"name":"r7gd.16xlarge","service":7,"vcpu":"64","memory":"512 GiB"}	\N	\N
384	455	prices	75	{"sku":"YZBMDYPK7FXSPVFF","service":7,"region":15,"instance_type":111,"os":"SUSE","price_per_unit":5.8706,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"YZBMDYPK7FXSPVFF","service":7,"region":15,"instance_type":111,"os":"SUSE","price_per_unit":5.8706,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
385	456	instance_types	112	{"name":"i4i.4xlarge","service":7,"vcpu":"16","memory":"128 GiB"}	{"name":"i4i.4xlarge","service":7,"vcpu":"16","memory":"128 GiB"}	\N	\N
386	457	prices	76	{"sku":"CA9QFRR9YHNGZGB6","service":7,"region":15,"instance_type":112,"os":"Windows","price_per_unit":4.46,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"CA9QFRR9YHNGZGB6","service":7,"region":15,"instance_type":112,"os":"Windows","price_per_unit":4.46,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
387	458	prices	77	{"sku":"7BYP5K2BRPMUATMR","service":7,"region":15,"instance_type":47,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"7BYP5K2BRPMUATMR","service":7,"region":15,"instance_type":47,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
388	459	instance_types	113	{"name":"c5d.18xlarge","service":7,"vcpu":"72","memory":"144 GiB"}	{"name":"c5d.18xlarge","service":7,"vcpu":"72","memory":"144 GiB"}	\N	\N
389	460	prices	78	{"sku":"ZNJNEUVD6GRC3GC2","service":7,"region":15,"instance_type":113,"os":"RHEL","price_per_unit":5.458,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"ZNJNEUVD6GRC3GC2","service":7,"region":15,"instance_type":113,"os":"RHEL","price_per_unit":5.458,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
390	461	prices	79	{"sku":"5KJPAHP28X5BGQ4X","service":7,"region":15,"instance_type":84,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"5KJPAHP28X5BGQ4X","service":7,"region":15,"instance_type":84,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
391	462	instance_types	114	{"name":"r7gd.4xlarge","service":7,"vcpu":"16","memory":"128 GiB"}	{"name":"r7gd.4xlarge","service":7,"vcpu":"16","memory":"128 GiB"}	\N	\N
392	463	prices	80	{"sku":"HQF26CEJ4NE23PK7","service":7,"region":15,"instance_type":114,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"HQF26CEJ4NE23PK7","service":7,"region":15,"instance_type":114,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
393	464	prices	81	{"sku":"83XBVTQ5MSFD6UW6","service":7,"region":15,"instance_type":72,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"83XBVTQ5MSFD6UW6","service":7,"region":15,"instance_type":72,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
394	465	prices	82	{"sku":"ZW5282D6EZE2PRNV","service":7,"region":15,"instance_type":54,"os":"Linux","price_per_unit":1.127,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	{"sku":"ZW5282D6EZE2PRNV","service":7,"region":15,"instance_type":54,"os":"Linux","price_per_unit":1.127,"unit":"Hrs","currency":"USD","updated_at":"2025-10-01T22:50:46"}	\N	\N
395	466	instance_types	115	{"name":"c5n.metal","service":7,"vcpu":"72","memory":"192 GiB"}	{"name":"c5n.metal","service":7,"vcpu":"72","memory":"192 GiB"}	\N	\N
396	468	resources	1	{"id":1,"service":1,"region":11,"instance_type":61,"configuration":{"quantity":3,"hours_per_month":730,"os":"Linux"},"unit_price":"0.08320","monthly_cost":"182.19000","created_at":"2025-10-01T12:00:00","resource_name":"Production Web Servers 1","simulations_id":1}	{"instance_type":61}	\N	\N
399	471	directus_fields	65	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"recommendations","field":"simulation_id"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"recommendations","field":"simulation_id"}	\N	\N
400	472	directus_fields	66	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"recommendations","field":"resource_id"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"recommendations","field":"resource_id"}	\N	\N
421	493	instance_types	116	{"name":"x2idn.metal","service":8,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.metal","service":8,"vcpu":"128","memory":"2048 GiB"}	\N	\N
403	475	directus_fields	68	{"sort":5,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"high","value":"high"},{"text":"medium","value":"medium"},{"text":"low","value":"low"}]},"collection":"recommendations","field":"prioprity"}	{"sort":5,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"high","value":"high"},{"text":"medium","value":"medium"},{"text":"low","value":"low"}]},"collection":"recommendations","field":"prioprity"}	\N	\N
404	476	directus_fields	69	{"sort":6,"interface":"input","special":null,"collection":"recommendations","field":"title"}	{"sort":6,"interface":"input","special":null,"collection":"recommendations","field":"title"}	\N	\N
405	477	directus_fields	70	{"sort":7,"interface":"input","special":null,"collection":"recommendations","field":"description"}	{"sort":7,"interface":"input","special":null,"collection":"recommendations","field":"description"}	\N	\N
406	478	directus_fields	71	{"sort":8,"interface":"input","special":null,"collection":"recommendations","field":"current_cost"}	{"sort":8,"interface":"input","special":null,"collection":"recommendations","field":"current_cost"}	\N	\N
407	479	directus_fields	72	{"sort":9,"interface":"input","special":null,"collection":"recommendations","field":"optimized_cost"}	{"sort":9,"interface":"input","special":null,"collection":"recommendations","field":"optimized_cost"}	\N	\N
408	480	directus_fields	73	{"sort":10,"interface":"input","special":null,"collection":"recommendations","field":"potential_savings"}	{"sort":10,"interface":"input","special":null,"collection":"recommendations","field":"potential_savings"}	\N	\N
409	481	directus_fields	74	{"sort":11,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"easy","value":"easy"},{"text":"medium","value":"medium"},{"text":"hard","value":"hard"}]},"collection":"recommendations","field":"implementation_effort"}	{"sort":11,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"easy","value":"easy"},{"text":"medium","value":"medium"},{"text":"hard","value":"hard"}]},"collection":"recommendations","field":"implementation_effort"}	\N	\N
410	482	directus_fields	75	{"sort":12,"interface":"boolean","special":["cast-boolean"],"collection":"recommendations","field":"applied"}	{"sort":12,"interface":"boolean","special":["cast-boolean"],"collection":"recommendations","field":"applied"}	\N	\N
411	483	directus_fields	76	{"sort":13,"interface":"datetime","special":null,"collection":"recommendations","field":"created_at"}	{"sort":13,"interface":"datetime","special":null,"collection":"recommendations","field":"created_at"}	\N	\N
412	484	directus_fields	77	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"comparisons"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"comparisons"}	\N	\N
413	485	directus_collections	comparisons	{"singleton":false,"collection":"comparisons"}	{"singleton":false,"collection":"comparisons"}	\N	\N
414	486	directus_fields	78	{"sort":2,"interface":"input","special":null,"collection":"comparisons","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"comparisons","field":"name"}	\N	\N
415	487	directus_fields	79	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"comparisons","field":"simulation_baseline"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"comparisons","field":"simulation_baseline"}	\N	\N
416	488	directus_fields	80	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"comparisons","field":"simulation_comparison"}	{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"comparisons","field":"simulation_comparison"}	\N	\N
417	489	directus_fields	81	{"sort":5,"interface":"input","special":null,"collection":"comparisons","field":"cost_difference"}	{"sort":5,"interface":"input","special":null,"collection":"comparisons","field":"cost_difference"}	\N	\N
418	490	directus_fields	82	{"sort":6,"interface":"input","special":null,"collection":"comparisons","field":"percentage_change"}	{"sort":6,"interface":"input","special":null,"collection":"comparisons","field":"percentage_change"}	\N	\N
419	491	directus_fields	83	{"sort":7,"interface":"datetime","special":null,"collection":"comparisons","field":"created_at"}	{"sort":7,"interface":"datetime","special":null,"collection":"comparisons","field":"created_at"}	\N	\N
422	494	prices	1	{"id":1,"sku":"ASAJBV2BNW4TK2AC","service":8,"region":15,"instance_type":45,"os":"Windows","price_per_unit":0,"created_at":null,"updated_at":"2025-10-02T10:10:36"}	{"service":8,"region":15,"os":"Windows","price_per_unit":0,"updated_at":"2025-10-02T10:10:36"}	\N	\N
423	495	instance_types	117	{"name":"c5d.metal","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.metal","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
424	496	prices	2	{"id":2,"sku":"2MJHSZ8K32A878HY","service":8,"region":15,"instance_type":46,"os":"Windows","price_per_unit":4.416,"created_at":null,"updated_at":"2025-10-02T10:10:37"}	{"service":8,"region":15,"os":"Windows","price_per_unit":4.416,"updated_at":"2025-10-02T10:10:37"}	\N	\N
425	497	instance_types	118	{"name":"c5d.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
426	498	prices	3	{"id":3,"sku":"MQRX2N7GEX3K5BPR","service":8,"region":15,"instance_type":47,"os":"RHEL","price_per_unit":7.277,"created_at":null,"updated_at":"2025-10-02T10:10:37"}	{"service":8,"region":15,"os":"RHEL","price_per_unit":7.277,"updated_at":"2025-10-02T10:10:37"}	\N	\N
427	499	instance_types	119	{"name":"r5dn.12xlarge","service":8,"vcpu":"48","memory":"384 GiB"}	{"name":"r5dn.12xlarge","service":8,"vcpu":"48","memory":"384 GiB"}	\N	\N
428	500	prices	4	{"id":4,"sku":"JJC7VV7EUWNQ7U7V","service":8,"region":15,"instance_type":48,"os":"Linux","price_per_unit":0,"created_at":null,"updated_at":"2025-10-02T10:10:37"}	{"service":8,"region":15,"os":"Linux","price_per_unit":0,"updated_at":"2025-10-02T10:10:37"}	\N	\N
429	501	prices	1	{"id":1,"sku":"ASAJBV2BNW4TK2AC","service":8,"region":15,"instance_type":45,"os":"Windows","price_per_unit":0,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"Windows","price_per_unit":0,"updated_at":"2025-10-02T10:14:04"}	\N	\N
430	502	prices	2	{"id":2,"sku":"2MJHSZ8K32A878HY","service":8,"region":15,"instance_type":46,"os":"Windows","price_per_unit":4.416,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"Windows","price_per_unit":4.416,"updated_at":"2025-10-02T10:14:04"}	\N	\N
431	503	prices	3	{"id":3,"sku":"MQRX2N7GEX3K5BPR","service":8,"region":15,"instance_type":47,"os":"RHEL","price_per_unit":7.277,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"RHEL","price_per_unit":7.277,"updated_at":"2025-10-02T10:14:04"}	\N	\N
432	504	prices	4	{"id":4,"sku":"JJC7VV7EUWNQ7U7V","service":8,"region":15,"instance_type":48,"os":"Linux","price_per_unit":0,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"Linux","price_per_unit":0,"updated_at":"2025-10-02T10:14:04"}	\N	\N
433	505	instance_types	120	{"name":"m6i.large","service":8,"vcpu":"2","memory":"8 GiB"}	{"name":"m6i.large","service":8,"vcpu":"2","memory":"8 GiB"}	\N	\N
434	506	prices	5	{"id":5,"sku":"4Y3K6MNSSJUDKTS2","service":8,"region":15,"instance_type":49,"os":"Windows","price_per_unit":0.699,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"Windows","price_per_unit":0.699,"updated_at":"2025-10-02T10:14:04"}	\N	\N
435	507	instance_types	121	{"name":"m5.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	{"name":"m5.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	\N	\N
436	508	prices	6	{"id":6,"sku":"CMBYZZ3KTUNXB2MQ","service":8,"region":15,"instance_type":50,"os":"Linux","price_per_unit":0.322,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"Linux","price_per_unit":0.322,"updated_at":"2025-10-02T10:14:04"}	\N	\N
437	509	instance_types	122	{"name":"m6i.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	{"name":"m6i.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	\N	\N
438	510	prices	7	{"id":7,"sku":"CS2EAT4BBKX282YT","service":8,"region":15,"instance_type":51,"os":"Ubuntu Pro","price_per_unit":0.261,"created_at":null,"updated_at":"2025-10-02T10:14:04"}	{"service":8,"region":15,"os":"Ubuntu Pro","price_per_unit":0.261,"updated_at":"2025-10-02T10:14:04"}	\N	\N
439	511	instance_types	123	{"name":"c6g.metal","service":8,"vcpu":"64","memory":"128 GiB"}	{"name":"c6g.metal","service":8,"vcpu":"64","memory":"128 GiB"}	\N	\N
440	512	prices	8	{"id":8,"sku":"EUNMXQYZDDD3SU8N","service":8,"region":15,"instance_type":52,"os":"SUSE","price_per_unit":3.0434,"created_at":null,"updated_at":"2025-10-02T10:14:05"}	{"service":8,"region":15,"os":"SUSE","price_per_unit":3.0434,"updated_at":"2025-10-02T10:14:05"}	\N	\N
441	513	prices	9	{"id":9,"sku":"2KKVCKPSRZ69KDT8","service":8,"region":15,"instance_type":46,"os":"Windows","price_per_unit":0,"created_at":null,"updated_at":"2025-10-02T10:14:05"}	{"service":8,"region":15,"os":"Windows","price_per_unit":0,"updated_at":"2025-10-02T10:14:05"}	\N	\N
442	514	instance_types	124	{"name":"d2.8xlarge","service":8,"vcpu":"36","memory":"244 GiB"}	{"name":"d2.8xlarge","service":8,"vcpu":"36","memory":"244 GiB"}	\N	\N
=======
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
397	84	directus_collections	prices	{"collection":"prices"}	{"collection":"prices"}	\N	\N
398	85	directus_collections	resources	{"collection":"resources"}	{"collection":"resources"}	\N	\N
399	86	directus_fields	64	{"special":null,"collection":"prices","field":"id"}	{"special":null,"collection":"prices","field":"id"}	\N	\N
400	87	directus_fields	65	{"special":null,"collection":"prices","field":"sku"}	{"special":null,"collection":"prices","field":"sku"}	\N	\N
401	88	directus_fields	66	{"special":null,"collection":"prices","field":"service"}	{"special":null,"collection":"prices","field":"service"}	\N	\N
402	89	directus_fields	67	{"special":null,"collection":"prices","field":"region"}	{"special":null,"collection":"prices","field":"region"}	\N	\N
403	90	directus_fields	68	{"special":null,"collection":"prices","field":"instance_type"}	{"special":null,"collection":"prices","field":"instance_type"}	\N	\N
404	91	directus_fields	69	{"special":null,"collection":"prices","field":"os"}	{"special":null,"collection":"prices","field":"os"}	\N	\N
405	92	directus_fields	70	{"special":null,"collection":"prices","field":"price_per_unit"}	{"special":null,"collection":"prices","field":"price_per_unit"}	\N	\N
406	93	directus_fields	71	{"special":null,"collection":"prices","field":"created_at"}	{"special":null,"collection":"prices","field":"created_at"}	\N	\N
407	94	directus_fields	72	{"special":null,"collection":"prices","field":"updated_at"}	{"special":null,"collection":"prices","field":"updated_at"}	\N	\N
408	95	directus_fields	73	{"special":null,"collection":"resources","field":"id"}	{"special":null,"collection":"resources","field":"id"}	\N	\N
409	96	directus_fields	74	{"special":null,"collection":"resources","field":"service"}	{"special":null,"collection":"resources","field":"service"}	\N	\N
410	97	directus_fields	75	{"special":null,"collection":"resources","field":"region"}	{"special":null,"collection":"resources","field":"region"}	\N	\N
411	98	directus_fields	76	{"special":null,"collection":"resources","field":"instance_type"}	{"special":null,"collection":"resources","field":"instance_type"}	\N	\N
412	99	directus_fields	77	{"special":["cast-json"],"collection":"resources","field":"configuration"}	{"special":["cast-json"],"collection":"resources","field":"configuration"}	\N	\N
413	100	directus_fields	78	{"special":null,"collection":"resources","field":"monthly_cost"}	{"special":null,"collection":"resources","field":"monthly_cost"}	\N	\N
414	101	directus_fields	79	{"special":null,"collection":"resources","field":"unit_price"}	{"special":null,"collection":"resources","field":"unit_price"}	\N	\N
415	102	directus_fields	80	{"special":null,"collection":"resources","field":"created_at"}	{"special":null,"collection":"resources","field":"created_at"}	\N	\N
416	103	directus_fields	81	{"special":null,"collection":"resources","field":"resource_name"}	{"special":null,"collection":"resources","field":"resource_name"}	\N	\N
417	104	directus_fields	82	{"special":null,"collection":"resources","field":"simulations_id"}	{"special":null,"collection":"resources","field":"simulations_id"}	\N	\N
419	106	simulations	2	{"name":"test","region":5,"entries":[]}	{"name":"test","region":5,"entries":[]}	\N	\N
420	107	services	8	{"code":"AmazonEC2","name":"Amazon AmazonEC2"}	{"code":"AmazonEC2","name":"Amazon AmazonEC2"}	\N	\N
421	108	regions	45	{"code":"us-east-1","name":"US East (N. Virginia)","country":"USA"}	{"code":"us-east-1","name":"US East (N. Virginia)","country":"USA"}	\N	\N
422	109	regions	46	{"code":"us-east-2","name":"US East (Ohio)","country":"USA"}	{"code":"us-east-2","name":"US East (Ohio)","country":"USA"}	\N	\N
423	110	regions	47	{"code":"us-west-1","name":"US West (N. California)","country":"USA"}	{"code":"us-west-1","name":"US West (N. California)","country":"USA"}	\N	\N
424	111	regions	48	{"code":"us-west-2","name":"US West (Oregon)","country":"USA"}	{"code":"us-west-2","name":"US West (Oregon)","country":"USA"}	\N	\N
425	112	regions	49	{"code":"af-south-1","name":"Africa (Cape Town)","country":"South Africa"}	{"code":"af-south-1","name":"Africa (Cape Town)","country":"South Africa"}	\N	\N
426	113	regions	50	{"code":"ap-east-1","name":"Asia Pacific (Hong Kong)","country":"Hong Kong"}	{"code":"ap-east-1","name":"Asia Pacific (Hong Kong)","country":"Hong Kong"}	\N	\N
427	114	regions	51	{"code":"ap-south-2","name":"Asia Pacific (Hyderabad)","country":"India"}	{"code":"ap-south-2","name":"Asia Pacific (Hyderabad)","country":"India"}	\N	\N
428	115	regions	52	{"code":"ap-southeast-3","name":"Asia Pacific (Jakarta)","country":"Indonesia"}	{"code":"ap-southeast-3","name":"Asia Pacific (Jakarta)","country":"Indonesia"}	\N	\N
429	116	regions	53	{"code":"ap-southeast-5","name":"Asia Pacific (Malaysia)","country":"Malaysia"}	{"code":"ap-southeast-5","name":"Asia Pacific (Malaysia)","country":"Malaysia"}	\N	\N
430	117	regions	54	{"code":"ap-southeast-4","name":"Asia Pacific (Melbourne)","country":"Australia"}	{"code":"ap-southeast-4","name":"Asia Pacific (Melbourne)","country":"Australia"}	\N	\N
51	62	services	2	{"name":"Lambda"}	{"name":"Lambda"}	\N	\N
54	65	services	4	{"name":"Amazon ECS"}	{"name":"Amazon ECS"}	\N	\N
418	105	directus_users	27fc7a4b-bd46-414c-8883-99f3ae3089df	{"id":"27fc7a4b-bd46-414c-8883-99f3ae3089df","first_name":"Admin","last_name":"User","email":"admin@example.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"7d7ad24c-6292-497b-9809-ec4d797b1df5","token":"**********","last_access":"2025-10-02T07:12:28.047Z","last_page":"/users/27fc7a4b-bd46-414c-8883-99f3ae3089df","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
431	118	regions	55	{"code":"ap-south-1","name":"Asia Pacific (Mumbai)","country":"India"}	{"code":"ap-south-1","name":"Asia Pacific (Mumbai)","country":"India"}	\N	\N
432	119	regions	56	{"code":"ap-southeast-6","name":"Asia Pacific (New Zealand)","country":"New Zealand"}	{"code":"ap-southeast-6","name":"Asia Pacific (New Zealand)","country":"New Zealand"}	\N	\N
433	120	regions	57	{"code":"ap-northeast-3","name":"Asia Pacific (Osaka)","country":"Japan"}	{"code":"ap-northeast-3","name":"Asia Pacific (Osaka)","country":"Japan"}	\N	\N
434	121	regions	58	{"code":"ap-northeast-2","name":"Asia Pacific (Seoul)","country":"South Korea"}	{"code":"ap-northeast-2","name":"Asia Pacific (Seoul)","country":"South Korea"}	\N	\N
435	122	regions	59	{"code":"ap-southeast-1","name":"Asia Pacific (Singapore)","country":"Singapore"}	{"code":"ap-southeast-1","name":"Asia Pacific (Singapore)","country":"Singapore"}	\N	\N
436	123	regions	60	{"code":"ap-southeast-2","name":"Asia Pacific (Sydney)","country":"Australia"}	{"code":"ap-southeast-2","name":"Asia Pacific (Sydney)","country":"Australia"}	\N	\N
437	124	regions	61	{"code":"ap-east-2","name":"Asia Pacific (Taipei)","country":"Taiwan"}	{"code":"ap-east-2","name":"Asia Pacific (Taipei)","country":"Taiwan"}	\N	\N
438	125	regions	62	{"code":"ap-southeast-7","name":"Asia Pacific (Thailand)","country":"Thailand"}	{"code":"ap-southeast-7","name":"Asia Pacific (Thailand)","country":"Thailand"}	\N	\N
439	126	regions	63	{"code":"ap-northeast-1","name":"Asia Pacific (Tokyo)","country":"Japan"}	{"code":"ap-northeast-1","name":"Asia Pacific (Tokyo)","country":"Japan"}	\N	\N
440	127	regions	64	{"code":"ca-central-1","name":"Canada (Central)","country":"Canada"}	{"code":"ca-central-1","name":"Canada (Central)","country":"Canada"}	\N	\N
441	128	regions	65	{"code":"ca-west-1","name":"Canada West (Calgary)","country":"Canada"}	{"code":"ca-west-1","name":"Canada West (Calgary)","country":"Canada"}	\N	\N
442	129	regions	66	{"code":"eu-central-1","name":"Europe (Frankfurt)","country":"Germany"}	{"code":"eu-central-1","name":"Europe (Frankfurt)","country":"Germany"}	\N	\N
443	130	regions	67	{"code":"eu-west-1","name":"Europe (Ireland)","country":"Ireland"}	{"code":"eu-west-1","name":"Europe (Ireland)","country":"Ireland"}	\N	\N
444	131	regions	68	{"code":"eu-west-2","name":"Europe (London)","country":"UK"}	{"code":"eu-west-2","name":"Europe (London)","country":"UK"}	\N	\N
445	132	regions	69	{"code":"eu-south-1","name":"Europe (Milan)","country":"Italy"}	{"code":"eu-south-1","name":"Europe (Milan)","country":"Italy"}	\N	\N
446	133	regions	70	{"code":"eu-west-3","name":"Europe (Paris)","country":"France"}	{"code":"eu-west-3","name":"Europe (Paris)","country":"France"}	\N	\N
447	134	regions	71	{"code":"eu-south-2","name":"Europe (Spain)","country":"Spain"}	{"code":"eu-south-2","name":"Europe (Spain)","country":"Spain"}	\N	\N
448	135	regions	72	{"code":"eu-north-1","name":"Europe (Stockholm)","country":"Sweden"}	{"code":"eu-north-1","name":"Europe (Stockholm)","country":"Sweden"}	\N	\N
449	136	regions	73	{"code":"eu-central-2","name":"Europe (Zurich)","country":"Switzerland"}	{"code":"eu-central-2","name":"Europe (Zurich)","country":"Switzerland"}	\N	\N
450	137	regions	74	{"code":"il-central-1","name":"Israel (Tel Aviv)","country":"Israel"}	{"code":"il-central-1","name":"Israel (Tel Aviv)","country":"Israel"}	\N	\N
451	138	regions	75	{"code":"mx-central-1","name":"Mexico (Central)","country":"Mexico"}	{"code":"mx-central-1","name":"Mexico (Central)","country":"Mexico"}	\N	\N
452	139	regions	76	{"code":"me-south-1","name":"Middle East (Bahrain)","country":"Bahrain"}	{"code":"me-south-1","name":"Middle East (Bahrain)","country":"Bahrain"}	\N	\N
453	140	regions	77	{"code":"me-central-1","name":"Middle East (UAE)","country":"United Arab Emirates"}	{"code":"me-central-1","name":"Middle East (UAE)","country":"United Arab Emirates"}	\N	\N
454	141	regions	78	{"code":"sa-east-1","name":"South America (São Paulo)","country":"Brazil"}	{"code":"sa-east-1","name":"South America (São Paulo)","country":"Brazil"}	\N	\N
491	178	prices	101	{"sku":"DCCMGMP4QWH42S22","service":8,"region":49,"instance_type":133,"os":"Windows","price_per_unit":0.442,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"DCCMGMP4QWH42S22","service":8,"region":49,"instance_type":133,"os":"Windows","price_per_unit":0.442,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
492	179	instance_types	134	{"name":"x2idn.32xlarge","service":8,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.32xlarge","service":8,"vcpu":"128","memory":"2048 GiB"}	\N	\N
493	180	prices	102	{"sku":"M24YR38EZ3RCKNV6","service":8,"region":49,"instance_type":134,"os":"Windows","price_per_unit":40.296,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"M24YR38EZ3RCKNV6","service":8,"region":49,"instance_type":134,"os":"Windows","price_per_unit":40.296,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
494	181	instance_types	135	{"name":"u-6tb1.112xlarge","service":8,"vcpu":"448","memory":"6144 GiB"}	{"name":"u-6tb1.112xlarge","service":8,"vcpu":"448","memory":"6144 GiB"}	\N	\N
495	182	prices	103	{"sku":"M226ANPSW5N2ZUUA","service":8,"region":49,"instance_type":135,"os":"RHEL","price_per_unit":77.0098,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"M226ANPSW5N2ZUUA","service":8,"region":49,"instance_type":135,"os":"RHEL","price_per_unit":77.0098,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
496	183	instance_types	136	{"name":"c6in.12xlarge","service":8,"vcpu":"48","memory":"96 GiB"}	{"name":"c6in.12xlarge","service":8,"vcpu":"48","memory":"96 GiB"}	\N	\N
497	184	prices	104	{"sku":"F4VQX8TVBFBDJT8F","service":8,"region":49,"instance_type":136,"os":"Linux","price_per_unit":3.65904,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"F4VQX8TVBFBDJT8F","service":8,"region":49,"instance_type":136,"os":"Linux","price_per_unit":3.65904,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
498	185	instance_types	137	{"name":"i3en.metal","service":8,"vcpu":"96","memory":"768 GiB"}	{"name":"i3en.metal","service":8,"vcpu":"96","memory":"768 GiB"}	\N	\N
2	3	directus_fields	1	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"test"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"test"}	\N	\N
3	4	directus_collections	test	{"singleton":false,"collection":"test"}	{"singleton":false,"collection":"test"}	\N	\N
4	5	directus_fields	2	{"sort":2,"interface":"input","special":null,"collection":"test","field":"testfield"}	{"sort":2,"interface":"input","special":null,"collection":"test","field":"testfield"}	\N	\N
57	68	regions	1	{"name":"US East (N. Virginia)","code":"\\tus-east-1"}	{"name":"US East (N. Virginia)","code":"\\tus-east-1"}	\N	\N
60	71	regions	4	{"name":"EU (Frankfurt)\\t","code":" eu-central-1"}	{"name":"EU (Frankfurt)\\t","code":" eu-central-1"}	\N	\N
62	73	regions	6	{"name":"Asia Pacific (Tokyo)\\t","code":" ap-northeast-1"}	{"name":"Asia Pacific (Tokyo)\\t","code":" ap-northeast-1"}	\N	\N
455	142	instance_types	116	{"name":"x2idn.metal","service":8,"vcpu":"128","memory":"2048 GiB"}	{"name":"x2idn.metal","service":8,"vcpu":"128","memory":"2048 GiB"}	\N	\N
456	143	prices	83	{"sku":"ASAJBV2BNW4TK2AC","service":8,"region":49,"instance_type":116,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"ASAJBV2BNW4TK2AC","service":8,"region":49,"instance_type":116,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
457	144	instance_types	117	{"name":"c5d.metal","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.metal","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
458	145	prices	84	{"sku":"2MJHSZ8K32A878HY","service":8,"region":49,"instance_type":117,"os":"Windows","price_per_unit":4.416,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"2MJHSZ8K32A878HY","service":8,"region":49,"instance_type":117,"os":"Windows","price_per_unit":4.416,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
459	146	instance_types	118	{"name":"c5d.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c5d.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
460	147	prices	85	{"sku":"MQRX2N7GEX3K5BPR","service":8,"region":49,"instance_type":118,"os":"RHEL","price_per_unit":7.277,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"MQRX2N7GEX3K5BPR","service":8,"region":49,"instance_type":118,"os":"RHEL","price_per_unit":7.277,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
461	148	instance_types	119	{"name":"r5dn.12xlarge","service":8,"vcpu":"48","memory":"384 GiB"}	{"name":"r5dn.12xlarge","service":8,"vcpu":"48","memory":"384 GiB"}	\N	\N
462	149	prices	86	{"sku":"JJC7VV7EUWNQ7U7V","service":8,"region":49,"instance_type":119,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"JJC7VV7EUWNQ7U7V","service":8,"region":49,"instance_type":119,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
463	150	instance_types	120	{"name":"m6i.large","service":8,"vcpu":"2","memory":"8 GiB"}	{"name":"m6i.large","service":8,"vcpu":"2","memory":"8 GiB"}	\N	\N
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
464	151	prices	87	{"sku":"4Y3K6MNSSJUDKTS2","service":8,"region":49,"instance_type":120,"os":"Windows","price_per_unit":0.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"4Y3K6MNSSJUDKTS2","service":8,"region":49,"instance_type":120,"os":"Windows","price_per_unit":0.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
465	152	instance_types	121	{"name":"m5.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	{"name":"m5.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	\N	\N
466	153	prices	88	{"sku":"CMBYZZ3KTUNXB2MQ","service":8,"region":49,"instance_type":121,"os":"Linux","price_per_unit":0.322,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"CMBYZZ3KTUNXB2MQ","service":8,"region":49,"instance_type":121,"os":"Linux","price_per_unit":0.322,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
467	154	instance_types	122	{"name":"m6i.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	{"name":"m6i.xlarge","service":8,"vcpu":"4","memory":"16 GiB"}	\N	\N
468	155	prices	89	{"sku":"CS2EAT4BBKX282YT","service":8,"region":49,"instance_type":122,"os":"Ubuntu Pro","price_per_unit":0.261,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"CS2EAT4BBKX282YT","service":8,"region":49,"instance_type":122,"os":"Ubuntu Pro","price_per_unit":0.261,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
469	156	instance_types	123	{"name":"c6g.metal","service":8,"vcpu":"64","memory":"128 GiB"}	{"name":"c6g.metal","service":8,"vcpu":"64","memory":"128 GiB"}	\N	\N
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
470	157	prices	90	{"sku":"EUNMXQYZDDD3SU8N","service":8,"region":49,"instance_type":123,"os":"SUSE","price_per_unit":3.0434,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"EUNMXQYZDDD3SU8N","service":8,"region":49,"instance_type":123,"os":"SUSE","price_per_unit":3.0434,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
471	158	prices	91	{"sku":"2KKVCKPSRZ69KDT8","service":8,"region":49,"instance_type":117,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"2KKVCKPSRZ69KDT8","service":8,"region":49,"instance_type":117,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
472	159	instance_types	124	{"name":"d2.8xlarge","service":8,"vcpu":"36","memory":"244 GiB"}	{"name":"d2.8xlarge","service":8,"vcpu":"36","memory":"244 GiB"}	\N	\N
473	160	prices	92	{"sku":"BBSEDDW6NBJA7BKC","service":8,"region":49,"instance_type":124,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"BBSEDDW6NBJA7BKC","service":8,"region":49,"instance_type":124,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
474	161	instance_types	125	{"name":"i4i.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	{"name":"i4i.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	\N	\N
475	162	prices	93	{"sku":"F4T76YYBGENXKG25","service":8,"region":49,"instance_type":125,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	{"sku":"F4T76YYBGENXKG25","service":8,"region":49,"instance_type":125,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:54"}	\N	\N
476	163	instance_types	126	{"name":"c6in.16xlarge","service":8,"vcpu":"64","memory":"128 GiB"}	{"name":"c6in.16xlarge","service":8,"vcpu":"64","memory":"128 GiB"}	\N	\N
477	164	prices	94	{"sku":"ZDF83CTQAU8SE5XQ","service":8,"region":49,"instance_type":126,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"ZDF83CTQAU8SE5XQ","service":8,"region":49,"instance_type":126,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
478	165	instance_types	127	{"name":"i3en.large","service":8,"vcpu":"2","memory":"16 GiB"}	{"name":"i3en.large","service":8,"vcpu":"2","memory":"16 GiB"}	\N	\N
525	212	instance_types	150	{"name":"m5d.8xlarge","service":8,"vcpu":"32","memory":"128 GiB"}	{"name":"m5d.8xlarge","service":8,"vcpu":"32","memory":"128 GiB"}	\N	\N
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
479	166	prices	95	{"sku":"2RZRZY3PKHFCV2UU","service":8,"region":49,"instance_type":127,"os":"Linux","price_per_unit":0.365,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"2RZRZY3PKHFCV2UU","service":8,"region":49,"instance_type":127,"os":"Linux","price_per_unit":0.365,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
480	167	instance_types	128	{"name":"c6i.32xlarge","service":8,"vcpu":"128","memory":"256 GiB"}	{"name":"c6i.32xlarge","service":8,"vcpu":"128","memory":"256 GiB"}	\N	\N
481	168	prices	96	{"sku":"D5JZ2YUV4KKDHT2T","service":8,"region":49,"instance_type":128,"os":"Windows","price_per_unit":13.184,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"D5JZ2YUV4KKDHT2T","service":8,"region":49,"instance_type":128,"os":"Windows","price_per_unit":13.184,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
482	169	instance_types	129	{"name":"r5dn.large","service":8,"vcpu":"2","memory":"16 GiB"}	{"name":"r5dn.large","service":8,"vcpu":"2","memory":"16 GiB"}	\N	\N
483	170	prices	97	{"sku":"ZAPMFFJKRJU3R5CF","service":8,"region":49,"instance_type":129,"os":"Linux","price_per_unit":0.2886,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"ZAPMFFJKRJU3R5CF","service":8,"region":49,"instance_type":129,"os":"Linux","price_per_unit":0.2886,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
484	171	instance_types	130	{"name":"c6in.xlarge","service":8,"vcpu":"4","memory":"8 GiB"}	{"name":"c6in.xlarge","service":8,"vcpu":"4","memory":"8 GiB"}	\N	\N
485	172	prices	98	{"sku":"MQSEQKYJG3J7XAJA","service":8,"region":49,"instance_type":130,"os":"Windows","price_per_unit":0.48892,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"MQSEQKYJG3J7XAJA","service":8,"region":49,"instance_type":130,"os":"Windows","price_per_unit":0.48892,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
486	173	instance_types	131	{"name":"c5a.12xlarge","service":8,"vcpu":"48","memory":"96 GiB"}	{"name":"c5a.12xlarge","service":8,"vcpu":"48","memory":"96 GiB"}	\N	\N
487	174	prices	99	{"sku":"K3SMWU6AY3HECJDP","service":8,"region":49,"instance_type":131,"os":"Linux","price_per_unit":8.479,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"K3SMWU6AY3HECJDP","service":8,"region":49,"instance_type":131,"os":"Linux","price_per_unit":8.479,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
488	175	instance_types	132	{"name":"inf1.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"inf1.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
489	176	prices	100	{"sku":"46XDJYY2FHPQK86E","service":8,"region":49,"instance_type":132,"os":"Linux","price_per_unit":6.249,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"46XDJYY2FHPQK86E","service":8,"region":49,"instance_type":132,"os":"Linux","price_per_unit":6.249,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
490	177	instance_types	133	{"name":"r5dn.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	{"name":"r5dn.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	\N	\N
552	239	instance_types	163	{"name":"c6in.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c6in.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
499	186	prices	105	{"sku":"EY7WB9D3MPP74S3V","service":8,"region":49,"instance_type":137,"os":"Linux","price_per_unit":14.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"EY7WB9D3MPP74S3V","service":8,"region":49,"instance_type":137,"os":"Linux","price_per_unit":14.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
500	187	instance_types	138	{"name":"c6g.xlarge","service":8,"vcpu":"4","memory":"8 GiB"}	{"name":"c6g.xlarge","service":8,"vcpu":"4","memory":"8 GiB"}	\N	\N
501	188	prices	106	{"sku":"SKQ7V8BYARK8QPWC","service":8,"region":49,"instance_type":138,"os":"SUSE","price_per_unit":0.2496,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	{"sku":"SKQ7V8BYARK8QPWC","service":8,"region":49,"instance_type":138,"os":"SUSE","price_per_unit":0.2496,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:55"}	\N	\N
502	189	instance_types	139	{"name":"i4i.metal","service":8,"vcpu":"128","memory":"1024 GiB"}	{"name":"i4i.metal","service":8,"vcpu":"128","memory":"1024 GiB"}	\N	\N
503	190	prices	107	{"sku":"VUJWJ43YRA549PU4","service":8,"region":49,"instance_type":139,"os":"Ubuntu Pro","price_per_unit":14.656,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"VUJWJ43YRA549PU4","service":8,"region":49,"instance_type":139,"os":"Ubuntu Pro","price_per_unit":14.656,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
504	191	instance_types	140	{"name":"r5n.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	{"name":"r5n.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	\N	\N
505	192	prices	108	{"sku":"5AP4B6TES68GAMNF","service":8,"region":49,"instance_type":140,"os":"SUSE","price_per_unit":3.304,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"5AP4B6TES68GAMNF","service":8,"region":49,"instance_type":140,"os":"SUSE","price_per_unit":3.304,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
506	193	instance_types	141	{"name":"m5d.2xlarge","service":8,"vcpu":"8","memory":"32 GiB"}	{"name":"m5d.2xlarge","service":8,"vcpu":"8","memory":"32 GiB"}	\N	\N
507	194	prices	109	{"sku":"8MKAA6VT83UZQFP5","service":8,"region":49,"instance_type":141,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"8MKAA6VT83UZQFP5","service":8,"region":49,"instance_type":141,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
508	195	instance_types	142	{"name":"c6i.16xlarge","service":8,"vcpu":"64","memory":"128 GiB"}	{"name":"c6i.16xlarge","service":8,"vcpu":"64","memory":"128 GiB"}	\N	\N
509	196	prices	110	{"sku":"73MPNA62D9M89QF4","service":8,"region":49,"instance_type":142,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"73MPNA62D9M89QF4","service":8,"region":49,"instance_type":142,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
510	197	instance_types	143	{"name":"r5dn.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	{"name":"r5dn.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	\N	\N
511	198	prices	111	{"sku":"XW8GAV8E42N3F476","service":8,"region":49,"instance_type":143,"os":"Windows","price_per_unit":17.008,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"XW8GAV8E42N3F476","service":8,"region":49,"instance_type":143,"os":"Windows","price_per_unit":17.008,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
512	199	instance_types	144	{"name":"c5a.4xlarge","service":8,"vcpu":"16","memory":"32 GiB"}	{"name":"c5a.4xlarge","service":8,"vcpu":"16","memory":"32 GiB"}	\N	\N
513	200	prices	112	{"sku":"59VZZCB8WVKHFH9V","service":8,"region":49,"instance_type":144,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"59VZZCB8WVKHFH9V","service":8,"region":49,"instance_type":144,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
514	201	instance_types	145	{"name":"m6g.large","service":8,"vcpu":"2","memory":"8 GiB"}	{"name":"m6g.large","service":8,"vcpu":"2","memory":"8 GiB"}	\N	\N
515	202	prices	113	{"sku":"R38YQE2VV7GA9G7Y","service":8,"region":49,"instance_type":145,"os":"Linux","price_per_unit":0.1016,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"R38YQE2VV7GA9G7Y","service":8,"region":49,"instance_type":145,"os":"Linux","price_per_unit":0.1016,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
516	203	instance_types	146	{"name":"c5a.large","service":8,"vcpu":"2","memory":"4 GiB"}	{"name":"c5a.large","service":8,"vcpu":"2","memory":"4 GiB"}	\N	\N
517	204	prices	114	{"sku":"W8DWGGQKZBVAN92Z","service":8,"region":49,"instance_type":146,"os":"Linux","price_per_unit":0.171,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"W8DWGGQKZBVAN92Z","service":8,"region":49,"instance_type":146,"os":"Linux","price_per_unit":0.171,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
518	205	prices	115	{"sku":"NSBFZXBV9Z632WFE","service":8,"region":49,"instance_type":119,"os":"Linux","price_per_unit":5.62224,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"NSBFZXBV9Z632WFE","service":8,"region":49,"instance_type":119,"os":"Linux","price_per_unit":5.62224,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
519	206	instance_types	147	{"name":"r5dn.16xlarge","service":8,"vcpu":"64","memory":"512 GiB"}	{"name":"r5dn.16xlarge","service":8,"vcpu":"64","memory":"512 GiB"}	\N	\N
520	207	prices	116	{"sku":"YR6NWE8T4FCV9YCS","service":8,"region":49,"instance_type":147,"os":"Windows","price_per_unit":11.0976,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"YR6NWE8T4FCV9YCS","service":8,"region":49,"instance_type":147,"os":"Windows","price_per_unit":11.0976,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
521	208	instance_types	148	{"name":"i4i.large","service":8,"vcpu":"2","memory":"16 GiB"}	{"name":"i4i.large","service":8,"vcpu":"2","memory":"16 GiB"}	\N	\N
522	209	prices	117	{"sku":"TCUF4AQ6VRAFT3QN","service":8,"region":49,"instance_type":148,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"TCUF4AQ6VRAFT3QN","service":8,"region":49,"instance_type":148,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
523	210	instance_types	149	{"name":"c5.metal","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c5.metal","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
524	211	prices	118	{"sku":"YYG8EUQR4PQSEJDU","service":8,"region":49,"instance_type":149,"os":"Windows","price_per_unit":5.472,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"YYG8EUQR4PQSEJDU","service":8,"region":49,"instance_type":149,"os":"Windows","price_per_unit":5.472,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
526	213	prices	119	{"sku":"UNFU8GZARWXJSEY2","service":8,"region":49,"instance_type":150,"os":"Ubuntu Pro","price_per_unit":2.6,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"UNFU8GZARWXJSEY2","service":8,"region":49,"instance_type":150,"os":"Ubuntu Pro","price_per_unit":2.6,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
527	214	instance_types	151	{"name":"i3en.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	{"name":"i3en.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	\N	\N
528	215	prices	120	{"sku":"6789AM2FPAFYK6DH","service":8,"region":49,"instance_type":151,"os":"Windows","price_per_unit":1.265,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"6789AM2FPAFYK6DH","service":8,"region":49,"instance_type":151,"os":"Windows","price_per_unit":1.265,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
529	216	instance_types	152	{"name":"r6i.metal","service":8,"vcpu":"128","memory":"1024 GiB"}	{"name":"r6i.metal","service":8,"vcpu":"128","memory":"1024 GiB"}	\N	\N
530	217	prices	121	{"sku":"K64RPFBV2R3WU6KM","service":8,"region":49,"instance_type":152,"os":"Linux","price_per_unit":10.752,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"K64RPFBV2R3WU6KM","service":8,"region":49,"instance_type":152,"os":"Linux","price_per_unit":10.752,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
531	218	instance_types	153	{"name":"m5.12xlarge","service":8,"vcpu":"48","memory":"192 GiB"}	{"name":"m5.12xlarge","service":8,"vcpu":"48","memory":"192 GiB"}	\N	\N
532	219	prices	122	{"sku":"7WB5V3H76287EU5S","service":8,"region":49,"instance_type":153,"os":"Windows","price_per_unit":5.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"7WB5V3H76287EU5S","service":8,"region":49,"instance_type":153,"os":"Windows","price_per_unit":5.256,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
533	220	prices	123	{"sku":"TTFAMWM9C75AKH8B","service":8,"region":49,"instance_type":141,"os":"Windows","price_per_unit":1.004,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"TTFAMWM9C75AKH8B","service":8,"region":49,"instance_type":141,"os":"Windows","price_per_unit":1.004,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
534	221	instance_types	154	{"name":"x1.32xlarge","service":8,"vcpu":"128","memory":"1952 GiB"}	{"name":"x1.32xlarge","service":8,"vcpu":"128","memory":"1952 GiB"}	\N	\N
535	222	prices	124	{"sku":"VA5SUTF8FP8N3AXN","service":8,"region":49,"instance_type":154,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	{"sku":"VA5SUTF8FP8N3AXN","service":8,"region":49,"instance_type":154,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:56"}	\N	\N
536	223	instance_types	155	{"name":"r7g.medium","service":8,"vcpu":"1","memory":"8 GiB"}	{"name":"r7g.medium","service":8,"vcpu":"1","memory":"8 GiB"}	\N	\N
537	224	prices	125	{"sku":"SAA526WFDWBR8DKJ","service":8,"region":49,"instance_type":155,"os":"Ubuntu Pro","price_per_unit":0.0732,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"SAA526WFDWBR8DKJ","service":8,"region":49,"instance_type":155,"os":"Ubuntu Pro","price_per_unit":0.0732,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
538	225	instance_types	156	{"name":"c6i.4xlarge","service":8,"vcpu":"16","memory":"32 GiB"}	{"name":"c6i.4xlarge","service":8,"vcpu":"16","memory":"32 GiB"}	\N	\N
539	226	prices	126	{"sku":"SRKPZJTPF33QB59X","service":8,"region":49,"instance_type":156,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"SRKPZJTPF33QB59X","service":8,"region":49,"instance_type":156,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
540	227	instance_types	157	{"name":"c6i.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c6i.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
541	228	prices	127	{"sku":"DMK6SQHM6DH8WT5W","service":8,"region":49,"instance_type":157,"os":"SUSE","price_per_unit":5.597,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"DMK6SQHM6DH8WT5W","service":8,"region":49,"instance_type":157,"os":"SUSE","price_per_unit":5.597,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
542	229	instance_types	158	{"name":"m5.8xlarge","service":8,"vcpu":"32","memory":"128 GiB"}	{"name":"m5.8xlarge","service":8,"vcpu":"32","memory":"128 GiB"}	\N	\N
543	230	prices	128	{"sku":"XJGBGA7YH2P82QTY","service":8,"region":49,"instance_type":158,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"XJGBGA7YH2P82QTY","service":8,"region":49,"instance_type":158,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
544	231	instance_types	159	{"name":"x1e.4xlarge","service":8,"vcpu":"16","memory":"488 GiB"}	{"name":"x1e.4xlarge","service":8,"vcpu":"16","memory":"488 GiB"}	\N	\N
545	232	prices	129	{"sku":"K5R438HR4MPH2ETV","service":8,"region":49,"instance_type":159,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"K5R438HR4MPH2ETV","service":8,"region":49,"instance_type":159,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
546	233	instance_types	160	{"name":"c6g.2xlarge","service":8,"vcpu":"8","memory":"16 GiB"}	{"name":"c6g.2xlarge","service":8,"vcpu":"8","memory":"16 GiB"}	\N	\N
547	234	prices	130	{"sku":"GGE9SKRP5EH6ACVP","service":8,"region":49,"instance_type":160,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0.62,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"GGE9SKRP5EH6ACVP","service":8,"region":49,"instance_type":160,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0.62,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
548	235	instance_types	161	{"name":"r5d.16xlarge","service":8,"vcpu":"64","memory":"512 GiB"}	{"name":"r5d.16xlarge","service":8,"vcpu":"64","memory":"512 GiB"}	\N	\N
549	236	prices	131	{"sku":"224TXKFMK98VD2H8","service":8,"region":49,"instance_type":161,"os":"Ubuntu Pro","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"224TXKFMK98VD2H8","service":8,"region":49,"instance_type":161,"os":"Ubuntu Pro","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
550	237	instance_types	162	{"name":"c6in.large","service":8,"vcpu":"2","memory":"4 GiB"}	{"name":"c6in.large","service":8,"vcpu":"2","memory":"4 GiB"}	\N	\N
551	238	prices	132	{"sku":"N2PWZHQJM7CUE2TC","service":8,"region":49,"instance_type":162,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"N2PWZHQJM7CUE2TC","service":8,"region":49,"instance_type":162,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
553	240	prices	133	{"sku":"QBGHQAG9TXN2XRJD","service":8,"region":49,"instance_type":163,"os":"RHEL","price_per_unit":44.35488,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"QBGHQAG9TXN2XRJD","service":8,"region":49,"instance_type":163,"os":"RHEL","price_per_unit":44.35488,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
554	241	instance_types	164	{"name":"r5dn.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	{"name":"r5dn.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	\N	\N
555	242	prices	134	{"sku":"YMSW32ECA33XM27M","service":8,"region":49,"instance_type":164,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"YMSW32ECA33XM27M","service":8,"region":49,"instance_type":164,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
556	243	instance_types	165	{"name":"r7gd.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	{"name":"r7gd.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	\N	\N
557	244	prices	135	{"sku":"QP28KQ4KEYYBW6ZG","service":8,"region":49,"instance_type":165,"os":"RHEL","price_per_unit":0.8334,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"QP28KQ4KEYYBW6ZG","service":8,"region":49,"instance_type":165,"os":"RHEL","price_per_unit":0.8334,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
558	245	instance_types	166	{"name":"r5d.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	{"name":"r5d.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	\N	\N
559	246	prices	136	{"sku":"62BDZCJBE2GU364K","service":8,"region":49,"instance_type":166,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"62BDZCJBE2GU364K","service":8,"region":49,"instance_type":166,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
560	247	instance_types	167	{"name":"c5a.8xlarge","service":8,"vcpu":"32","memory":"64 GiB"}	{"name":"c5a.8xlarge","service":8,"vcpu":"32","memory":"64 GiB"}	\N	\N
561	248	prices	137	{"sku":"AJKXPN4NGVUKNQRT","service":8,"region":49,"instance_type":167,"os":"RHEL","price_per_unit":2.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"AJKXPN4NGVUKNQRT","service":8,"region":49,"instance_type":167,"os":"RHEL","price_per_unit":2.699,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
562	249	instance_types	168	{"name":"c5.large","service":8,"vcpu":"2","memory":"4 GiB"}	{"name":"c5.large","service":8,"vcpu":"2","memory":"4 GiB"}	\N	\N
563	250	prices	138	{"sku":"D5XUX8VW63W4VRH7","service":8,"region":49,"instance_type":168,"os":"Ubuntu Pro","price_per_unit":0.118,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"D5XUX8VW63W4VRH7","service":8,"region":49,"instance_type":168,"os":"Ubuntu Pro","price_per_unit":0.118,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
564	251	instance_types	169	{"name":"c5a.16xlarge","service":8,"vcpu":"64","memory":"128 GiB"}	{"name":"c5a.16xlarge","service":8,"vcpu":"64","memory":"128 GiB"}	\N	\N
565	252	prices	139	{"sku":"RF9QAKYUZUBPYKQY","service":8,"region":49,"instance_type":169,"os":"RHEL","price_per_unit":11.667,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"RF9QAKYUZUBPYKQY","service":8,"region":49,"instance_type":169,"os":"RHEL","price_per_unit":11.667,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
566	253	prices	140	{"sku":"PRFRZD5R8C7ZVWK3","service":8,"region":49,"instance_type":122,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"PRFRZD5R8C7ZVWK3","service":8,"region":49,"instance_type":122,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
567	254	instance_types	170	{"name":"i3en.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	{"name":"i3en.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	\N	\N
568	255	prices	141	{"sku":"HEVRVMP9YZFBURXS","service":8,"region":49,"instance_type":170,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"HEVRVMP9YZFBURXS","service":8,"region":49,"instance_type":170,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
569	256	instance_types	171	{"name":"i3en.24xlarge","service":8,"vcpu":"96","memory":"768 GiB"}	{"name":"i3en.24xlarge","service":8,"vcpu":"96","memory":"768 GiB"}	\N	\N
570	257	prices	142	{"sku":"4M98HYM3J5Z46AWP","service":8,"region":49,"instance_type":171,"os":"Linux","price_per_unit":15.878,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"4M98HYM3J5Z46AWP","service":8,"region":49,"instance_type":171,"os":"Linux","price_per_unit":15.878,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
571	258	instance_types	172	{"name":"m6i.8xlarge","service":8,"vcpu":"32","memory":"128 GiB"}	{"name":"m6i.8xlarge","service":8,"vcpu":"32","memory":"128 GiB"}	\N	\N
572	259	prices	143	{"sku":"AU72RP7VJUVCNDRH","service":8,"region":49,"instance_type":172,"os":"Red Hat Enterprise Linux with HA","price_per_unit":3.0288,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	{"sku":"AU72RP7VJUVCNDRH","service":8,"region":49,"instance_type":172,"os":"Red Hat Enterprise Linux with HA","price_per_unit":3.0288,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:57"}	\N	\N
573	260	prices	144	{"sku":"F8HJ3NCTTYKMEJWH","service":8,"region":49,"instance_type":151,"os":"RHEL","price_per_unit":1.303,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"F8HJ3NCTTYKMEJWH","service":8,"region":49,"instance_type":151,"os":"RHEL","price_per_unit":1.303,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
574	261	instance_types	173	{"name":"r6i.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	{"name":"r6i.8xlarge","service":8,"vcpu":"32","memory":"256 GiB"}	\N	\N
575	262	prices	145	{"sku":"KV6EJ6STDMSYT892","service":8,"region":49,"instance_type":173,"os":"RHEL","price_per_unit":3.5744,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"KV6EJ6STDMSYT892","service":8,"region":49,"instance_type":173,"os":"RHEL","price_per_unit":3.5744,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
576	263	prices	146	{"sku":"ZDA867EN25M7J2RP","service":8,"region":49,"instance_type":151,"os":"SUSE","price_per_unit":1.39,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"ZDA867EN25M7J2RP","service":8,"region":49,"instance_type":151,"os":"SUSE","price_per_unit":1.39,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
577	264	prices	147	{"sku":"S527DJBR37ZD82WG","service":8,"region":49,"instance_type":124,"os":"Ubuntu Pro","price_per_unit":7.063,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"S527DJBR37ZD82WG","service":8,"region":49,"instance_type":124,"os":"Ubuntu Pro","price_per_unit":7.063,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
578	265	instance_types	174	{"name":"r5d.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	{"name":"r5d.2xlarge","service":8,"vcpu":"8","memory":"64 GiB"}	\N	\N
579	266	prices	148	{"sku":"6GV6TRXN67XJK43Q","service":8,"region":49,"instance_type":174,"os":"Windows","price_per_unit":1.309,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"6GV6TRXN67XJK43Q","service":8,"region":49,"instance_type":174,"os":"Windows","price_per_unit":1.309,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
580	267	instance_types	175	{"name":"r6g.12xlarge","service":8,"vcpu":"48","memory":"384 GiB"}	{"name":"r6g.12xlarge","service":8,"vcpu":"48","memory":"384 GiB"}	\N	\N
581	268	prices	149	{"sku":"5QQ3CDA54WA4SF89","service":8,"region":49,"instance_type":175,"os":"Ubuntu Pro","price_per_unit":3.3096,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"5QQ3CDA54WA4SF89","service":8,"region":49,"instance_type":175,"os":"Ubuntu Pro","price_per_unit":3.3096,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
582	269	instance_types	176	{"name":"r5n.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	{"name":"r5n.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	\N	\N
583	270	prices	150	{"sku":"DBV2CP3SH6SW44EJ","service":8,"region":49,"instance_type":176,"os":"Windows","price_per_unit":0.581,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"DBV2CP3SH6SW44EJ","service":8,"region":49,"instance_type":176,"os":"Windows","price_per_unit":0.581,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
584	271	instance_types	177	{"name":"r5dn.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	{"name":"r5dn.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	\N	\N
585	272	prices	151	{"sku":"C5TUM9HCPAEYJS3Y","service":8,"region":49,"instance_type":177,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"C5TUM9HCPAEYJS3Y","service":8,"region":49,"instance_type":177,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
586	273	instance_types	178	{"name":"c5.9xlarge","service":8,"vcpu":"36","memory":"72 GiB"}	{"name":"c5.9xlarge","service":8,"vcpu":"36","memory":"72 GiB"}	\N	\N
587	274	prices	152	{"sku":"BXY45PCG93MXNU65","service":8,"region":49,"instance_type":178,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"BXY45PCG93MXNU65","service":8,"region":49,"instance_type":178,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
588	275	instance_types	179	{"name":"m5d.12xlarge","service":8,"vcpu":"48","memory":"192 GiB"}	{"name":"m5d.12xlarge","service":8,"vcpu":"48","memory":"192 GiB"}	\N	\N
589	276	prices	153	{"sku":"Q43N23NMCM5M72TG","service":8,"region":49,"instance_type":179,"os":"Linux","price_per_unit":9.576,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"Q43N23NMCM5M72TG","service":8,"region":49,"instance_type":179,"os":"Linux","price_per_unit":9.576,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
590	277	instance_types	180	{"name":"r7gd.large","service":8,"vcpu":"2","memory":"16 GiB"}	{"name":"r7gd.large","service":8,"vcpu":"2","memory":"16 GiB"}	\N	\N
591	278	prices	154	{"sku":"AHGDT97G6TSZY3SX","service":8,"region":49,"instance_type":180,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"AHGDT97G6TSZY3SX","service":8,"region":49,"instance_type":180,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
592	279	instance_types	181	{"name":"x2iedn.8xlarge","service":8,"vcpu":"32","memory":"1024 GiB"}	{"name":"x2iedn.8xlarge","service":8,"vcpu":"32","memory":"1024 GiB"}	\N	\N
593	280	prices	155	{"sku":"4ECE9GMJ3XCHYWXS","service":8,"region":49,"instance_type":181,"os":"Linux","price_per_unit":9.524,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"4ECE9GMJ3XCHYWXS","service":8,"region":49,"instance_type":181,"os":"Linux","price_per_unit":9.524,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
594	281	prices	156	{"sku":"JPVM2NP8RXVNH2ES","service":8,"region":49,"instance_type":147,"os":"Windows","price_per_unit":34.44032,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"JPVM2NP8RXVNH2ES","service":8,"region":49,"instance_type":147,"os":"Windows","price_per_unit":34.44032,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
595	282	instance_types	182	{"name":"r7gd.16xlarge","service":8,"vcpu":"64","memory":"512 GiB"}	{"name":"r7gd.16xlarge","service":8,"vcpu":"64","memory":"512 GiB"}	\N	\N
596	283	prices	157	{"sku":"YZBMDYPK7FXSPVFF","service":8,"region":49,"instance_type":182,"os":"SUSE","price_per_unit":5.8706,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"YZBMDYPK7FXSPVFF","service":8,"region":49,"instance_type":182,"os":"SUSE","price_per_unit":5.8706,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
597	284	instance_types	183	{"name":"i4i.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	{"name":"i4i.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	\N	\N
598	285	prices	158	{"sku":"CA9QFRR9YHNGZGB6","service":8,"region":49,"instance_type":183,"os":"Windows","price_per_unit":4.46,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"CA9QFRR9YHNGZGB6","service":8,"region":49,"instance_type":183,"os":"Windows","price_per_unit":4.46,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
599	286	prices	159	{"sku":"7BYP5K2BRPMUATMR","service":8,"region":49,"instance_type":118,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"7BYP5K2BRPMUATMR","service":8,"region":49,"instance_type":118,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
600	287	instance_types	184	{"name":"c5d.18xlarge","service":8,"vcpu":"72","memory":"144 GiB"}	{"name":"c5d.18xlarge","service":8,"vcpu":"72","memory":"144 GiB"}	\N	\N
601	288	prices	160	{"sku":"ZNJNEUVD6GRC3GC2","service":8,"region":49,"instance_type":184,"os":"RHEL","price_per_unit":5.458,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"ZNJNEUVD6GRC3GC2","service":8,"region":49,"instance_type":184,"os":"RHEL","price_per_unit":5.458,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
602	289	prices	161	{"sku":"5KJPAHP28X5BGQ4X","service":8,"region":49,"instance_type":155,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"5KJPAHP28X5BGQ4X","service":8,"region":49,"instance_type":155,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
603	290	instance_types	185	{"name":"r7gd.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	{"name":"r7gd.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	\N	\N
604	291	prices	162	{"sku":"HQF26CEJ4NE23PK7","service":8,"region":49,"instance_type":185,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	{"sku":"HQF26CEJ4NE23PK7","service":8,"region":49,"instance_type":185,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:58"}	\N	\N
605	292	prices	163	{"sku":"83XBVTQ5MSFD6UW6","service":8,"region":49,"instance_type":143,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"83XBVTQ5MSFD6UW6","service":8,"region":49,"instance_type":143,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
606	293	prices	164	{"sku":"ZW5282D6EZE2PRNV","service":8,"region":49,"instance_type":125,"os":"Linux","price_per_unit":1.127,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"ZW5282D6EZE2PRNV","service":8,"region":49,"instance_type":125,"os":"Linux","price_per_unit":1.127,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
607	294	instance_types	186	{"name":"c5n.metal","service":8,"vcpu":"72","memory":"192 GiB"}	{"name":"c5n.metal","service":8,"vcpu":"72","memory":"192 GiB"}	\N	\N
608	295	prices	165	{"sku":"95669NRQQM74ZAWS","service":8,"region":49,"instance_type":186,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"95669NRQQM74ZAWS","service":8,"region":49,"instance_type":186,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
609	296	prices	166	{"sku":"VMHZR5M5JUMHX9XG","service":8,"region":49,"instance_type":151,"os":"Windows","price_per_unit":1.188,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"VMHZR5M5JUMHX9XG","service":8,"region":49,"instance_type":151,"os":"Windows","price_per_unit":1.188,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
610	297	instance_types	187	{"name":"c5n.2xlarge","service":8,"vcpu":"8","memory":"21 GiB"}	{"name":"c5n.2xlarge","service":8,"vcpu":"8","memory":"21 GiB"}	\N	\N
611	298	prices	167	{"sku":"UHREPRNVQBWTSKC9","service":8,"region":49,"instance_type":187,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"UHREPRNVQBWTSKC9","service":8,"region":49,"instance_type":187,"os":"RHEL","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
612	299	instance_types	188	{"name":"c6in.32xlarge","service":8,"vcpu":"128","memory":"256 GiB"}	{"name":"c6in.32xlarge","service":8,"vcpu":"128","memory":"256 GiB"}	\N	\N
613	300	prices	168	{"sku":"RP868NF4RSDQ47RD","service":8,"region":49,"instance_type":188,"os":"Red Hat Enterprise Linux with HA","price_per_unit":27.69024,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"RP868NF4RSDQ47RD","service":8,"region":49,"instance_type":188,"os":"Red Hat Enterprise Linux with HA","price_per_unit":27.69024,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
614	301	prices	169	{"sku":"XB75X6XZVDQPNXF9","service":8,"region":49,"instance_type":119,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"XB75X6XZVDQPNXF9","service":8,"region":49,"instance_type":119,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
615	302	instance_types	189	{"name":"u-6tb1.56xlarge","service":8,"vcpu":"224","memory":"6144 GiB"}	{"name":"u-6tb1.56xlarge","service":8,"vcpu":"224","memory":"6144 GiB"}	\N	\N
616	303	prices	170	{"sku":"2WAUN9BJG8MTV3GA","service":8,"region":49,"instance_type":189,"os":"SUSE","price_per_unit":61.91954,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"2WAUN9BJG8MTV3GA","service":8,"region":49,"instance_type":189,"os":"SUSE","price_per_unit":61.91954,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
617	304	instance_types	190	{"name":"c5.4xlarge","service":8,"vcpu":"16","memory":"32 GiB"}	{"name":"c5.4xlarge","service":8,"vcpu":"16","memory":"32 GiB"}	\N	\N
618	305	prices	171	{"sku":"NXU7MWETB2QC9WZ8","service":8,"region":49,"instance_type":190,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"NXU7MWETB2QC9WZ8","service":8,"region":49,"instance_type":190,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
619	306	instance_types	191	{"name":"r5n.24xlarge","service":8,"vcpu":"96","memory":"768 GiB"}	{"name":"r5n.24xlarge","service":8,"vcpu":"96","memory":"768 GiB"}	\N	\N
620	307	prices	172	{"sku":"6XRG6BH97J434ZY9","service":8,"region":49,"instance_type":191,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"6XRG6BH97J434ZY9","service":8,"region":49,"instance_type":191,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
621	308	prices	173	{"sku":"RXPFJURUW497KRHS","service":8,"region":49,"instance_type":167,"os":"RHEL","price_per_unit":5.834,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"RXPFJURUW497KRHS","service":8,"region":49,"instance_type":167,"os":"RHEL","price_per_unit":5.834,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
622	309	instance_types	192	{"name":"i4i.32xlarge","service":8,"vcpu":"128","memory":"1024 GiB"}	{"name":"i4i.32xlarge","service":8,"vcpu":"128","memory":"1024 GiB"}	\N	\N
623	310	prices	174	{"sku":"5J8R9CVJ7FCUYBSB","service":8,"region":49,"instance_type":192,"os":"Windows","price_per_unit":14.432,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"5J8R9CVJ7FCUYBSB","service":8,"region":49,"instance_type":192,"os":"Windows","price_per_unit":14.432,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
624	311	instance_types	193	{"name":"r5n.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	{"name":"r5n.4xlarge","service":8,"vcpu":"16","memory":"128 GiB"}	\N	\N
625	312	prices	175	{"sku":"5D2YX6RM4EWJQMMZ","service":8,"region":49,"instance_type":193,"os":"Windows","price_per_unit":2.421,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"5D2YX6RM4EWJQMMZ","service":8,"region":49,"instance_type":193,"os":"Windows","price_per_unit":2.421,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
626	313	instance_types	194	{"name":"g4dn.2xlarge","service":8,"vcpu":"8","memory":"32 GiB"}	{"name":"g4dn.2xlarge","service":8,"vcpu":"8","memory":"32 GiB"}	\N	\N
627	314	prices	176	{"sku":"8Q3R8SG2PYZU9QZE","service":8,"region":49,"instance_type":194,"os":"Linux","price_per_unit":0.998,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"8Q3R8SG2PYZU9QZE","service":8,"region":49,"instance_type":194,"os":"Linux","price_per_unit":0.998,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
628	315	instance_types	195	{"name":"r5.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	{"name":"r5.xlarge","service":8,"vcpu":"4","memory":"32 GiB"}	\N	\N
629	316	prices	177	{"sku":"8H2H3V9GPGG9R8SR","service":8,"region":49,"instance_type":195,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"8H2H3V9GPGG9R8SR","service":8,"region":49,"instance_type":195,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
630	317	prices	178	{"sku":"GJJPU8FUS7JGBV4P","service":8,"region":49,"instance_type":133,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"GJJPU8FUS7JGBV4P","service":8,"region":49,"instance_type":133,"os":"SUSE","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
631	318	prices	179	{"sku":"BZ6WYNNYQ26NFV2H","service":8,"region":49,"instance_type":152,"os":"Windows","price_per_unit":16.64,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"BZ6WYNNYQ26NFV2H","service":8,"region":49,"instance_type":152,"os":"Windows","price_per_unit":16.64,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
632	319	instance_types	196	{"name":"c5.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	{"name":"c5.24xlarge","service":8,"vcpu":"96","memory":"192 GiB"}	\N	\N
633	320	prices	180	{"sku":"S76HTWEBYNTW5JDC","service":8,"region":49,"instance_type":196,"os":"Red Hat Enterprise Linux with HA","price_per_unit":7.853,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	{"sku":"S76HTWEBYNTW5JDC","service":8,"region":49,"instance_type":196,"os":"Red Hat Enterprise Linux with HA","price_per_unit":7.853,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:19:59"}	\N	\N
634	321	prices	181	{"sku":"F9RF43JTQ4CCD5X9","service":8,"region":49,"instance_type":163,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	{"sku":"F9RF43JTQ4CCD5X9","service":8,"region":49,"instance_type":163,"os":"Windows","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	\N	\N
635	322	prices	182	{"sku":"BWPS4WBJ4NA9QDEC","service":8,"region":49,"instance_type":176,"os":"Linux","price_per_unit":1.921,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	{"sku":"BWPS4WBJ4NA9QDEC","service":8,"region":49,"instance_type":176,"os":"Linux","price_per_unit":1.921,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	\N	\N
636	323	instance_types	197	{"name":"i3en.6xlarge","service":8,"vcpu":"24","memory":"192 GiB"}	{"name":"i3en.6xlarge","service":8,"vcpu":"24","memory":"192 GiB"}	\N	\N
637	324	prices	183	{"sku":"ZVCE4PPUWVB7ZRH7","service":8,"region":49,"instance_type":197,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	{"sku":"ZVCE4PPUWVB7ZRH7","service":8,"region":49,"instance_type":197,"os":"Linux","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	\N	\N
638	325	instance_types	198	{"name":"r5d.metal","service":8,"vcpu":"96","memory":"768 GiB"}	{"name":"r5d.metal","service":8,"vcpu":"96","memory":"768 GiB"}	\N	\N
639	326	prices	184	{"sku":"7B5YAYJK4FRVVHWE","service":8,"region":49,"instance_type":198,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	{"sku":"7B5YAYJK4FRVVHWE","service":8,"region":49,"instance_type":198,"os":"Red Hat Enterprise Linux with HA","price_per_unit":0,"unit":"Hrs","currency":"USD","updated_at":"2025-10-02T10:20:00"}	\N	\N
641	328	simulations_simulation_entries	1	{"simulation_entries_id":{"simulation":2,"service":4,"instance_type":122,"quantity":"10","unit":"Euros"},"simulations_id":"2"}	{"simulation_entries_id":{"simulation":2,"service":4,"instance_type":122,"quantity":"10","unit":"Euros"},"simulations_id":"2"}	\N	\N
640	327	simulation_entries	1	{"simulation":2,"service":4,"instance_type":122,"quantity":"10","unit":"Euros"}	{"simulation":2,"service":4,"instance_type":122,"quantity":"10","unit":"Euros"}	641	\N
>>>>>>> f76dcd38 (update files)
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
<<<<<<< HEAD
xi6TFRDzyRaQmgyrga027YLv51B7byKX2IXXzHxwsuOAizeIegUA97njAdtRYqn9	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 13:43:54.995+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
rutD25QeW5W3mwH7w_F6r46NGgfK_r3oV4cjyyCnpJdZYHBMATSQ4Ibuqr2n7BiI	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:48:40.732+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
DUYe9oWFPyhDtUZUFxPjK7t2YJ-2Rj9PmvZ-0VLbH0g7JHH4v5Jw1pC-F9W07ltK	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:32:57.302+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
3ao1ekkjKw1LL4uNIWiJ5VQeTrP2Oh8udIMHNpWpfzjRi7B7HiDZD4h493SXH8Ot	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 15:11:44.1+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
7uAPjz8KpkmdexpJUMnP0M2bplVqaCGaSjZQEeLaDiNd2ZnLu0pWM4_DdcRtVNat	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:59:54.866+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
jmXkyiIcxk6aRHfQhh9O60ByiO2fIhGcjrlYS82duENxVO7p-rRvOkfE-AiI3vXK	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 17:33:40.194+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
wJqpv6vFJrzVzC3joJelzN4XmQgoUpxLqwl32rzj0vkpRh2nFGzQc5e8Xdlej1mZ	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 17:37:32.614+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
IG7DvSFn69QrvOtxlKle97a9hUO3EKNhVwFFEaTX2IaAbfWDVZ8k_lLNS5GuKzR5	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 17:45:00.981+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
hpKZk1YfoClQoQthSteGBoCcpxWAIrPVBivFPFbK7l94fw28RtYvtTLT8MCKOlql	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:00:22.406+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
Fp5aq7WTjDymWIg69A5KmoViIMiMGN6lEMJBeMjRgeaBBixbJcyhu-KARe5Xpi8i	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:14:59.223+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
sE0oUPzwAiZF5m8teZGLTYPUnWdEy1ME1gq3NrxIBNGfefxNzoVricQuvYDOdwan	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:23:55.145+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
U7bUEAwr-7GnHVi-sSb5ZUZHXTcY7r_G5adKGskiAHT7vQYr_M8GaJymz8XkRzVu	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 09:57:17.202+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	\N	http://localhost:8055	qj25zPwIJKQPG_swkB-DnPL344C4cZNyJVjR0b9X504XvwPQIW2hyVdA25bK4SWD
iP5i2o_8BT3pdUzokoYxPLZLI8rjCScOoi-VMvU8Joha3V-Tci2TDc9FFpOP3u2r	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:10:24.189+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
P8jexrHm1xVh_mwW1Tza6Mi4g270TBk2ZnL4sOdZQge_PreNguxjbwxxD4RaIGHJ	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:10:33.14+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
qj25zPwIJKQPG_swkB-DnPL344C4cZNyJVjR0b9X504XvwPQIW2hyVdA25bK4SWD	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-03 09:57:07.201+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	\N	http://localhost:8055	\N
WZcWI_XBjnl6gXL_jMwPP6-yuduOlCb6Uj8Wvx0CFTmKIZmtnOu30xfwugtouZ2w	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:13:08.023+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
Miun5SreoxBobo-8Gl47kXVXDUumorh5id4KmcFTvo39hbfXgXDhiouL21Bk-adX	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 21:14:11.639+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
tGLoIhUZpf4ESzGTM8a1edvOB1leHs5rq7EyZAiVULi1gbHvO_Y_vlrFIEqw-P5P	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:16:19.931+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
ekFiGIyU8KQuzvUm1KZTFC5oHGdcUpROW3GS1Dzpe5TdwjJL5cq3SHGosQ-SUrUe	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:28:32.688+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
=======
rSlLXmwDiPjUk9zPvD1LyO3IFOU7eO_suv2QyBD0guh-xhUloPNjWeVnqT_2RpNd	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 10:20:14.685+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	PzNE-x2--XzComuTZ1gfw7j0zXX35i3wVyLScvJY8z_GMskwPBwWmMWKwYX_xEVA
PzNE-x2--XzComuTZ1gfw7j0zXX35i3wVyLScvJY8z_GMskwPBwWmMWKwYX_xEVA	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-03 10:20:04.685+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	01999fe7-9ac7-751b-8d05-12a3d32a1c9d	f	f	\N	t	\N
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
<<<<<<< HEAD
27fc7a4b-bd46-414c-8883-99f3ae3089df	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$hPFw2a086BrG9B03t6pPxg$HGjy3p+0DAtjm/b7TmkYUPAwr8sk8Fb/+XexTjOQwz0	\N	\N	\N	\N	\N	\N	\N	active	7d7ad24c-6292-497b-9809-ec4d797b1df5	HDIPfe5EAom39iIHwwTbLsPsxUnAX2Pp	2025-10-02 09:57:07.21+00	/content/instance_types	default	\N	\N	t	\N	\N	\N	\N	\N	auto
=======
27fc7a4b-bd46-414c-8883-99f3ae3089df	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$hPFw2a086BrG9B03t6pPxg$HGjy3p+0DAtjm/b7TmkYUPAwr8sk8Fb/+XexTjOQwz0	\N	\N	\N	\N	\N	\N	\N	active	7d7ad24c-6292-497b-9809-ec4d797b1df5	sqdI9gHDEUicFil6PLCM2lC9mmYRMqpK	2025-10-02 10:20:04.694+00	/content/instance_types	default	\N	\N	t	\N	\N	\N	\N	\N	auto
>>>>>>> f76dcd38 (update files)
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

<<<<<<< HEAD
COPY public.instance_types (id, name, service, vcpu, memory, category) FROM stdin;
116	x2idn.metal	8	128	2048 GiB	\N
117	c5d.metal	8	96	192 GiB	\N
118	c5d.24xlarge	8	96	192 GiB	\N
119	r5dn.12xlarge	8	48	384 GiB	\N
120	m6i.large	8	2	8 GiB	\N
121	m5.xlarge	8	4	16 GiB	\N
122	m6i.xlarge	8	4	16 GiB	\N
123	c6g.metal	8	64	128 GiB	\N
124	d2.8xlarge	8	36	244 GiB	\N
45	x2idn.metal	\N	128	2048 GiB	\N
46	c5d.metal	\N	96	192 GiB	\N
47	c5d.24xlarge	\N	96	192 GiB	\N
48	r5dn.12xlarge	\N	48	384 GiB	\N
49	m6i.large	\N	2	8 GiB	\N
50	m5.xlarge	\N	4	16 GiB	\N
51	m6i.xlarge	\N	4	16 GiB	\N
52	c6g.metal	\N	64	128 GiB	\N
53	d2.8xlarge	\N	36	244 GiB	\N
54	i4i.2xlarge	\N	8	64 GiB	\N
55	c6in.16xlarge	\N	64	128 GiB	\N
56	i3en.large	\N	2	16 GiB	\N
57	c6i.32xlarge	\N	128	256 GiB	\N
58	r5dn.large	\N	2	16 GiB	\N
59	c6in.xlarge	\N	4	8 GiB	\N
60	c5a.12xlarge	\N	48	96 GiB	\N
61	inf1.24xlarge	\N	96	192 GiB	\N
62	r5dn.xlarge	\N	4	32 GiB	\N
63	x2idn.32xlarge	\N	128	2048 GiB	\N
64	u-6tb1.112xlarge	\N	448	6144 GiB	\N
65	c6in.12xlarge	\N	48	96 GiB	\N
66	i3en.metal	\N	96	768 GiB	\N
67	c6g.xlarge	\N	4	8 GiB	\N
68	i4i.metal	\N	128	1024 GiB	\N
69	r5n.8xlarge	\N	32	256 GiB	\N
70	m5d.2xlarge	\N	8	32 GiB	\N
71	c6i.16xlarge	\N	64	128 GiB	\N
72	r5dn.8xlarge	\N	32	256 GiB	\N
73	c5a.4xlarge	\N	16	32 GiB	\N
74	m6g.large	\N	2	8 GiB	\N
75	c5a.large	\N	2	4 GiB	\N
76	r5dn.16xlarge	\N	64	512 GiB	\N
77	i4i.large	\N	2	16 GiB	\N
78	c5.metal	\N	96	192 GiB	\N
79	m5d.8xlarge	\N	32	128 GiB	\N
80	i3en.2xlarge	\N	8	64 GiB	\N
81	r6i.metal	\N	128	1024 GiB	\N
82	m5.12xlarge	\N	48	192 GiB	\N
83	x1.32xlarge	\N	128	1952 GiB	\N
84	r7g.medium	\N	1	8 GiB	\N
85	c6i.4xlarge	\N	16	32 GiB	\N
86	c6i.24xlarge	\N	96	192 GiB	\N
87	m5.8xlarge	\N	32	128 GiB	\N
88	x1e.4xlarge	\N	16	488 GiB	\N
89	c6g.2xlarge	\N	8	16 GiB	\N
90	r5d.16xlarge	\N	64	512 GiB	\N
91	c6in.large	\N	2	4 GiB	\N
92	c6in.24xlarge	\N	96	192 GiB	\N
93	r5dn.2xlarge	\N	8	64 GiB	\N
94	r7gd.2xlarge	\N	8	64 GiB	\N
95	r5d.8xlarge	\N	32	256 GiB	\N
96	c5a.8xlarge	\N	32	64 GiB	\N
97	c5.large	\N	2	4 GiB	\N
98	c5a.16xlarge	\N	64	128 GiB	\N
99	i3en.xlarge	\N	4	32 GiB	\N
100	i3en.24xlarge	\N	96	768 GiB	\N
101	m6i.8xlarge	\N	32	128 GiB	\N
102	r6i.8xlarge	\N	32	256 GiB	\N
103	r5d.2xlarge	\N	8	64 GiB	\N
104	r6g.12xlarge	\N	48	384 GiB	\N
105	r5n.xlarge	\N	4	32 GiB	\N
106	r5dn.4xlarge	\N	16	128 GiB	\N
107	c5.9xlarge	\N	36	72 GiB	\N
108	m5d.12xlarge	\N	48	192 GiB	\N
109	r7gd.large	\N	2	16 GiB	\N
110	x2iedn.8xlarge	\N	32	1024 GiB	\N
111	r7gd.16xlarge	\N	64	512 GiB	\N
112	i4i.4xlarge	\N	16	128 GiB	\N
113	c5d.18xlarge	\N	72	144 GiB	\N
114	r7gd.4xlarge	\N	16	128 GiB	\N
115	c5n.metal	\N	72	192 GiB	\N
=======
COPY public.instance_types (id, name, service) FROM stdin;
116	x2idn.metal	8
117	c5d.metal	8
118	c5d.24xlarge	8
119	r5dn.12xlarge	8
120	m6i.large	8
121	m5.xlarge	8
122	m6i.xlarge	8
123	c6g.metal	8
124	d2.8xlarge	8
125	i4i.2xlarge	8
126	c6in.16xlarge	8
127	i3en.large	8
128	c6i.32xlarge	8
129	r5dn.large	8
130	c6in.xlarge	8
131	c5a.12xlarge	8
132	inf1.24xlarge	8
133	r5dn.xlarge	8
134	x2idn.32xlarge	8
135	u-6tb1.112xlarge	8
136	c6in.12xlarge	8
137	i3en.metal	8
138	c6g.xlarge	8
139	i4i.metal	8
140	r5n.8xlarge	8
141	m5d.2xlarge	8
142	c6i.16xlarge	8
143	r5dn.8xlarge	8
144	c5a.4xlarge	8
145	m6g.large	8
146	c5a.large	8
147	r5dn.16xlarge	8
148	i4i.large	8
149	c5.metal	8
150	m5d.8xlarge	8
151	i3en.2xlarge	8
152	r6i.metal	8
153	m5.12xlarge	8
154	x1.32xlarge	8
155	r7g.medium	8
156	c6i.4xlarge	8
157	c6i.24xlarge	8
158	m5.8xlarge	8
159	x1e.4xlarge	8
160	c6g.2xlarge	8
161	r5d.16xlarge	8
162	c6in.large	8
163	c6in.24xlarge	8
164	r5dn.2xlarge	8
165	r7gd.2xlarge	8
166	r5d.8xlarge	8
167	c5a.8xlarge	8
168	c5.large	8
169	c5a.16xlarge	8
170	i3en.xlarge	8
171	i3en.24xlarge	8
172	m6i.8xlarge	8
173	r6i.8xlarge	8
174	r5d.2xlarge	8
175	r6g.12xlarge	8
176	r5n.xlarge	8
177	r5dn.4xlarge	8
178	c5.9xlarge	8
179	m5d.12xlarge	8
180	r7gd.large	8
181	x2iedn.8xlarge	8
182	r7gd.16xlarge	8
183	i4i.4xlarge	8
184	c5d.18xlarge	8
185	r7gd.4xlarge	8
186	c5n.metal	8
187	c5n.2xlarge	8
188	c6in.32xlarge	8
189	u-6tb1.56xlarge	8
190	c5.4xlarge	8
191	r5n.24xlarge	8
192	i4i.32xlarge	8
193	r5n.4xlarge	8
194	g4dn.2xlarge	8
195	r5.xlarge	8
196	c5.24xlarge	8
197	i3en.6xlarge	8
198	r5d.metal	8
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: prices; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.prices (id, sku, service, region, instance_type, os, price_per_unit, created_at, updated_at) FROM stdin;
<<<<<<< HEAD
1	ASAJBV2BNW4TK2AC	8	15	45	Windows	0	\N	2025-10-02 10:14:04.795
2	2MJHSZ8K32A878HY	8	15	46	Windows	4.416	\N	2025-10-02 10:14:04.828
10	BBSEDDW6NBJA7BKC	\N	15	53	Windows	0	\N	2025-10-01 22:50:44.73
11	F4T76YYBGENXKG25	\N	15	54	Windows	0	\N	2025-10-01 22:50:44.758
12	ZDF83CTQAU8SE5XQ	\N	15	55	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:44.788
13	2RZRZY3PKHFCV2UU	\N	15	56	Linux	0.365	\N	2025-10-01 22:50:44.816
14	D5JZ2YUV4KKDHT2T	\N	15	57	Windows	13.184	\N	2025-10-01 22:50:44.845
15	ZAPMFFJKRJU3R5CF	\N	15	58	Linux	0.2886	\N	2025-10-01 22:50:44.875
16	MQSEQKYJG3J7XAJA	\N	15	59	Windows	0.48892	\N	2025-10-01 22:50:44.903
17	K3SMWU6AY3HECJDP	\N	15	60	Linux	8.479	\N	2025-10-01 22:50:44.936
18	46XDJYY2FHPQK86E	\N	15	61	Linux	6.249	\N	2025-10-01 22:50:44.97
19	DCCMGMP4QWH42S22	\N	15	62	Windows	0.442	\N	2025-10-01 22:50:45.002
20	M24YR38EZ3RCKNV6	\N	15	63	Windows	40.296	\N	2025-10-01 22:50:45.033
21	M226ANPSW5N2ZUUA	\N	15	64	RHEL	77.0098	\N	2025-10-01 22:50:45.063
22	F4VQX8TVBFBDJT8F	\N	15	65	Linux	3.65904	\N	2025-10-01 22:50:45.096
23	EY7WB9D3MPP74S3V	\N	15	66	Linux	14.256	\N	2025-10-01 22:50:45.125
24	SKQ7V8BYARK8QPWC	\N	15	67	SUSE	0.2496	\N	2025-10-01 22:50:45.161
25	VUJWJ43YRA549PU4	\N	15	68	Ubuntu Pro	14.656	\N	2025-10-01 22:50:45.196
26	5AP4B6TES68GAMNF	\N	15	69	SUSE	3.304	\N	2025-10-01 22:50:45.226
27	8MKAA6VT83UZQFP5	\N	15	70	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:45.257
28	73MPNA62D9M89QF4	\N	15	71	RHEL	0	\N	2025-10-01 22:50:45.287
29	XW8GAV8E42N3F476	\N	15	72	Windows	17.008	\N	2025-10-01 22:50:45.317
30	59VZZCB8WVKHFH9V	\N	15	73	Linux	0	\N	2025-10-01 22:50:45.348
31	R38YQE2VV7GA9G7Y	\N	15	74	Linux	0.1016	\N	2025-10-01 22:50:45.376
32	W8DWGGQKZBVAN92Z	\N	15	75	Linux	0.171	\N	2025-10-01 22:50:45.403
33	NSBFZXBV9Z632WFE	\N	15	48	Linux	5.62224	\N	2025-10-01 22:50:45.425
34	YR6NWE8T4FCV9YCS	\N	15	76	Windows	11.0976	\N	2025-10-01 22:50:45.456
35	TCUF4AQ6VRAFT3QN	\N	15	77	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:45.484
36	YYG8EUQR4PQSEJDU	\N	15	78	Windows	5.472	\N	2025-10-01 22:50:45.513
37	UNFU8GZARWXJSEY2	\N	15	79	Ubuntu Pro	2.6	\N	2025-10-01 22:50:45.54
38	6789AM2FPAFYK6DH	\N	15	80	Windows	1.265	\N	2025-10-01 22:50:45.57
39	K64RPFBV2R3WU6KM	\N	15	81	Linux	10.752	\N	2025-10-01 22:50:45.597
40	7WB5V3H76287EU5S	\N	15	82	Windows	5.256	\N	2025-10-01 22:50:45.623
41	TTFAMWM9C75AKH8B	\N	15	70	Windows	1.004	\N	2025-10-01 22:50:45.642
42	VA5SUTF8FP8N3AXN	\N	15	83	RHEL	0	\N	2025-10-01 22:50:45.671
43	SAA526WFDWBR8DKJ	\N	15	84	Ubuntu Pro	0.0732	\N	2025-10-01 22:50:45.7
44	SRKPZJTPF33QB59X	\N	15	85	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:45.729
45	DMK6SQHM6DH8WT5W	\N	15	86	SUSE	5.597	\N	2025-10-01 22:50:45.754
46	XJGBGA7YH2P82QTY	\N	15	87	Windows	0	\N	2025-10-01 22:50:45.785
47	K5R438HR4MPH2ETV	\N	15	88	Linux	0	\N	2025-10-01 22:50:45.812
48	GGE9SKRP5EH6ACVP	\N	15	89	Red Hat Enterprise Linux with HA	0.62	\N	2025-10-01 22:50:45.838
49	224TXKFMK98VD2H8	\N	15	90	Ubuntu Pro	0	\N	2025-10-01 22:50:45.867
50	N2PWZHQJM7CUE2TC	\N	15	91	SUSE	0	\N	2025-10-01 22:50:45.896
51	QBGHQAG9TXN2XRJD	\N	15	92	RHEL	44.35488	\N	2025-10-01 22:50:45.92
52	YMSW32ECA33XM27M	\N	15	93	Windows	0	\N	2025-10-01 22:50:45.947
53	QP28KQ4KEYYBW6ZG	\N	15	94	RHEL	0.8334	\N	2025-10-01 22:50:45.975
54	62BDZCJBE2GU364K	\N	15	95	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:46.004
55	AJKXPN4NGVUKNQRT	\N	15	96	RHEL	2.699	\N	2025-10-01 22:50:46.031
56	D5XUX8VW63W4VRH7	\N	15	97	Ubuntu Pro	0.118	\N	2025-10-01 22:50:46.058
57	RF9QAKYUZUBPYKQY	\N	15	98	RHEL	11.667	\N	2025-10-01 22:50:46.088
58	PRFRZD5R8C7ZVWK3	\N	15	51	Windows	0	\N	2025-10-01 22:50:46.107
59	HEVRVMP9YZFBURXS	\N	15	99	RHEL	0	\N	2025-10-01 22:50:46.133
60	4M98HYM3J5Z46AWP	\N	15	100	Linux	15.878	\N	2025-10-01 22:50:46.16
61	AU72RP7VJUVCNDRH	\N	15	101	Red Hat Enterprise Linux with HA	3.0288	\N	2025-10-01 22:50:46.185
62	F8HJ3NCTTYKMEJWH	\N	15	80	RHEL	1.303	\N	2025-10-01 22:50:46.206
63	KV6EJ6STDMSYT892	\N	15	102	RHEL	3.5744	\N	2025-10-01 22:50:46.231
64	ZDA867EN25M7J2RP	\N	15	80	SUSE	1.39	\N	2025-10-01 22:50:46.251
65	S527DJBR37ZD82WG	\N	15	53	Ubuntu Pro	7.063	\N	2025-10-01 22:50:46.272
66	6GV6TRXN67XJK43Q	\N	15	103	Windows	1.309	\N	2025-10-01 22:50:46.298
67	5QQ3CDA54WA4SF89	\N	15	104	Ubuntu Pro	3.3096	\N	2025-10-01 22:50:46.322
68	DBV2CP3SH6SW44EJ	\N	15	105	Windows	0.581	\N	2025-10-01 22:50:46.351
69	C5TUM9HCPAEYJS3Y	\N	15	106	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:46.381
70	BXY45PCG93MXNU65	\N	15	107	RHEL	0	\N	2025-10-01 22:50:46.421
71	Q43N23NMCM5M72TG	\N	15	108	Linux	9.576	\N	2025-10-01 22:50:46.45
72	AHGDT97G6TSZY3SX	\N	15	109	SUSE	0	\N	2025-10-01 22:50:46.481
73	4ECE9GMJ3XCHYWXS	\N	15	110	Linux	9.524	\N	2025-10-01 22:50:46.507
74	JPVM2NP8RXVNH2ES	\N	15	76	Windows	34.44032	\N	2025-10-01 22:50:46.526
75	YZBMDYPK7FXSPVFF	\N	15	111	SUSE	5.8706	\N	2025-10-01 22:50:46.552
76	CA9QFRR9YHNGZGB6	\N	15	112	Windows	4.46	\N	2025-10-01 22:50:46.577
77	7BYP5K2BRPMUATMR	\N	15	47	Linux	0	\N	2025-10-01 22:50:46.617
78	ZNJNEUVD6GRC3GC2	\N	15	113	RHEL	5.458	\N	2025-10-01 22:50:46.645
79	5KJPAHP28X5BGQ4X	\N	15	84	Red Hat Enterprise Linux with HA	0	\N	2025-10-01 22:50:46.667
80	HQF26CEJ4NE23PK7	\N	15	114	SUSE	0	\N	2025-10-01 22:50:46.692
81	83XBVTQ5MSFD6UW6	\N	15	72	Linux	0	\N	2025-10-01 22:50:46.709
82	ZW5282D6EZE2PRNV	\N	15	54	Linux	1.127	\N	2025-10-01 22:50:46.729
4	JJC7VV7EUWNQ7U7V	8	15	48	Linux	0	\N	2025-10-02 10:14:04.877
5	4Y3K6MNSSJUDKTS2	8	15	49	Windows	0.699	\N	2025-10-02 10:14:04.91
3	MQRX2N7GEX3K5BPR	8	15	47	RHEL	7.277	\N	2025-10-02 10:14:04.853
6	CMBYZZ3KTUNXB2MQ	8	15	50	Linux	0.322	\N	2025-10-02 10:14:04.942
7	CS2EAT4BBKX282YT	8	15	51	Ubuntu Pro	0.261	\N	2025-10-02 10:14:04.976
8	EUNMXQYZDDD3SU8N	8	15	52	SUSE	3.0434	\N	2025-10-02 10:14:05.019
9	2KKVCKPSRZ69KDT8	8	15	46	Windows	0	\N	2025-10-02 10:14:05.044
=======
83	ASAJBV2BNW4TK2AC	8	49	116	Windows	0	\N	2025-10-02 10:19:54.362
84	2MJHSZ8K32A878HY	8	49	117	Windows	4.416	\N	2025-10-02 10:19:54.435
85	MQRX2N7GEX3K5BPR	8	49	118	RHEL	7.277	\N	2025-10-02 10:19:54.492
86	JJC7VV7EUWNQ7U7V	8	49	119	Linux	0	\N	2025-10-02 10:19:54.55
87	4Y3K6MNSSJUDKTS2	8	49	120	Windows	0.699	\N	2025-10-02 10:19:54.605
88	CMBYZZ3KTUNXB2MQ	8	49	121	Linux	0.322	\N	2025-10-02 10:19:54.658
89	CS2EAT4BBKX282YT	8	49	122	Ubuntu Pro	0.261	\N	2025-10-02 10:19:54.712
90	EUNMXQYZDDD3SU8N	8	49	123	SUSE	3.0434	\N	2025-10-02 10:19:54.772
91	2KKVCKPSRZ69KDT8	8	49	117	Windows	0	\N	2025-10-02 10:19:54.822
92	BBSEDDW6NBJA7BKC	8	49	124	Windows	0	\N	2025-10-02 10:19:54.891
93	F4T76YYBGENXKG25	8	49	125	Windows	0	\N	2025-10-02 10:19:54.954
94	ZDF83CTQAU8SE5XQ	8	49	126	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:55.022
95	2RZRZY3PKHFCV2UU	8	49	127	Linux	0.365	\N	2025-10-02 10:19:55.092
96	D5JZ2YUV4KKDHT2T	8	49	128	Windows	13.184	\N	2025-10-02 10:19:55.228
97	ZAPMFFJKRJU3R5CF	8	49	129	Linux	0.2886	\N	2025-10-02 10:19:55.372
98	MQSEQKYJG3J7XAJA	8	49	130	Windows	0.48892	\N	2025-10-02 10:19:55.447
99	K3SMWU6AY3HECJDP	8	49	131	Linux	8.479	\N	2025-10-02 10:19:55.525
100	46XDJYY2FHPQK86E	8	49	132	Linux	6.249	\N	2025-10-02 10:19:55.585
101	DCCMGMP4QWH42S22	8	49	133	Windows	0.442	\N	2025-10-02 10:19:55.658
102	M24YR38EZ3RCKNV6	8	49	134	Windows	40.296	\N	2025-10-02 10:19:55.732
103	M226ANPSW5N2ZUUA	8	49	135	RHEL	77.0098	\N	2025-10-02 10:19:55.781
104	F4VQX8TVBFBDJT8F	8	49	136	Linux	3.65904	\N	2025-10-02 10:19:55.836
105	EY7WB9D3MPP74S3V	8	49	137	Linux	14.256	\N	2025-10-02 10:19:55.893
106	SKQ7V8BYARK8QPWC	8	49	138	SUSE	0.2496	\N	2025-10-02 10:19:55.953
107	VUJWJ43YRA549PU4	8	49	139	Ubuntu Pro	14.656	\N	2025-10-02 10:19:56.017
108	5AP4B6TES68GAMNF	8	49	140	SUSE	3.304	\N	2025-10-02 10:19:56.081
109	8MKAA6VT83UZQFP5	8	49	141	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:56.141
110	73MPNA62D9M89QF4	8	49	142	RHEL	0	\N	2025-10-02 10:19:56.215
111	XW8GAV8E42N3F476	8	49	143	Windows	17.008	\N	2025-10-02 10:19:56.283
112	59VZZCB8WVKHFH9V	8	49	144	Linux	0	\N	2025-10-02 10:19:56.347
113	R38YQE2VV7GA9G7Y	8	49	145	Linux	0.1016	\N	2025-10-02 10:19:56.399
114	W8DWGGQKZBVAN92Z	8	49	146	Linux	0.171	\N	2025-10-02 10:19:56.449
115	NSBFZXBV9Z632WFE	8	49	119	Linux	5.62224	\N	2025-10-02 10:19:56.486
116	YR6NWE8T4FCV9YCS	8	49	147	Windows	11.0976	\N	2025-10-02 10:19:56.537
117	TCUF4AQ6VRAFT3QN	8	49	148	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:56.591
118	YYG8EUQR4PQSEJDU	8	49	149	Windows	5.472	\N	2025-10-02 10:19:56.644
119	UNFU8GZARWXJSEY2	8	49	150	Ubuntu Pro	2.6	\N	2025-10-02 10:19:56.705
120	6789AM2FPAFYK6DH	8	49	151	Windows	1.265	\N	2025-10-02 10:19:56.762
121	K64RPFBV2R3WU6KM	8	49	152	Linux	10.752	\N	2025-10-02 10:19:56.815
122	7WB5V3H76287EU5S	8	49	153	Windows	5.256	\N	2025-10-02 10:19:56.866
123	TTFAMWM9C75AKH8B	8	49	141	Windows	1.004	\N	2025-10-02 10:19:56.907
124	VA5SUTF8FP8N3AXN	8	49	154	RHEL	0	\N	2025-10-02 10:19:56.963
125	SAA526WFDWBR8DKJ	8	49	155	Ubuntu Pro	0.0732	\N	2025-10-02 10:19:57.016
126	SRKPZJTPF33QB59X	8	49	156	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:57.066
127	DMK6SQHM6DH8WT5W	8	49	157	SUSE	5.597	\N	2025-10-02 10:19:57.119
128	XJGBGA7YH2P82QTY	8	49	158	Windows	0	\N	2025-10-02 10:19:57.174
129	K5R438HR4MPH2ETV	8	49	159	Linux	0	\N	2025-10-02 10:19:57.233
130	GGE9SKRP5EH6ACVP	8	49	160	Red Hat Enterprise Linux with HA	0.62	\N	2025-10-02 10:19:57.291
131	224TXKFMK98VD2H8	8	49	161	Ubuntu Pro	0	\N	2025-10-02 10:19:57.348
132	N2PWZHQJM7CUE2TC	8	49	162	SUSE	0	\N	2025-10-02 10:19:57.399
133	QBGHQAG9TXN2XRJD	8	49	163	RHEL	44.35488	\N	2025-10-02 10:19:57.449
134	YMSW32ECA33XM27M	8	49	164	Windows	0	\N	2025-10-02 10:19:57.499
135	QP28KQ4KEYYBW6ZG	8	49	165	RHEL	0.8334	\N	2025-10-02 10:19:57.55
136	62BDZCJBE2GU364K	8	49	166	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:57.603
137	AJKXPN4NGVUKNQRT	8	49	167	RHEL	2.699	\N	2025-10-02 10:19:57.661
138	D5XUX8VW63W4VRH7	8	49	168	Ubuntu Pro	0.118	\N	2025-10-02 10:19:57.706
139	RF9QAKYUZUBPYKQY	8	49	169	RHEL	11.667	\N	2025-10-02 10:19:57.756
140	PRFRZD5R8C7ZVWK3	8	49	122	Windows	0	\N	2025-10-02 10:19:57.792
141	HEVRVMP9YZFBURXS	8	49	170	RHEL	0	\N	2025-10-02 10:19:57.847
142	4M98HYM3J5Z46AWP	8	49	171	Linux	15.878	\N	2025-10-02 10:19:57.909
143	AU72RP7VJUVCNDRH	8	49	172	Red Hat Enterprise Linux with HA	3.0288	\N	2025-10-02 10:19:57.965
144	F8HJ3NCTTYKMEJWH	8	49	151	RHEL	1.303	\N	2025-10-02 10:19:58.007
145	KV6EJ6STDMSYT892	8	49	173	RHEL	3.5744	\N	2025-10-02 10:19:58.063
146	ZDA867EN25M7J2RP	8	49	151	SUSE	1.39	\N	2025-10-02 10:19:58.105
147	S527DJBR37ZD82WG	8	49	124	Ubuntu Pro	7.063	\N	2025-10-02 10:19:58.143
148	6GV6TRXN67XJK43Q	8	49	174	Windows	1.309	\N	2025-10-02 10:19:58.194
149	5QQ3CDA54WA4SF89	8	49	175	Ubuntu Pro	3.3096	\N	2025-10-02 10:19:58.247
150	DBV2CP3SH6SW44EJ	8	49	176	Windows	0.581	\N	2025-10-02 10:19:58.301
151	C5TUM9HCPAEYJS3Y	8	49	177	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:58.356
152	BXY45PCG93MXNU65	8	49	178	RHEL	0	\N	2025-10-02 10:19:58.413
153	Q43N23NMCM5M72TG	8	49	179	Linux	9.576	\N	2025-10-02 10:19:58.466
154	AHGDT97G6TSZY3SX	8	49	180	SUSE	0	\N	2025-10-02 10:19:58.542
155	4ECE9GMJ3XCHYWXS	8	49	181	Linux	9.524	\N	2025-10-02 10:19:58.595
156	JPVM2NP8RXVNH2ES	8	49	147	Windows	34.44032	\N	2025-10-02 10:19:58.635
157	YZBMDYPK7FXSPVFF	8	49	182	SUSE	5.8706	\N	2025-10-02 10:19:58.69
158	CA9QFRR9YHNGZGB6	8	49	183	Windows	4.46	\N	2025-10-02 10:19:58.747
159	7BYP5K2BRPMUATMR	8	49	118	Linux	0	\N	2025-10-02 10:19:58.785
160	ZNJNEUVD6GRC3GC2	8	49	184	RHEL	5.458	\N	2025-10-02 10:19:58.841
161	5KJPAHP28X5BGQ4X	8	49	155	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:19:58.889
162	HQF26CEJ4NE23PK7	8	49	185	SUSE	0	\N	2025-10-02 10:19:58.96
163	83XBVTQ5MSFD6UW6	8	49	143	Linux	0	\N	2025-10-02 10:19:59.008
164	ZW5282D6EZE2PRNV	8	49	125	Linux	1.127	\N	2025-10-02 10:19:59.065
165	95669NRQQM74ZAWS	8	49	186	Linux	0	\N	2025-10-02 10:19:59.13
166	VMHZR5M5JUMHX9XG	8	49	151	Windows	1.188	\N	2025-10-02 10:19:59.177
167	UHREPRNVQBWTSKC9	8	49	187	RHEL	0	\N	2025-10-02 10:19:59.254
168	RP868NF4RSDQ47RD	8	49	188	Red Hat Enterprise Linux with HA	27.69024	\N	2025-10-02 10:19:59.353
169	XB75X6XZVDQPNXF9	8	49	119	Windows	0	\N	2025-10-02 10:19:59.403
170	2WAUN9BJG8MTV3GA	8	49	189	SUSE	61.91954	\N	2025-10-02 10:19:59.462
171	NXU7MWETB2QC9WZ8	8	49	190	Linux	0	\N	2025-10-02 10:19:59.516
172	6XRG6BH97J434ZY9	8	49	191	Windows	0	\N	2025-10-02 10:19:59.574
173	RXPFJURUW497KRHS	8	49	167	RHEL	5.834	\N	2025-10-02 10:19:59.617
174	5J8R9CVJ7FCUYBSB	8	49	192	Windows	14.432	\N	2025-10-02 10:19:59.679
175	5D2YX6RM4EWJQMMZ	8	49	193	Windows	2.421	\N	2025-10-02 10:19:59.741
176	8Q3R8SG2PYZU9QZE	8	49	194	Linux	0.998	\N	2025-10-02 10:19:59.804
177	8H2H3V9GPGG9R8SR	8	49	195	Windows	0	\N	2025-10-02 10:19:59.859
178	GJJPU8FUS7JGBV4P	8	49	133	SUSE	0	\N	2025-10-02 10:19:59.898
179	BZ6WYNNYQ26NFV2H	8	49	152	Windows	16.64	\N	2025-10-02 10:19:59.939
180	S76HTWEBYNTW5JDC	8	49	196	Red Hat Enterprise Linux with HA	7.853	\N	2025-10-02 10:19:59.992
181	F9RF43JTQ4CCD5X9	8	49	163	Windows	0	\N	2025-10-02 10:20:00.034
182	BWPS4WBJ4NA9QDEC	8	49	176	Linux	1.921	\N	2025-10-02 10:20:00.078
183	ZVCE4PPUWVB7ZRH7	8	49	197	Linux	0	\N	2025-10-02 10:20:00.128
184	7B5YAYJK4FRVVHWE	8	49	198	Red Hat Enterprise Linux with HA	0	\N	2025-10-02 10:20:00.183
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.recommendations (id, simulation_id, resource_id, type, prioprity, title, description, current_cost, optimized_cost, potential_savings, implementation_effort, applied, created_at) FROM stdin;
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: directus
--

<<<<<<< HEAD
COPY public.regions (id, name, code, country) FROM stdin;
11	US East (N. Virginia)	us-east-1	USA
12	US East (Ohio)	us-east-2	USA
13	US West (N. California)	us-west-1	USA
14	US West (Oregon)	us-west-2	USA
15	Africa (Cape Town)	af-south-1	South Africa
16	Asia Pacific (Hong Kong)	ap-east-1	Hong Kong
17	Asia Pacific (Hyderabad)	ap-south-2	India
18	Asia Pacific (Jakarta)	ap-southeast-3	Indonesia
19	Asia Pacific (Malaysia)	ap-southeast-5	Malaysia
20	Asia Pacific (Melbourne)	ap-southeast-4	Australia
21	Asia Pacific (Mumbai)	ap-south-1	India
22	Asia Pacific (New Zealand)	ap-southeast-6	New Zealand
23	Asia Pacific (Osaka)	ap-northeast-3	Japan
24	Asia Pacific (Seoul)	ap-northeast-2	South Korea
25	Asia Pacific (Singapore)	ap-southeast-1	Singapore
26	Asia Pacific (Sydney)	ap-southeast-2	Australia
27	Asia Pacific (Taipei)	ap-east-2	Taiwan
28	Asia Pacific (Thailand)	ap-southeast-7	Thailand
29	Asia Pacific (Tokyo)	ap-northeast-1	Japan
30	Canada (Central)	ca-central-1	Canada
31	Canada West (Calgary)	ca-west-1	Canada
32	Europe (Frankfurt)	eu-central-1	Germany
33	Europe (Ireland)	eu-west-1	Ireland
34	Europe (London)	eu-west-2	UK
35	Europe (Milan)	eu-south-1	Italy
36	Europe (Paris)	eu-west-3	France
37	Europe (Spain)	eu-south-2	Spain
38	Europe (Stockholm)	eu-north-1	Sweden
39	Europe (Zurich)	eu-central-2	Switzerland
40	Israel (Tel Aviv)	il-central-1	Israel
41	Mexico (Central)	mx-central-1	Mexico
42	Middle East (Bahrain)	me-south-1	Bahrain
43	Middle East (UAE)	me-central-1	United Arab Emirates
44	South America (São Paulo)	sa-east-1	Brazil
=======
COPY public.regions (id, name, code) FROM stdin;
1	US East (N. Virginia)	\tus-east-1
2	US West (Oregon)	 us-west-2
3	EU (Ireland)\t	 eu-west-1
4	EU (Frankfurt)\t	 eu-central-1
5	EU (Paris)\t	 eu-west-3
6	Asia Pacific (Tokyo)\t	 ap-northeast-1
7	Asia Pacific (Singapore)\t	 ap-southeast-1
45	US East (N. Virginia)	us-east-1
46	US East (Ohio)	us-east-2
47	US West (N. California)	us-west-1
48	US West (Oregon)	us-west-2
49	Africa (Cape Town)	af-south-1
50	Asia Pacific (Hong Kong)	ap-east-1
51	Asia Pacific (Hyderabad)	ap-south-2
52	Asia Pacific (Jakarta)	ap-southeast-3
53	Asia Pacific (Malaysia)	ap-southeast-5
54	Asia Pacific (Melbourne)	ap-southeast-4
55	Asia Pacific (Mumbai)	ap-south-1
56	Asia Pacific (New Zealand)	ap-southeast-6
57	Asia Pacific (Osaka)	ap-northeast-3
58	Asia Pacific (Seoul)	ap-northeast-2
59	Asia Pacific (Singapore)	ap-southeast-1
60	Asia Pacific (Sydney)	ap-southeast-2
61	Asia Pacific (Taipei)	ap-east-2
62	Asia Pacific (Thailand)	ap-southeast-7
63	Asia Pacific (Tokyo)	ap-northeast-1
64	Canada (Central)	ca-central-1
65	Canada West (Calgary)	ca-west-1
66	Europe (Frankfurt)	eu-central-1
67	Europe (Ireland)	eu-west-1
68	Europe (London)	eu-west-2
69	Europe (Milan)	eu-south-1
70	Europe (Paris)	eu-west-3
71	Europe (Spain)	eu-south-2
72	Europe (Stockholm)	eu-north-1
73	Europe (Zurich)	eu-central-2
74	Israel (Tel Aviv)	il-central-1
75	Mexico (Central)	mx-central-1
76	Middle East (Bahrain)	me-south-1
77	Middle East (UAE)	me-central-1
78	South America (São Paulo)	sa-east-1
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.resources (id, service, region, instance_type, configuration, unit_price, monthly_cost, created_at, resource_name, simulations_id) FROM stdin;
2	1	19	\N	{"quantity":4,"hours_per_month":630,"os":"Linux"}	0.02200	55.44000	2025-10-01 23:54:00	Production Web Servers 2	1
3	1	29	\N	{"quantity":5,"hours_per_month":830,"os":"Linux"}	0.08320	345.28000	2025-10-01 23:56:00	Production Web Servers 3	1
1	1	11	61	{"quantity":3,"hours_per_month":730,"os":"Linux"}	0.08320	182.19000	2025-10-01 12:00:00	Production Web Servers 1	1
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
8	Amazon AmazonEC2	AmazonEC2
<<<<<<< HEAD
=======
\.


--
-- Data for Name: simulation_entries; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulation_entries (id, simulation, service, instance_type, quantity, unit, price_snapshot) FROM stdin;
1	2	4	122	10.00000	Euros	\N
>>>>>>> f76dcd38 (update files)
\.


--
-- Data for Name: simulations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulations (id, name, description, status, scenario_type, monthly_coast, created_at, updated_at) FROM stdin;
1	Architecture actuelle	Infrastructure de production actuelle	active	current	0.00000	2025-10-01 12:00:00	\N
\.


--
-- Name: comparisons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

<<<<<<< HEAD
SELECT pg_catalog.setval('public.comparisons_id_seq', 1, false);
=======
COPY public.simulations_simulation_entries (id, simulations_id, simulation_entries_id) FROM stdin;
1	2	1
\.
>>>>>>> f76dcd38 (update files)


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

<<<<<<< HEAD
SELECT pg_catalog.setval('public.directus_activity_id_seq', 514, true);
=======
SELECT pg_catalog.setval('public.directus_activity_id_seq', 329, true);
>>>>>>> f76dcd38 (update files)


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 83, true);


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

SELECT pg_catalog.setval('public.directus_presets_id_seq', 8, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 21, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

<<<<<<< HEAD
SELECT pg_catalog.setval('public.directus_revisions_id_seq', 442, true);
=======
SELECT pg_catalog.setval('public.directus_revisions_id_seq', 641, true);
>>>>>>> f76dcd38 (update files)


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

<<<<<<< HEAD
SELECT pg_catalog.setval('public.instance_types_id_seq', 124, true);
=======
SELECT pg_catalog.setval('public.instance_types_id_seq', 198, true);
>>>>>>> f76dcd38 (update files)


--
-- Name: prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.prices_id_seq', 184, true);


--
-- Name: recommendations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.recommendations_id_seq', 1, false);


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.regions_id_seq', 78, true);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.resources_id_seq', 3, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.services_id_seq', 8, true);
<<<<<<< HEAD
=======


--
-- Name: simulation_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulation_entries_id_seq', 1, true);
>>>>>>> f76dcd38 (update files)


--
-- Name: simulations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulations_id_seq', 1, true);


--
-- Name: comparisons comparisons_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

<<<<<<< HEAD
ALTER TABLE ONLY public.comparisons
    ADD CONSTRAINT comparisons_pkey PRIMARY KEY (id);
=======
SELECT pg_catalog.setval('public.simulations_simulation_entries_id_seq', 1, true);
>>>>>>> f76dcd38 (update files)


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
-- Name: prices prices_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: simulations simulations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.simulations
    ADD CONSTRAINT simulations_pkey PRIMARY KEY (id);


--
-- Name: comparisons comparisons_simulation_baseline_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comparisons
    ADD CONSTRAINT comparisons_simulation_baseline_foreign FOREIGN KEY (simulation_baseline) REFERENCES public.simulations(id) ON DELETE SET NULL;


--
-- Name: comparisons comparisons_simulation_comparison_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comparisons
    ADD CONSTRAINT comparisons_simulation_comparison_foreign FOREIGN KEY (simulation_comparison) REFERENCES public.simulations(id) ON DELETE SET NULL;


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
-- Name: prices prices_instance_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_instance_type_foreign FOREIGN KEY (instance_type) REFERENCES public.instance_types(id) ON DELETE SET NULL;


--
-- Name: prices prices_region_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_region_foreign FOREIGN KEY (region) REFERENCES public.regions(id) ON DELETE SET NULL;


--
-- Name: prices prices_service_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_service_foreign FOREIGN KEY (service) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: recommendations recommendations_resource_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_resource_id_foreign FOREIGN KEY (resource_id) REFERENCES public.resources(id) ON DELETE SET NULL;


--
-- Name: recommendations recommendations_simulation_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_simulation_id_foreign FOREIGN KEY (simulation_id) REFERENCES public.simulations(id) ON DELETE SET NULL;


--
-- Name: resources resources_instance_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_instance_type_foreign FOREIGN KEY (instance_type) REFERENCES public.instance_types(id) ON DELETE SET NULL;


--
-- Name: resources resources_region_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_region_foreign FOREIGN KEY (region) REFERENCES public.regions(id) ON DELETE SET NULL;


--
-- Name: resources resources_service_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_service_foreign FOREIGN KEY (service) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: resources resources_simulations_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_simulations_id_foreign FOREIGN KEY (simulations_id) REFERENCES public.simulations(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict U7AnIdxrs5H8UavtiBTIFwjenTUrwuo9iYv5dCsSJMC6f7IDhnTd6D9LcNmjnsu

