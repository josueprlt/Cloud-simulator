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
-- Name: pricing id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing ALTER COLUMN id SET DEFAULT nextval('public.pricing_id_seq'::regclass);


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
prices	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
resources	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
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
64	prices	id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
65	prices	sku	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
66	prices	service	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
67	prices	region	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
68	prices	instance_type	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
69	prices	os	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
70	prices	price_per_unit	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
71	prices	created_at	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
72	prices	updated_at	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
73	resources	id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
74	resources	service	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
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
75	resources	region	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
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
76	resources	instance_type	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
77	resources	configuration	cast-json	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
78	resources	monthly_cost	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
79	resources	unit_price	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
80	resources	created_at	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
81	resources	resource_name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
82	resources	simulations_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
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
1	\N	27fc7a4b-bd46-414c-8883-99f3ae3089df	\N	regions	\N	\N	{"tabular":{"fields":["code","name","id"],"page":1}}	{"tabular":{"widths":{"code":160,"name":441.5260009765625}}}	\N	\N	bookmark	\N
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
xi6TFRDzyRaQmgyrga027YLv51B7byKX2IXXzHxwsuOAizeIegUA97njAdtRYqn9	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 13:43:54.995+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
rutD25QeW5W3mwH7w_F6r46NGgfK_r3oV4cjyyCnpJdZYHBMATSQ4Ibuqr2n7BiI	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:48:40.732+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
DUYe9oWFPyhDtUZUFxPjK7t2YJ-2Rj9PmvZ-0VLbH0g7JHH4v5Jw1pC-F9W07ltK	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:32:57.302+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
3ao1ekkjKw1LL4uNIWiJ5VQeTrP2Oh8udIMHNpWpfzjRi7B7HiDZD4h493SXH8Ot	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 15:11:44.1+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
7uAPjz8KpkmdexpJUMnP0M2bplVqaCGaSjZQEeLaDiNd2ZnLu0pWM4_DdcRtVNat	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:59:54.866+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
jmXkyiIcxk6aRHfQhh9O60ByiO2fIhGcjrlYS82duENxVO7p-rRvOkfE-AiI3vXK	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 17:33:40.194+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
wJqpv6vFJrzVzC3joJelzN4XmQgoUpxLqwl32rzj0vkpRh2nFGzQc5e8Xdlej1mZ	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 17:37:32.614+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
5O3R3eqJFamAxSuYikywpOFT747fW7CxTzavL-rCurX6DIobbpQNkTOWXT9FW8fm	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-02 12:30:38.523+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	5E3tsZFb8t8zqGBS--JNmYjdZnsZfu4OjIMh386sY-_qO9XL4P9dP4W0Tp5o2sRk
IG7DvSFn69QrvOtxlKle97a9hUO3EKNhVwFFEaTX2IaAbfWDVZ8k_lLNS5GuKzR5	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 17:45:00.981+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
hpKZk1YfoClQoQthSteGBoCcpxWAIrPVBivFPFbK7l94fw28RtYvtTLT8MCKOlql	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:00:22.406+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
Fp5aq7WTjDymWIg69A5KmoViIMiMGN6lEMJBeMjRgeaBBixbJcyhu-KARe5Xpi8i	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 18:14:59.223+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
sE0oUPzwAiZF5m8teZGLTYPUnWdEy1ME1gq3NrxIBNGfefxNzoVricQuvYDOdwan	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:23:55.145+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
iP5i2o_8BT3pdUzokoYxPLZLI8rjCScOoi-VMvU8Joha3V-Tci2TDc9FFpOP3u2r	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:10:24.189+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
P8jexrHm1xVh_mwW1Tza6Mi4g270TBk2ZnL4sOdZQge_PreNguxjbwxxD4RaIGHJ	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:10:33.14+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
qj25zPwIJKQPG_swkB-DnPL344C4cZNyJVjR0b9X504XvwPQIW2hyVdA25bK4SWD	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-03 09:57:07.201+00	172.21.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0	\N	http://localhost:8055	\N
WZcWI_XBjnl6gXL_jMwPP6-yuduOlCb6Uj8Wvx0CFTmKIZmtnOu30xfwugtouZ2w	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:13:08.023+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
Miun5SreoxBobo-8Gl47kXVXDUumorh5id4KmcFTvo39hbfXgXDhiouL21Bk-adX	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 21:14:11.639+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
tGLoIhUZpf4ESzGTM8a1edvOB1leHs5rq7EyZAiVULi1gbHvO_Y_vlrFIEqw-P5P	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:16:19.931+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
ekFiGIyU8KQuzvUm1KZTFC5oHGdcUpROW3GS1Dzpe5TdwjJL5cq3SHGosQ-SUrUe	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-08 19:28:32.688+00	172.21.0.1	PostmanRuntime/7.48.0	\N	\N	\N
5E3tsZFb8t8zqGBS--JNmYjdZnsZfu4OjIMh386sY-_qO9XL4P9dP4W0Tp5o2sRk	27fc7a4b-bd46-414c-8883-99f3ae3089df	2025-10-03 12:30:28.523+00	172.19.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
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
27fc7a4b-bd46-414c-8883-99f3ae3089df	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$hPFw2a086BrG9B03t6pPxg$HGjy3p+0DAtjm/b7TmkYUPAwr8sk8Fb/+XexTjOQwz0	\N	\N	\N	\N	\N	\N	\N	active	7d7ad24c-6292-497b-9809-ec4d797b1df5	sqdI9gHDEUicFil6PLCM2lC9mmYRMqpK	2025-10-02 12:30:28.59+00	/content/pricing	default	\N	\N	t	\N	\N	\N	\N	\N	auto
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
\.


--
-- Data for Name: prices; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.prices (id, sku, service, region, instance_type, os, price_per_unit, created_at, updated_at) FROM stdin;
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
\.


--
-- Data for Name: pricing; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.pricing (id, service, region, instance_type, price_per_unit, unit, currency, updated_at) FROM stdin;
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.recommendations (id, simulation_id, resource_id, type, prioprity, title, description, current_cost, optimized_cost, potential_savings, implementation_effort, applied, created_at) FROM stdin;
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
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.resources (id, service, region, instance_type, configuration, unit_price, monthly_cost, created_at, resource_name, simulations_id) FROM stdin;
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
\.


--
-- Data for Name: simulation_entries; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulation_entries (id, simulation, service, instance_type, quantity, unit, price_snapshot) FROM stdin;
1	2	4	122	10.00000	Euros	\N
\.


--
-- Data for Name: simulations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulations (id, name, region) FROM stdin;
2	test	5
\.


--
-- Data for Name: simulations_simulation_entries; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.simulations_simulation_entries (id, simulations_id, simulation_entries_id) FROM stdin;
1	2	1
\.


--
-- Name: comparisons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.comparisons_id_seq', 1, false);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 514, true);


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

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 442, true);


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

SELECT pg_catalog.setval('public.instance_types_id_seq', 124, true);


--
-- Name: prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.prices_id_seq', 184, true);


--
-- Name: pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.pricing_id_seq', 1, false);


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


--
-- Name: simulation_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulation_entries_id_seq', 1, true);


--
-- Name: simulations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulations_id_seq', 1, true);


--
-- Name: simulations_simulation_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.simulations_simulation_entries_id_seq', 1, true);


--
-- Name: comparisons comparisons_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comparisons
    ADD CONSTRAINT comparisons_pkey PRIMARY KEY (id);


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
-- Name: pricing pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pkey PRIMARY KEY (id);


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

