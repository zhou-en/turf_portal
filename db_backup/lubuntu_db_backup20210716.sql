--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)

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

DROP DATABASE IF EXISTS "turf-portal";
--
-- Name: turf-portal; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "turf-portal" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_ZA.UTF-8' LC_CTYPE = 'en_ZA.UTF-8';


ALTER DATABASE "turf-portal" OWNER TO postgres;

\connect -reuse-previous=on "dbname='turf-portal'"

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO "turf-portal-user";

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO "turf-portal-user";

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO "turf-portal-user";

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO "turf-portal-user";

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO "turf-portal-user";

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO "turf-portal-user";

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO "turf-portal-user";

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO "turf-portal-user";

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO "turf-portal-user";

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO "turf-portal-user";

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO "turf-portal-user";

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO "turf-portal-user";

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO "turf-portal-user";

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO "turf-portal-user";

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO "turf-portal-user";

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO "turf-portal-user";

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO "turf-portal-user";

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO "turf-portal-user";

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO "turf-portal-user";

--
-- Name: expense_expense; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.expense_expense (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    date timestamp with time zone NOT NULL,
    description character varying(511) NOT NULL,
    method character varying(255) NOT NULL,
    amount double precision NOT NULL
);


ALTER TABLE public.expense_expense OWNER TO "turf-portal-user";

--
-- Name: expense_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.expense_expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expense_expense_id_seq OWNER TO "turf-portal-user";

--
-- Name: expense_expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.expense_expense_id_seq OWNED BY public.expense_expense.id;


--
-- Name: invoice_invoice; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.invoice_invoice (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    status character varying(255) NOT NULL,
    number character varying(255),
    buyer_id integer NOT NULL,
    order_id integer NOT NULL,
    closed_date timestamp with time zone
);


ALTER TABLE public.invoice_invoice OWNER TO "turf-portal-user";

--
-- Name: invoice_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.invoice_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_invoice_id_seq OWNER TO "turf-portal-user";

--
-- Name: invoice_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.invoice_invoice_id_seq OWNED BY public.invoice_invoice.id;


--
-- Name: invoice_payment; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.invoice_payment (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    amount double precision NOT NULL,
    invoice_id integer NOT NULL,
    method character varying(255) NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE public.invoice_payment OWNER TO "turf-portal-user";

--
-- Name: invoice_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.invoice_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_payment_id_seq OWNER TO "turf-portal-user";

--
-- Name: invoice_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.invoice_payment_id_seq OWNED BY public.invoice_payment.id;


--
-- Name: sales_buyer; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.sales_buyer (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    buyer_type character varying(255),
    name character varying(255) NOT NULL,
    address character varying(255),
    contact_person character varying(255) NOT NULL,
    mobile character varying(255),
    email character varying(255),
    status character varying(255) NOT NULL
);


ALTER TABLE public.sales_buyer OWNER TO "turf-portal-user";

--
-- Name: sales_buyer_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.sales_buyer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_buyer_id_seq OWNER TO "turf-portal-user";

--
-- Name: sales_buyer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.sales_buyer_id_seq OWNED BY public.sales_buyer.id;


--
-- Name: sales_buyerproduct; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.sales_buyerproduct (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    price double precision NOT NULL,
    buyer_id integer,
    product_id integer
);


ALTER TABLE public.sales_buyerproduct OWNER TO "turf-portal-user";

--
-- Name: sales_buyerproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.sales_buyerproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_buyerproduct_id_seq OWNER TO "turf-portal-user";

--
-- Name: sales_buyerproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.sales_buyerproduct_id_seq OWNED BY public.sales_buyerproduct.id;


--
-- Name: sales_order; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.sales_order (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    status character varying(255) NOT NULL,
    buyer_id integer NOT NULL,
    number character varying(255),
    closed_date timestamp with time zone
);


ALTER TABLE public.sales_order OWNER TO "turf-portal-user";

--
-- Name: sales_order_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.sales_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_order_id_seq OWNER TO "turf-portal-user";

--
-- Name: sales_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.sales_order_id_seq OWNED BY public.sales_order.id;


--
-- Name: sales_orderline; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.sales_orderline (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    quantity double precision NOT NULL,
    price double precision,
    order_id integer NOT NULL,
    roll_id integer,
    product_id integer,
    total double precision
);


ALTER TABLE public.sales_orderline OWNER TO "turf-portal-user";

--
-- Name: sales_orderline_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.sales_orderline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_orderline_id_seq OWNER TO "turf-portal-user";

--
-- Name: sales_orderline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.sales_orderline_id_seq OWNED BY public.sales_orderline.id;


--
-- Name: stock_batch; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_batch (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    number character varying(255)
);


ALTER TABLE public.stock_batch OWNER TO "turf-portal-user";

--
-- Name: stock_batch_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_batch_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_batch_id_seq OWNED BY public.stock_batch.id;


--
-- Name: stock_category; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_category (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.stock_category OWNER TO "turf-portal-user";

--
-- Name: stock_category_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_category_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_category_id_seq OWNED BY public.stock_category.id;


--
-- Name: stock_color; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_color (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(63) NOT NULL
);


ALTER TABLE public.stock_color OWNER TO "turf-portal-user";

--
-- Name: stock_color_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_color_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_color_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_color_id_seq OWNED BY public.stock_color.id;


--
-- Name: stock_height; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_height (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    value double precision NOT NULL
);


ALTER TABLE public.stock_height OWNER TO "turf-portal-user";

--
-- Name: stock_height_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_height_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_height_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_height_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_height_id_seq OWNED BY public.stock_height.id;


--
-- Name: stock_product; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_product (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    code character varying(255),
    spec_id integer
);


ALTER TABLE public.stock_product OWNER TO "turf-portal-user";

--
-- Name: stock_product_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_product_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_product_id_seq OWNED BY public.stock_product.id;


--
-- Name: stock_rollspec; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_rollspec (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    length double precision NOT NULL,
    category_id integer NOT NULL,
    color_id integer NOT NULL,
    height_id integer NOT NULL,
    width_id integer NOT NULL
);


ALTER TABLE public.stock_rollspec OWNER TO "turf-portal-user";

--
-- Name: stock_rollspec_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_rollspec_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_rollspec_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_rollspec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_rollspec_id_seq OWNED BY public.stock_rollspec.id;


--
-- Name: stock_turfroll; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_turfroll (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    status character varying(63) NOT NULL,
    spec_id integer NOT NULL,
    location_id integer,
    total integer NOT NULL,
    sold integer NOT NULL,
    original_size integer NOT NULL,
    batch_id integer,
    note text
);


ALTER TABLE public.stock_turfroll OWNER TO "turf-portal-user";

--
-- Name: stock_turfroll_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_turfroll_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_turfroll_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_turfroll_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_turfroll_id_seq OWNED BY public.stock_turfroll.id;


--
-- Name: stock_warehouse; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_warehouse (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL,
    number integer,
    address character varying(255)
);


ALTER TABLE public.stock_warehouse OWNER TO "turf-portal-user";

--
-- Name: stock_warehouse_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_warehouse_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_warehouse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_warehouse_id_seq OWNED BY public.stock_warehouse.id;


--
-- Name: stock_width; Type: TABLE; Schema: public; Owner: turf-portal-user
--

CREATE TABLE public.stock_width (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    value double precision NOT NULL
);


ALTER TABLE public.stock_width OWNER TO "turf-portal-user";

--
-- Name: stock_width_id_seq; Type: SEQUENCE; Schema: public; Owner: turf-portal-user
--

CREATE SEQUENCE public.stock_width_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_width_id_seq OWNER TO "turf-portal-user";

--
-- Name: stock_width_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turf-portal-user
--

ALTER SEQUENCE public.stock_width_id_seq OWNED BY public.stock_width.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: expense_expense id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.expense_expense ALTER COLUMN id SET DEFAULT nextval('public.expense_expense_id_seq'::regclass);


--
-- Name: invoice_invoice id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_invoice ALTER COLUMN id SET DEFAULT nextval('public.invoice_invoice_id_seq'::regclass);


--
-- Name: invoice_payment id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_payment ALTER COLUMN id SET DEFAULT nextval('public.invoice_payment_id_seq'::regclass);


--
-- Name: sales_buyer id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyer ALTER COLUMN id SET DEFAULT nextval('public.sales_buyer_id_seq'::regclass);


--
-- Name: sales_buyerproduct id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyerproduct ALTER COLUMN id SET DEFAULT nextval('public.sales_buyerproduct_id_seq'::regclass);


--
-- Name: sales_order id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_order ALTER COLUMN id SET DEFAULT nextval('public.sales_order_id_seq'::regclass);


--
-- Name: sales_orderline id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_orderline ALTER COLUMN id SET DEFAULT nextval('public.sales_orderline_id_seq'::regclass);


--
-- Name: stock_batch id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_batch ALTER COLUMN id SET DEFAULT nextval('public.stock_batch_id_seq'::regclass);


--
-- Name: stock_category id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_category ALTER COLUMN id SET DEFAULT nextval('public.stock_category_id_seq'::regclass);


--
-- Name: stock_color id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_color ALTER COLUMN id SET DEFAULT nextval('public.stock_color_id_seq'::regclass);


--
-- Name: stock_height id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_height ALTER COLUMN id SET DEFAULT nextval('public.stock_height_id_seq'::regclass);


--
-- Name: stock_product id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_product ALTER COLUMN id SET DEFAULT nextval('public.stock_product_id_seq'::regclass);


--
-- Name: stock_rollspec id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec ALTER COLUMN id SET DEFAULT nextval('public.stock_rollspec_id_seq'::regclass);


--
-- Name: stock_turfroll id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_turfroll ALTER COLUMN id SET DEFAULT nextval('public.stock_turfroll_id_seq'::regclass);


--
-- Name: stock_warehouse id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_warehouse ALTER COLUMN id SET DEFAULT nextval('public.stock_warehouse_id_seq'::regclass);


--
-- Name: stock_width id; Type: DEFAULT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_width ALTER COLUMN id SET DEFAULT nextval('public.stock_width_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add buyer	7	add_buyer
26	Can change buyer	7	change_buyer
27	Can delete buyer	7	delete_buyer
28	Can view buyer	7	view_buyer
29	Can add buyer product	8	add_buyerproduct
30	Can change buyer product	8	change_buyerproduct
31	Can delete buyer product	8	delete_buyerproduct
32	Can view buyer product	8	view_buyerproduct
33	Can add order	9	add_order
34	Can change order	9	change_order
35	Can delete order	9	delete_order
36	Can view order	9	view_order
37	Can add order line	10	add_orderline
38	Can change order line	10	change_orderline
39	Can delete order line	10	delete_orderline
40	Can view order line	10	view_orderline
41	Can add invoice	11	add_invoice
42	Can change invoice	11	change_invoice
43	Can delete invoice	11	delete_invoice
44	Can view invoice	11	view_invoice
45	Can add payment	12	add_payment
46	Can change payment	12	change_payment
47	Can delete payment	12	delete_payment
48	Can view payment	12	view_payment
49	Can add category	13	add_category
50	Can change category	13	change_category
51	Can delete category	13	delete_category
52	Can view category	13	view_category
53	Can add color	14	add_color
54	Can change color	14	change_color
55	Can delete color	14	delete_color
56	Can view color	14	view_color
57	Can add height	15	add_height
58	Can change height	15	change_height
59	Can delete height	15	delete_height
60	Can view height	15	view_height
61	Can add width	16	add_width
62	Can change width	16	change_width
63	Can delete width	16	delete_width
64	Can view width	16	view_width
65	Can add product	17	add_product
66	Can change product	17	change_product
67	Can delete product	17	delete_product
68	Can view product	17	view_product
69	Can add roll spec	18	add_rollspec
70	Can change roll spec	18	change_rollspec
71	Can delete roll spec	18	delete_rollspec
72	Can view roll spec	18	view_rollspec
73	Can add warehouse	19	add_warehouse
74	Can change warehouse	19	change_warehouse
75	Can delete warehouse	19	delete_warehouse
76	Can view warehouse	19	view_warehouse
77	Can add turf roll	20	add_turfroll
78	Can change turf roll	20	change_turfroll
79	Can delete turf roll	20	delete_turfroll
80	Can view turf roll	20	view_turfroll
81	Can add batch	21	add_batch
82	Can change batch	21	change_batch
83	Can delete batch	21	delete_batch
84	Can view batch	21	view_batch
85	Can add expense	22	add_expense
86	Can change expense	22	change_expense
87	Can delete expense	22	delete_expense
88	Can view expense	22	view_expense
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$216000$DcCuOZ1CBz1d$1XEgr2VgUWkuy3dJL82yWZjZOj6jvrIokvuPrJ1FLhY=	2021-07-16 16:08:53.714885+02	t	admin			admin@email.com	t	t	2020-09-26 23:48:28.27341+02
2	pbkdf2_sha256$216000$tjL1AjWDR6yw$PXnadl7yw3ItSI3o+rgJbQwahgPkY9Jd8PTXgVCZ2Ek=	2021-01-28 00:26:05.815818+02	f	fanying			fanying@turfd.co.za	f	t	2020-09-26 23:49:48+02
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-09-26 23:50:11.83843+02	2	fanying	2	[{"changed": {"fields": ["Staff status", "Superuser status"]}}]	4	1
2	2020-10-01 20:59:54.252199+02	27	27: A25-4m - LOOSE   - available:35.0	3		20	1
3	2020-10-01 20:59:54.260252+02	22	22: A25-4m - SEALED   - available:100.0	3		20	1
4	2020-10-01 20:59:54.265907+02	21	21: A25-4m - SEALED   - available:100.0	3		20	1
5	2020-10-01 20:59:54.277303+02	20	20: A25-4m - SEALED   - available:100.0	3		20	1
6	2020-10-01 20:59:54.288779+02	19	19: S25-2m - SEALED   - available:50.0	3		20	1
7	2020-10-01 20:59:54.295045+02	18	18: S25-2m - SEALED   - available:50.0	3		20	1
8	2020-10-01 20:59:54.301261+02	17	17: S25-2m - SEALED   - available:50.0	3		20	1
9	2020-10-01 20:59:54.307369+02	16	16: S25-2m - SEALED   - available:50.0	3		20	1
10	2020-10-01 20:59:54.313224+02	15	15: S25-2m - SEALED   - available:50.0	3		20	1
11	2020-10-01 20:59:54.318468+02	14	14: S25-2m - SEALED   - available:50.0	3		20	1
12	2020-10-01 20:59:54.32376+02	13	13: S25-2m - SEALED   - available:50.0	3		20	1
13	2020-10-01 20:59:54.329446+02	12	12: S25-2m - SEALED   - available:50.0	3		20	1
14	2020-10-01 20:59:54.335204+02	11	11: S25-2m - SEALED   - available:50.0	3		20	1
15	2020-10-01 20:59:54.341113+02	10	10: S25-2m - SEALED   - available:50.0	3		20	1
16	2020-10-01 20:59:54.346943+02	9	9: S25-2m - SEALED   - available:50.0	3		20	1
17	2020-10-01 20:59:54.352791+02	8	8: S25-2m - SEALED   - available:50.0	3		20	1
18	2020-10-01 20:59:54.358565+02	7	7: S25-2m - SEALED   - available:50.0	3		20	1
19	2020-10-01 20:59:54.364379+02	6	6: S25-2m - SEALED   - available:50.0	3		20	1
20	2020-10-01 21:00:27.201896+02	10	S30-4m	3		17	1
21	2020-10-01 21:00:27.207472+02	9	S25-4m	3		17	1
22	2020-10-01 21:00:27.210647+02	4	S25-2m	3		17	1
23	2020-10-01 21:00:27.213652+02	2	S30-2m	3		17	1
24	2020-10-04 01:57:11.364446+02	1	BATCH-20201001	1	[{"added": {}}]	21	1
25	2020-10-06 10:02:34.840506+02	2	Jaco	2	[{"changed": {"name": "buyer product", "object": "Jaco 25A-4: R165.00", "fields": ["Price"]}}]	7	1
26	2020-10-06 10:02:47.740277+02	2	Order: 25A-4: 90.0 for 165.0	2	[{"changed": {"fields": ["Price"]}}]	10	1
27	2020-10-14 23:48:15.588453+02	2	Join Tape	1	[{"added": {}}]	13	1
28	2020-10-14 23:49:24.360055+02	3	0	1	[{"added": {}}]	15	1
29	2020-10-16 01:39:52.477854+02	3	0.3	1	[{"added": {}}]	16	1
30	2020-10-16 01:40:12.972173+02	3	Black	1	[{"added": {}}]	14	1
31	2020-10-16 01:40:40.261987+02	9	JT-100	1	[{"added": {}}]	18	1
32	2020-10-16 01:40:53.265354+02	10	JT-300	1	[{"added": {}}]	18	1
33	2020-10-16 01:41:05.896367+02	11	JT-100	1	[{"added": {}}]	17	1
34	2020-10-16 01:41:13.266949+02	12	JT-300	1	[{"added": {}}]	17	1
35	2020-10-27 20:36:51.17017+02	5	5: 30A-4 - OPENED   - available:38.0	2	[{"changed": {"fields": ["Original size"]}}]	20	1
36	2021-01-12 14:04:39.196245+02	3	Alternative Storage: 5015	1	[{"added": {}}]	19	1
37	2021-01-12 14:04:49.623252+02	4	Alternative Storage: 7003	1	[{"added": {}}]	19	1
38	2021-01-12 14:05:13.155277+02	5	Alternative Storage: 7004	1	[{"added": {}}]	19	1
39	2021-01-12 14:05:22.429062+02	6	Alternative Storage: 6004	1	[{"added": {}}]	19	1
40	2021-01-12 14:06:42.834323+02	3	Alternative Storage: 5015	3		19	1
41	2021-01-12 14:06:50.85989+02	1	Alternative Storage: 5015	2	[{"changed": {"fields": ["Number"]}}]	19	1
42	2021-01-12 14:07:30.927686+02	2	Alternative Storage: 1506	3		19	1
43	2021-01-12 14:09:02.892913+02	2	BATCH-20210112	1	[{"added": {}}]	21	1
44	2021-01-15 19:00:27.39585+02	13	30S-2	1	[{"added": {}}]	17	1
45	2021-01-15 19:00:35.99981+02	14	30S-4	1	[{"added": {}}]	17	1
46	2021-01-25 15:44:43.669961+02	77	Order: 30A-2: 9.0 for 175.0	2	[{"changed": {"fields": ["Roll"]}}]	10	1
47	2021-01-25 15:50:04.493329+02	89	89: 30A-2 - OPENED   - available:8.0	2	[{"changed": {"fields": ["Original size"]}}]	20	1
48	2021-01-28 09:53:27.983797+02	45	45: JOSH-INV-202101250606 - PAYMENT OUTSTANDING	2	[{"changed": {"fields": ["Status"]}}]	11	1
49	2021-01-28 21:53:28.531154+02	28	28: 25A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
50	2021-01-28 21:54:17.143183+02	90	90: 30A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
51	2021-01-28 22:01:12.640609+02	45	45: 25A-4 - LOOSE   - available:13.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
52	2021-01-28 22:02:16.289376+02	31	31: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
53	2021-01-28 22:03:15.44688+02	32	32: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
54	2021-01-28 22:04:05.605727+02	33	33: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
55	2021-01-28 22:05:27.072484+02	2	2: 30A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
56	2021-01-28 22:06:31.27918+02	34	34: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
57	2021-01-28 22:09:05.51186+02	23	23: 30A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
58	2021-01-28 22:10:06.348178+02	26	26: 30A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
59	2021-01-28 22:15:47.918757+02	24	24: 30A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
60	2021-01-28 22:29:13.93708+02	25	25: 30A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
61	2021-01-28 22:31:39.768107+02	47	47: 25A-4 - LOOSE   - available:2.0	2	[{"changed": {"fields": ["Status", "Total", "Sold"]}}]	20	1
62	2021-01-28 22:33:32.077732+02	3	3: 30A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
63	2021-01-28 22:34:13.627821+02	4	4: 30A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
64	2021-01-28 22:35:10.19483+02	5	5: 30A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
65	2021-01-28 22:36:34.547567+02	50	50: 30A-2 - OPENED   - available:6.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
66	2021-01-28 22:40:31.423543+02	29	29: 25A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
67	2021-01-28 22:41:17.678812+02	46	46: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
68	2021-01-28 22:41:48.818872+02	35	35: 25A-2 - DEPLETED   - available:50.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
69	2021-01-28 22:41:55.939001+02	35	35: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Sold"]}}]	20	1
70	2021-01-28 22:43:24.880623+02	30	30: 25A-4 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
71	2021-01-28 22:45:39.332476+02	36	36: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
72	2021-01-28 22:47:11.688741+02	37	37: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
73	2021-01-28 22:48:05.188826+02	38	38: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
74	2021-01-28 22:49:03.870727+02	39	39: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
75	2021-01-28 22:49:38.689914+02	40	40: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
76	2021-01-28 22:50:45.700118+02	41	41: 25A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
77	2021-01-28 23:04:18.877453+02	137	137: 25A-2 - LOOSE   - available:11.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
78	2021-01-28 23:05:06.338705+02	139	139: 30A-2 - DEPLETED   - available:0.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
79	2021-01-28 23:06:57.582892+02	108	108: 30S-2 - OPENED   - available:38.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
80	2021-01-28 23:22:57.270442+02	89	89: 30A-2 - OPENED   - available:5.0	2	[{"changed": {"fields": ["Status", "Total", "Sold", "Location"]}}]	20	1
81	2021-01-28 23:25:21.841664+02	91	91: 30A-2 - OPENED   - available:7.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
82	2021-01-28 23:30:01.852203+02	66	66: 30A-4 - OPENED   - available:9.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
83	2021-01-28 23:37:32.590912+02	1	1: JACO-ORD-2020100119 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
84	2021-01-28 23:37:49.936665+02	2	2: FREDDIE-ORD-2020100916 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
85	2021-01-28 23:38:02.816378+02	3	3: VILLAGEHARDWAREANDPAINT-ORD-2020100916 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
86	2021-01-28 23:38:21.059654+02	4	4: WALTER-ORD-2020101010 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
87	2021-01-28 23:38:42.339768+02	4	4: WALTER-ORD-2020101010 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
88	2021-01-28 23:38:54.061521+02	6	6: NEWTON-ORD-2020101207 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
89	2021-01-28 23:39:06.555012+02	7	7: WALTER-ORD-2020101209 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
90	2021-01-28 23:39:20.617608+02	8	8: WALTER-ORD-2020101911 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
91	2021-01-28 23:39:40.154305+02	9	9: NEWTON-ORD-2020102007 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
92	2021-01-28 23:39:57.451272+02	10	10: WALTER-ORD-2020102009 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
93	2021-01-28 23:40:18.431236+02	10	10: WALTER-ORD-2020102009 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
94	2021-01-28 23:40:31.124536+02	11	11: DODO-ORD-2020102012 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
95	2021-01-28 23:41:22.733417+02	11	11: DODO-ORD-2020102012 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
96	2021-01-28 23:41:55.644496+02	11	11: DODO-ORD-2020102012 - CLOSED	2	[]	9	1
97	2021-01-28 23:42:47.54865+02	12	12: DODO-ORD-2020102213 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
98	2021-01-28 23:43:24.398367+02	13	13: WALTER-ORD-2020102213 - CLOSED	2	[{"changed": {"fields": ["Closed date"]}}]	9	1
99	2021-01-29 00:05:55.475887+02	47	EFT - CONFIRMED - 0.0	3		12	1
100	2021-01-29 00:06:57.238693+02	45	EFT - CONFIRMED - 0.0	3		12	1
101	2021-01-31 23:45:58.106251+02	4	Golf	1	[{"added": {}}]	14	1
102	2021-01-31 23:46:23.080243+02	4	15.0	1	[{"added": {}}]	15	1
103	2021-01-31 23:46:39.881271+02	11	15G-4	1	[{"added": {}}]	18	1
104	2021-02-01 22:10:13.063216+02	83	Order: 30S-4: 72.0 for 165.0	2	[{"changed": {"fields": ["Quantity"]}}]	10	1
105	2021-02-01 22:10:32.956757+02	75	75: 30S-4 - OPENED   - available:28.0	2	[{"changed": {"fields": ["Total", "Sold"]}}]	20	1
106	2021-03-15 23:07:56.623203+02	3	Golf Cup	1	[{"added": {}}]	13	1
107	2021-03-15 23:09:12.036492+02	12	JT-0	1	[{"added": {}}]	18	1
108	2021-03-15 23:09:23.246937+02	4	0.0	1	[{"added": {}}]	16	1
109	2021-03-15 23:09:37.839541+02	12	JT-0	2	[{"changed": {"fields": ["Width"]}}]	18	1
110	2021-03-15 23:11:45.173403+02	12	JT-0	3		18	1
111	2021-03-15 23:56:39.652795+02	5	White	1	[{"added": {}}]	14	1
112	2021-03-15 23:56:55.44294+02	5	1.0	1	[{"added": {}}]	15	1
113	2021-03-15 23:57:02.359026+02	5	1.0	1	[{"added": {}}]	16	1
114	2021-03-15 23:57:08.239275+02	13	Golf Cup	1	[{"added": {}}]	18	1
115	2021-03-15 23:57:23.833621+02	16	Golf Cup	1	[{"added": {}}]	17	1
116	2021-03-28 21:10:04.467433+02	4	Flag	1	[{"added": {}}]	13	1
117	2021-03-28 21:10:20.396398+02	6	Yellow	1	[{"added": {}}]	14	1
118	2021-03-28 21:10:23.989592+02	7	Red	1	[{"added": {}}]	14	1
119	2021-03-28 21:10:29.534101+02	8	Blue	1	[{"added": {}}]	14	1
120	2021-03-28 21:11:02.780542+02	14	Flag - White	1	[{"added": {}}]	18	1
121	2021-03-28 21:11:27.867771+02	15	Flag - Yellow	1	[{"added": {}}]	18	1
122	2021-03-28 21:11:43.467125+02	16	Flag - Red	1	[{"added": {}}]	18	1
123	2021-03-28 21:12:01.679961+02	17	Flag - Blue	1	[{"added": {}}]	18	1
124	2021-03-28 21:12:34.615366+02	17	Flag - White	1	[{"added": {}}]	17	1
125	2021-03-28 21:12:41.842609+02	18	Flag - Yellow	1	[{"added": {}}]	17	1
126	2021-03-28 21:12:51.320017+02	19	Flag - Red	1	[{"added": {}}]	17	1
127	2021-03-28 21:12:57.822601+02	20	Flag - Blue	1	[{"added": {}}]	17	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	sales	buyer
8	sales	buyerproduct
9	sales	order
10	sales	orderline
11	invoice	invoice
12	invoice	payment
13	stock	category
14	stock	color
15	stock	height
16	stock	width
17	stock	product
18	stock	rollspec
19	stock	warehouse
20	stock	turfroll
21	stock	batch
22	expense	expense
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-09-26 23:40:36.0488+02
2	auth	0001_initial	2020-09-26 23:40:36.131956+02
3	admin	0001_initial	2020-09-26 23:40:36.299012+02
4	admin	0002_logentry_remove_auto_add	2020-09-26 23:40:36.330515+02
5	admin	0003_logentry_add_action_flag_choices	2020-09-26 23:40:36.341902+02
6	contenttypes	0002_remove_content_type_name	2020-09-26 23:40:36.365015+02
7	auth	0002_alter_permission_name_max_length	2020-09-26 23:40:36.375641+02
8	auth	0003_alter_user_email_max_length	2020-09-26 23:40:36.387817+02
9	auth	0004_alter_user_username_opts	2020-09-26 23:40:36.399207+02
10	auth	0005_alter_user_last_login_null	2020-09-26 23:40:36.41315+02
11	auth	0006_require_contenttypes_0002	2020-09-26 23:40:36.417888+02
12	auth	0007_alter_validators_add_error_messages	2020-09-26 23:40:36.431537+02
13	auth	0008_alter_user_username_max_length	2020-09-26 23:40:36.450639+02
14	auth	0009_alter_user_last_name_max_length	2020-09-26 23:40:36.465047+02
15	auth	0010_alter_group_name_max_length	2020-09-26 23:40:36.480293+02
16	auth	0011_update_proxy_permissions	2020-09-26 23:40:36.491562+02
17	auth	0012_alter_user_first_name_max_length	2020-09-26 23:40:36.503954+02
18	stock	0001_initial	2020-09-26 23:40:36.571677+02
19	stock	0002_auto_20200908_1039	2020-09-26 23:40:36.61736+02
20	stock	0003_auto_20200908_1049	2020-09-26 23:40:36.638983+02
21	stock	0004_auto_20200908_1407	2020-09-26 23:40:36.686604+02
22	stock	0005_auto_20200909_1547	2020-09-26 23:40:36.86667+02
23	stock	0006_warehouse_address	2020-09-26 23:40:36.966639+02
24	stock	0007_auto_20200909_1627	2020-09-26 23:40:36.991653+02
25	stock	0008_auto_20200909_2335	2020-09-26 23:40:37.017985+02
26	stock	0009_auto_20200912_0817	2020-09-26 23:40:37.053954+02
27	sales	0001_initial	2020-09-26 23:40:37.083392+02
28	sales	0002_buyerproduct	2020-09-26 23:40:37.109252+02
29	sales	0003_auto_20200908_1407	2020-09-26 23:40:37.167698+02
30	sales	0004_auto_20200909_1627	2020-09-26 23:40:37.191871+02
31	sales	0005_auto_20200909_1633	2020-09-26 23:40:37.225381+02
32	sales	0006_auto_20200909_1634	2020-09-26 23:40:37.239734+02
33	sales	0007_order_orderline	2020-09-26 23:40:37.277926+02
34	sales	0008_auto_20200912_0910	2020-09-26 23:40:37.338795+02
35	sales	0009_auto_20200912_0914	2020-09-26 23:40:37.37853+02
36	sales	0010_order_number	2020-09-26 23:40:37.405369+02
37	sales	0011_auto_20200913_2112	2020-09-26 23:40:37.416977+02
38	invoice	0001_initial	2020-09-26 23:40:37.450351+02
39	invoice	0002_remove_invoice_notes	2020-09-26 23:40:37.484076+02
40	invoice	0003_auto_20200915_2205	2020-09-26 23:40:37.49554+02
41	invoice	0004_payment	2020-09-26 23:40:37.51923+02
42	invoice	0005_payment_method	2020-09-26 23:40:37.546812+02
43	invoice	0006_invoice_closed_date	2020-09-26 23:40:37.560292+02
44	invoice	0007_auto_20200919_1733	2020-09-26 23:40:37.589232+02
45	invoice	0008_remove_invoice_closed_date	2020-09-26 23:40:37.604218+02
46	invoice	0009_invoice_closed_date	2020-09-26 23:40:37.642552+02
47	invoice	0010_auto_20200920_1049	2020-09-26 23:40:37.693403+02
48	sales	0012_order_closed_date	2020-09-26 23:40:37.710583+02
49	sales	0013_auto_20200919_1519	2020-09-26 23:40:37.728118+02
50	sales	0014_auto_20200919_1733	2020-09-26 23:40:37.751331+02
51	sales	0015_auto_20200920_1049	2020-09-26 23:40:37.803309+02
52	sessions	0001_initial	2020-09-26 23:40:37.8334+02
53	stock	0010_turfroll_delivered	2020-09-26 23:40:37.86269+02
54	stock	0011_auto_20200913_2112	2020-09-26 23:40:37.897174+02
55	stock	0012_turfroll_sold	2020-09-26 23:40:37.911448+02
56	stock	0013_auto_20200920_1033	2020-09-26 23:40:37.925101+02
57	sales	0016_auto_20200928_1915	2020-09-28 21:44:32.21333+02
58	stock	0014_product_has_stock	2020-09-28 21:44:32.229617+02
59	sales	0017_auto_20200928_2216	2020-09-29 02:59:27.236346+02
60	stock	0015_auto_20200929_1533	2020-09-29 22:12:40.050853+02
61	stock	0016_turfroll_original_size	2020-09-30 12:04:52.42538+02
62	stock	0017_remove_product_has_stock	2020-09-30 12:04:52.451305+02
63	stock	0018_auto_20201003_2238	2020-10-04 01:56:21.967764+02
64	sales	0018_auto_20201005_1842	2020-10-06 00:28:36.608285+02
65	stock	0019_turfroll_note	2020-10-12 01:14:38.408411+02
66	stock	0020_auto_20201015_2301	2020-10-16 01:01:56.977615+02
67	invoice	0011_update_invoice_number	2021-01-14 18:01:05.456101+02
68	sales	0019_update_order_number	2021-01-14 18:01:05.509146+02
69	expense	0001_initial	2021-01-24 00:04:32.372665+02
70	expense	0002_auto_20210120_2144	2021-01-24 00:04:32.422899+02
71	expense	0003_auto_20210120_2146	2021-01-24 00:04:32.433828+02
72	expense	0004_auto_20210120_2146	2021-01-24 00:04:32.442144+02
73	expense	0005_auto_20210120_2154	2021-01-24 00:04:32.450727+02
74	expense	0006_auto_20210120_2157	2021-01-24 00:04:32.459026+02
75	expense	0007_auto_20210120_2157	2021-01-24 00:04:32.466371+02
76	invoice	0012_auto_20210120_2135	2021-01-24 00:04:32.478402+02
77	invoice	0013_payment_status	2021-01-27 23:39:01.212026+02
78	invoice	0014_update_payment_status	2021-01-27 23:39:01.98363+02
79	invoice	0015_auto_20210127_2215	2021-01-28 00:23:01.702825+02
80	invoice	0016_auto_20210128_0802	2021-01-28 10:02:24.951602+02
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
9vctgevn2ngr3ucys2q0718v3f9nef95	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kMI5M:adJHTFMLJ0IsYOlC_KW_bbjwPLrTEjngOY1wz7k50Cw	2020-10-10 23:50:28.190913+02
0vjzd46nbb5plz6c8j33uhsv1udktofq	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kMSZo:BSwr8tV3HUJek1JtUbHc0kThWdPEBli9vWvVJ_wqECE	2020-10-11 11:02:36.003062+02
ey2gyim8ly5ipqw5vyh3ew8g3hr1rzmh	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kMczF:uCXC0h-r9p6aeF_QKuWm5nibLv8ktW7gge-ME16f1Xo	2020-10-11 22:09:33.889975+02
kkmjig6qj4tj2pziylav7qwkbqwirbqr	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kNtO4:TjCU_4icaxi7lAUM1HfuyWm3BvXwBW8SGewhKAakewQ	2020-10-15 09:52:24.928527+02
4jka18pvaycph7hxa8oj2logsebvbvea	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kO3ox:QJ5OTjg-RFYje4HU7tttXPGViTj99LrCnBBoSYNGwFk	2020-10-15 21:00:51.341745+02
9wdxgkzk6z8l9nabppy0ki6bkdi5ofiu	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kO7A2:U_RxeoSotuWbSw-bQveKN4O1ZLBfXX2WoTwYWZBjHC8	2020-10-16 00:34:50.316758+02
bhmlplyek6ycdltqfzyr5p8fvc38btli	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kPhly:1fcnK4-C4qMKsWw6MlwDpoWcXjGm-AeHZqad_x9WfDA	2020-10-20 09:52:34.056415+02
gqlzlktvav8ijdc3ugskh7t5srv3t5gx	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kQumX:Qb_sEgSI0ZP7KCwLecIfKtHF7LL-othrUXA1J_gacbA	2020-10-23 17:58:09.180198+02
3lqbaszzu4shnt1f0317det13oyqp2br	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kQv2h:ale6Aazg0yF-Hp7RQJUgNInBAasCU3GwE_a_59q3cAQ	2020-10-23 18:14:51.631887+02
y75fd3m70el7re1rmzki3mqwllothe3r	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kRihP:G9UljyKsxAYJHr7iAYmczefs5VWh_-8CeCP7MHyFnA8	2020-10-25 23:16:11.693068+02
968u2wjxdorztn91czogj1n4pdvvculw	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kT06d:4-uruwBSCqWWDUsSn_HWpG7f5uIwyXO8wjsd9vCpJN0	2020-10-29 12:03:31.677101+02
d86l6racgyeaubiok05oub98g7juygn6	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kTCqB:g1_rQJQJTqiHK24bhTVHrfOrbRz9MhdH9MOt51Rf474	2020-10-30 01:39:23.79101+02
tfi1ieebhrysilg7l891zn2opnmykxv3	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kUBS8:9pztc0xpEc0oZyP_aSsnXRXXUVQUmI8zbfBrebxDXZg	2020-11-01 18:22:36.118848+02
w6asbwxhvc1hhm4hlqqww69farjayvsp	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kUYWQ:GgjwKvmmKNSRDLi_K2yqFywhEsLk2ZojIL2Ul_xusls	2020-11-02 19:00:34.21066+02
unjkm29gl3ewwhnspm063w7uht2rngy6	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kUYZE:qX9oYBD8imGeuvIC-Eq4w3Jb-EHS_OuwGFkEgITEJCQ	2020-11-02 19:03:28.018556+02
nhg1ed0y4qhsevy8d48fpxcgtdsntn7b	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kUZw9:ppCuhOnNE3s4C7Mp4kcqUO5bEo8USR_1tj232iccjuY	2020-11-02 20:31:13.231916+02
jx2qqgksguma2rufclm6ciy5eyujehzt	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kVEhb:Ay4No5DdsIymkLcMLklVXIgFysI8yYmV4sDNqGwcR_c	2020-11-04 16:02:55.881416+02
82g5arfy24s2hfkacrdn9m54hjm8av2g	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kVfi0:lW7Pzf965b7fIJmEEbWQr7q9eKJzCz9P7UQtZc7I71A	2020-11-05 20:53:08.393519+02
m6wobbp313risqw05tpv5lfl0uo3b88e	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kW0QX:A_qKawgfu8RV_CPOJfwS0kkfdTRPw0_58ae5FmC-6Yo	2020-11-06 19:00:29.656651+02
ek60hal625v17mr191bc23hsj4pyriyp	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kXLEV:V9K8zeZ3QIgV1cZ92R8pau9O2ZqVRWWREC_zp_s7iTE	2020-11-10 11:25:35.108785+02
ot1lj4q3ce18opd23xgwrn4m2jdk1wqz	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kXNeN:JR21gXoGWPPqliJvpt6H0-0zHLyZJaC_-KpMCM_WImY	2020-11-10 14:00:27.549611+02
c16dyekq45jkxpeupg2ex7bvhjov437j	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kYCmv:daXs2kIXbvA1B7Xa27vLdosj48kmy7DV7D0nY4qgqYs	2020-11-12 20:36:41.41351+02
k6euk8saazvlim52zuq9xe1cgk9xgw7o	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kZvch:PnZglILqh6zPjhfbxuUdsbi1vSN2d_lGOyVQf7tjSTY	2020-11-17 14:41:15.266056+02
p9em3u3rjf8abhsbiw3c981k9p8lit7m	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kduNO:L58jTy4C8LGZ_dz5VVSzNQIl3hBxKf-I0ip1mvdxxDE	2020-11-28 14:09:54.112136+02
5nnsm076miahnuxksnwjpliagu3x9e6q	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kib3h:cv2srF_X8XjZdQZZBV_AMRcKzeFhTAQit7JqGdrw2do	2020-12-11 12:32:57.957999+02
4enlegg1pspkag9uji2w20w2p2ewyxbs	e30:1kjO1y:XkP1NVV1lQcKme6VGXlXmYNx5mkbEFTVyA_m9s8eHr8	2020-12-13 16:50:26.821656+02
3gq8uo9932klyvvmi3123xnod74hm6w9	e30:1kjO26:Pm4FFmESnpmKiDpVar5Ew4qdp282_7AqyzX0dHsFuHA	2020-12-13 16:50:34.265047+02
k54zp7js85pucflqodn3ungy4eijx8oz	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kkr8u:hQJUKjsjEK22wZbSnM2mzl9Ryho6qrwjScNhEkzbr1s	2020-12-17 18:07:40.63611+02
mpv6m7yhiuxro443etwz2kxfax3001z3	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kmuGj:6AnytghCHAquRWPfpVi6bhttdAYLHg2BgDsAuhf3m4s	2020-12-23 09:52:13.871555+02
20rfbgsa0i4u4b9p2mdatxkazblvik8g	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1koA9W:DIV66GnzRyk24gaTZ4CF6AKoyKn588kull4lEAcbcSc	2020-12-26 21:01:58.320614+02
otxl600oy1ovvehc2icem8cckqi8wg3r	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1koD8P:i_h09mtOyx6Wcq5dAVTxIFp1XP_svNvLdRzv1MSYwZ0	2020-12-27 00:13:01.619379+02
klwlifswkzegrgrx80h9076i1pm01t4a	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kq8of:2hrEjLDdjeKClHSJOghx5TFLYL5aladpO5EsRt5knaw	2021-01-01 08:00:37.780398+02
kh38vtl2uxlbimsnx42ilbv4mkc28gaa	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kr18p:AyoSn7OooMNH2m6mpOjiVkJwDJySRgd3rq_Gv5Rgh88	2021-01-03 18:01:03.489973+02
eozvxc8v7vnrmgdqedcap1q7xve1fyal	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kvT3X:stR-ufaH1yCSOXmY-9Cbjqf8wRjou7B83nIBB10TVMU	2021-01-16 00:37:59.621918+02
eeipccq7lnfatmxjgpewwtobu7f3yrtc	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kvT4q:8rw6p4Wk-__kI5wxW1DWvUYB-vjLujZHoRvAOfyGcSg	2021-01-16 00:39:20.353297+02
qgq1e3meoedln8v2i9yauoijjc4pqaxo	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1kwHwP:-UdvI3aMy36_pejE8A6Out1_rWBomyqKmDBJqhmbyfs	2021-01-18 06:58:01.440741+02
vez7b92ld1sf3z6ldohii54n8sfxo06p	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kwVuD:o4cBc0IosxXLZWxeS-Cuv6XZIZkYsoMxf56fRnLikR0	2021-01-18 21:52:41.068993+02
92zmbb1bch14netu2zwx554gb0x2kk65	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kwlof:W33ZPOoeRoWiMt1tfLae-RgMnT_Nz2v0BGhcJ9UJ-UQ	2021-01-19 14:52:01.119061+02
v47hw87mcm8d0ys8yeef8f9nn0gewilm	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kzINs:LifsBoaEevOIOrnxz3szB661zGyXEfUvsiXYZjDcBIo	2021-01-26 14:02:48.186822+02
0mo3ujklqzhwm918xh3j3ndfbpgrja2l	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1kzQA5:8oxRlN9Jh8qOBejunYt8Jju4i1NEN8d95gXsi_CMEH0	2021-01-26 22:21:05.11272+02
qx87kf53fm1tmgdzeh5tu70lkw3xrvp9	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l0kLB:tNGT_agKoTfSP6YUFvxSXQhopNw0VUgiWA4mbEWe2l0	2021-01-30 14:06:01.092372+02
4prg00twfd5q7ah94rctlpead33iygjp	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l32RA:NfiwbiTZE9J0QcMbChBhXmoX1JjdPvoeNYUyJOJAE9E	2021-02-05 21:49:40.242478+02
v5n6e7by5mqbfl4egcpye9qr5c8464z0	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l4gge:16t7Q5iR0vW7jj6jUd5YDdYmI7UhXl-YjYkqHwEIK6k	2021-02-10 11:00:28.953225+02
lm2myq4u6c5cip9tecg8wgnrbhqub71i	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l4mZu:CAgI-MwODf37wp0TPb7pttJXWWw2bqggn7n5wWu0otY	2021-02-10 17:17:54.590288+02
mgcyg1xdtkgyzfi6fcmt0ybooivf138e	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1l4oFh:RqysSTosYBfENV3xriZcMXPoTmEkyoH_Vzb6MjCktio	2021-02-10 19:05:09.892009+02
bzjei5c8y7ug22ghh2xisgz99lc16mj0	.eJxVjDkOwjAUBe_iGllesLEp6XOG6G_gALKlOKkQd4dIKaB9M_NeaoR1KePaZR4nVmfl1OF3Q6CH1A3wHeqtaWp1mSfUm6J32vXQWJ6X3f07KNDLtw7sxXlKmK1EIO_sMTFl9BJP15CJnHecIdhkGIGRDBgBcTbFHEIS9f4A88Y4XQ:1l4tGH:2L_DCsAcQS1qxjk9HHtIg4TBm0t7e8DwFwv7PDA2PlU	2021-02-11 00:26:05.82012+02
if404d8c5uqyy0r1i8suh8fqumxzpryr	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l5B8N:6OcoSnJkQ0eMiohWyEXwRx6yIGRy_q8WIcN4YVApl7Q	2021-02-11 19:31:07.107255+02
jy7itmee238f36tzwz8rj95vz62xs39s	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l6KKi:9yLiDXasMU9EKGln8OeadClLBBJ4T-z6sIIViyIIKeY	2021-02-14 23:32:36.919098+02
9qhxf5yaosvr0o552gzlnf98we82h95i	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l6dCa:pr4IptxNya6q9XWFJ6nuPu-pzypCkPOLvJtBR1fna_A	2021-02-15 19:41:28.653103+02
n0o5cyym91wy0nrcjg05huqzi23aw06f	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l6fLO:hJ90PVj-wz-ZW2tb3RZGtvQNbtIah9tJ0cGQbNF-B2E	2021-02-15 21:58:42.317446+02
u43ohyzs8aobu4i7qw9rbk1fl69l6hmn	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l7ZAR:pqTTBrlt7WZH53eHpdXcCVgcisMUWG9kQsVosLlzI9I	2021-02-18 09:35:07.518869+02
rkjrh9guyftmpck4l74ssxjrw9g8i2oy	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l8q6H:XpIQr3L07T_43O3FX2pDJ0ycFvMWcM3IrRSMxWXWTAg	2021-02-21 21:52:05.512023+02
wl73p5as2dzlbinhn4a9f7jb995someg	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l9DU4:Gr3GKp-oBDzMg4s4RVvgaBoUwx4Pl6ZjjjyxjxXz7FE	2021-02-22 22:50:12.095164+02
aqrdqpznkrgzwndry9nzovezlbu30o8p	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1l9v2G:rLOngvS2kJ0WIv7g1n8NKpNfB7j3io_ulX9rK2HR5kg	2021-02-24 21:20:24.411862+02
nhawvo27ie0qb22moe0p8o4513jyisl8	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lAYmz:pz0qtJK2C7O43r8lH3e9eCq0OixI_KxgI63WVxG83qs	2021-02-26 15:47:17.604781+02
7w4uj5twmhb3vta0e3acd6xfywwb2aue	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lAddF:4mkXYlkFAzyNq_SSTrOzipQCk_fYLfqGFlw3kIDM45Y	2021-02-26 20:57:33.791899+02
s458eoa1u9v7kkppgyj2klvdri9bnkqa	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lEdlU:HGiQdpmU21IW4srECHAkGQLn8W2axLjEkvRt-9JdQxU	2021-03-09 21:54:36.843203+02
9m45kidh3xycp6085ue1yyz42313tap3	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lEzsB:8E0zAo3ANYzmwC_Khhrlzq7tOoQPgn_cU7ZdRO0z6X0	2021-03-10 21:30:59.319339+02
83yy36aojdejh7lhq2yh8s3nx7885vft	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lFakc:b4gRrIXmo6nuS_S5MRvzifG_Qss5LLRmkucSSHkkk7s	2021-03-12 12:53:38.819677+02
rjwm4w71ub3vwfkc2dp9ky30riwvgipr	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lFjHB:2YXJgluCJ5l4n_1n8b5-Dt0QQ297FAJGdXw5pCjwFXI	2021-03-12 21:59:49.907164+02
pvut6xoswbe3ha6f3tc16dehb5x6rpup	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lFr9j:CTnxK7jBMaAdTk6dqK4D23puCa7t5FJLPoQ7iluoOyo	2021-03-13 06:24:39.240914+02
d232suz5a9crlliddftclsm3j1tcblw3	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lHM82:Pbrd0PvfOz-IxjevtNNFxyWev4-ArfTMG8QzymyLjdI	2021-03-17 09:41:06.293283+02
xs1wr3276pcmktq3azxwgj3fszlcqp21	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lIDUm:iitmfPZVAFpn5k9W-kOMBjEJDbfx2XziJIlIpGkvBsU	2021-03-19 18:40:08.190802+02
oqigsnbqjjicf7yc3zzgohvwnlnkipaq	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lLLBF:N-eXMIyOs4bbzoe82_u41R0ZT1EVffG9h-IAigUYiNo	2021-03-28 09:28:53.291818+02
x3sii36l0dcnyrx57ctt0d3xmptqxyns	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lLYFH:odtZYjhf6ka2dKfUKxWD1ySJ0Asn9XPQfo0-eMdyNtg	2021-03-28 23:25:55.363246+02
5p8uaqx5023zdhtlpt5ez3vdtj0j51c1	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lLmdt:_5aPJeeNWCCsRdedApOr-yoUKyzJp8Q_jvtcnrwZAtw	2021-03-29 14:48:17.007247+02
vod3pv81it7yiqt3e2eqqb6hfrt99d8q	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lLvBj:vKQBnkRwup8OXqSETGQpkn0iVt7CTUv9cZv5pcu6oGU	2021-03-29 23:55:47.903282+02
014qkx2rrxkaj8fdbp6rcysobkqph3n4	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lMbn8:rkkSwU4m5C517O4-x9lllUQctGqADovzH560_LHHrjQ	2021-03-31 21:25:14.774501+02
zf87tpidi8v7gmf7og0jxv7vj460xq9q	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lQYbd:84faMYRbehRyRk0X31MXFt7MyuEAWaha5qvQTtfihEI	2021-04-11 18:49:41.848178+02
b4t9sraq6sgrbpql8hlfge57o9ih6t6l	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lQamq:cGYGjFyL9pJLXhH9iqOy8V1AogCFmtxMYYZ7LcDn1WI	2021-04-11 21:09:24.048104+02
q6o4k0jzc7mx9vc1su66sik7wue00rpl	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lSZQk:XqGFvLKzV6YI4L4hIobuQIYmHo9A-BgmxaIh1D5hrQE	2021-04-17 08:06:46.159573+02
xjnyro6gyr6bqjl5e07rogosk7fhmolo	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lU4bv:PrMCPpjGQnE7QIj2BQ843slHM6FyyBOhWFkbPHaIMlw	2021-04-21 11:36:31.492567+02
jfqr4iu7gliibc6351usu6sqdersomor	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lXKgb:6LfjnRoYMNq6beHQlyUB01Y8KEeIrVUqYxNNt7dLhDc	2021-04-30 11:22:49.515579+02
6dq7105b7jrza2k2uj4wfnlek0eoay9h	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lZGHh:G7aUqaHuAweZS-LfsnBM-yRWeVemo1ecw7wjJHgSM1I	2021-05-05 19:05:05.095714+02
ehrl6m79yjvyngtbt9jbfpqedilt3hs0	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lZc6n:u7bw-_ivu7o__i61Iw6p2h7-vueQULywBVnV9iw1yRg	2021-05-06 18:23:17.467718+02
2328j7h4onq96iml9h1xpug8b1vgpyss	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lgRnl:nlaYcYUyRGsm2O2lqE2yNAfrofQxd6KNv3Eq_Akf7wI	2021-05-25 14:47:53.101972+02
xmsk0yupwovnp560ymi59vax5313ylad	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lh3b5:9O0R5CmAa_S35wvh5pb4F4qpq6dXKjAPfpHBuvfo8wQ	2021-05-27 07:09:19.369537+02
zrhhw55qkfznaxh9yyvf95kp5awxyzhe	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lhH9H:sm13yctk7iCnJ1yNVUr5I4_3rbGolpS1oeUFodt-Ao8	2021-05-27 21:37:31.141397+02
cy483lrifknu29ao8p50uv1z7ux7owps	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1loWzJ:YbulLbuhfDEcDzfrF1-e8r3D1GGeLhQOfQr_HzPdMvg	2021-06-16 21:57:13.626918+02
3ipc3fu2agsuw6s38exv4c84imgn9bdv	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lqYaU:bUqlQ5Byg7tUqi7lThpsC9e8tW1MGlyWUagokcW0PIQ	2021-06-22 12:03:58.993782+02
gnhfwq6ajn22i8mfj8hg2215nqpoubpd	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1ltr7X:vb3bemtojh69DHWEyh7ivFcvmr6RL6yBXGFXJpeTCdY	2021-07-01 14:27:43.016003+02
s7mchc1mqp5g5giy5rfc3e38lcotwq9f	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lvGwZ:9vDwC3RBXukNwc-pOEwNCMgjv7Ft7m4kKXzdtOgfUq8	2021-07-05 12:14:15.075811+02
pxomn4k45ow39getjj3ophhzu0j7swhx	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1lzm58:-WrUuml_OOpncW7w18nAT8HASSAwHCr1GHzOscbgH64	2021-07-17 22:17:42.948287+02
nq12haznn1bphudp18zf6goz15jxd2tz	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1m1Qnm:TErz47XxoT3d80PwWjhOja_hYrjMA3UwEVhnigcgpaE	2021-07-22 11:58:38.091534+02
avre0afl08k50gxsglxamh1mobhgzd2t	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1m1mt2:AsVK39M2EWweMUPWTa8Vibe5G3jec_y3jNJOb3Ly3YI	2021-07-23 11:33:32.130629+02
dkqz6bhp70k0qpu3zt9xf8wfqak8ky6d	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1m1oTX:KayI0LMxfcqMcUywNxRieVKwXyDucBL-5zAHi2Z1qpc	2021-07-23 13:15:19.274105+02
xkgqg3xnhz59alfdl00ood69g75vkng6	.eJxVjEEOwiAQRe_C2hAYwIJL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgILU6_W8L84LYDumO7zTLPbV2mJHdFHrTLcSZ-Xg_376Bir9-6OJfAhIA2sALUShMF43wgBnc2in1JOSk7oDVk2RRgAvCY0-AdaCfeH9bmN50:1m4OWL:-FkXSORkyevRFGwa8LwRkVY-HR6lD7rfGy63bC1DOXc	2021-07-30 16:08:53.71998+02
\.


--
-- Data for Name: expense_expense; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.expense_expense (id, created, modified, date, description, method, amount) FROM stdin;
1	2021-01-27 17:40:04.964921+02	2021-01-27 17:40:04.964942+02	2021-01-23 02:00:00+02	Petrol	CARD	600
2	2021-01-27 17:40:51.552646+02	2021-01-27 17:40:51.552668+02	2021-01-08 02:00:00+02	Petrol	CARD	600
3	2021-01-27 17:50:23.244267+02	2021-01-27 17:50:23.244295+02	2021-01-12 02:00:00+02	Offload container	CASH	2000
4	2021-01-27 17:52:08.71673+02	2021-01-27 17:52:08.716751+02	2021-01-13 02:00:00+02	Unit 6004 Rent & Lock, Tag	EFT	2368.09
5	2021-01-27 17:53:17.878409+02	2021-01-27 17:53:17.878433+02	2021-01-12 02:00:00+02	Unit 7004 Rent, Lock, Tag	EFT	1930.23
6	2021-01-27 17:54:04.06445+02	2021-01-27 17:54:04.064477+02	2021-01-12 02:00:00+02	Unit 7003 Rent, Lock, Tag	EFT	1930.23
7	2021-01-27 17:54:53.721401+02	2021-01-27 17:54:53.721428+02	2020-12-19 02:00:00+02	Unit 5015	EFT	1653.75
8	2021-01-27 17:55:53.192393+02	2021-01-27 17:55:53.192419+02	2021-01-27 02:00:00+02	Units 5015,6004,7003,7004	EFT	5242.5
9	2021-01-27 17:56:30.540823+02	2021-01-27 17:56:30.540851+02	2021-01-28 02:00:00+02	Delivery Fee	EFT	500
\.


--
-- Data for Name: invoice_invoice; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.invoice_invoice (id, created, modified, status, number, buyer_id, order_id, closed_date) FROM stdin;
48	2021-01-25 13:24:41.266594+02	2021-01-28 23:49:16.633172+02	CLOSED	WALTER-INV-202101251123	1	54	2021-01-25 13:24:41.266594+02
86	2021-03-05 21:41:30.43637+02	2021-03-12 09:23:39.964308+02	CLOSED	WALTER-INV-202103051940	1	92	2021-03-12 09:23:39.964181+02
49	2021-01-27 10:44:19.946034+02	2021-01-31 14:38:57.912377+02	CLOSED	WALTER-INV-202101270835	1	55	2021-01-31 14:38:57.912246+02
75	2021-02-23 18:54:20.570395+02	2021-02-25 11:50:29.745629+02	CLOSED	WALTER-INV-202102231652	1	82	2021-02-25 11:50:29.745473+02
1	2020-10-01 21:44:59.35743+02	2021-01-28 23:49:16.460431+02	CLOSED	JACO-INV-2020100119	2	1	2020-10-01 21:44:59.35743+02
2	2020-10-09 18:17:15.526332+02	2021-01-28 23:49:16.465602+02	CLOSED	FREDDIE-INV-2020100916	3	2	2020-10-09 18:17:15.526332+02
3	2020-10-09 18:35:38.701473+02	2021-01-28 23:49:16.469667+02	CLOSED	VILLAGEHARDWAREANDPAINT-INV-2020100916	4	3	2020-10-09 18:35:38.701473+02
4	2020-10-10 12:44:06.804633+02	2021-01-28 23:49:16.473801+02	CLOSED	WALTER-INV-2020101010	1	4	2020-10-10 12:44:06.804633+02
6	2020-10-12 09:11:25.863966+02	2021-01-28 23:49:16.478499+02	CLOSED	NEWTON-INV-2020101207	5	6	2020-10-12 09:11:25.863966+02
7	2020-10-12 11:34:25.11202+02	2021-01-28 23:49:16.481772+02	CLOSED	WALTER-INV-2020101209	1	7	2020-10-12 11:34:25.11202+02
10	2020-10-20 11:04:29.729981+02	2021-01-28 23:49:16.492743+02	CLOSED	WALTER-INV-2020102009	1	10	2020-10-20 11:04:29.729981+02
13	2020-10-22 15:01:54.650235+02	2021-01-28 23:49:16.50336+02	CLOSED	WALTER-INV-2020102213	1	13	2020-10-22 15:01:54.650235+02
14	2020-10-23 09:13:47.285237+02	2021-01-28 23:49:16.50707+02	CLOSED	NEWTON-INV-2020102306	5	14	2020-10-23 09:13:47.285237+02
15	2020-10-27 11:26:25.453033+02	2021-01-28 23:49:16.510743+02	CLOSED	WALTER-INV-2020102709	1	15	2020-10-27 11:26:25.453033+02
16	2020-10-28 08:53:28.839082+02	2021-01-28 23:49:16.520957+02	CLOSED	NEWTON-INV-2020102806	5	16	2020-10-28 08:53:28.839082+02
18	2020-10-28 12:16:07.359818+02	2021-01-28 23:49:16.528318+02	CLOSED	DODO-INV-2020102810	6	18	2020-10-28 12:16:07.359818+02
20	2020-11-02 15:56:57.806487+02	2021-01-28 23:49:16.535732+02	CLOSED	DODO-INV-2020110213	6	20	2020-11-02 15:56:57.806487+02
21	2020-11-04 15:35:09.277021+02	2021-01-28 23:49:16.539472+02	CLOSED	WALTER-INV-2020110413	1	21	2020-11-04 15:35:09.277021+02
26	2020-12-03 19:07:18.66243+02	2021-01-28 23:49:16.554356+02	CLOSED	DODO-INV-2020120317	6	31	2020-12-03 19:07:18.66243+02
34	2021-01-08 09:03:43.777717+02	2021-01-28 23:49:16.58186+02	CLOSED	WALTER-INV-2021010807	1	40	2021-01-08 09:03:43.777717+02
36	2021-01-13 13:46:06.528845+02	2021-01-28 23:49:16.588887+02	CLOSED	WALTER-INV-202101131145	1	42	2021-01-13 13:46:06.528845+02
37	2021-01-13 13:47:49.115155+02	2021-01-28 23:49:16.592443+02	CLOSED	YING-INV-202101131147	8	43	2021-01-13 13:47:49.115155+02
38	2021-01-13 13:49:31.276279+02	2021-01-28 23:49:16.602144+02	CLOSED	WALTER-INV-202101131149	1	44	2021-01-13 13:49:31.276279+02
39	2021-01-15 19:05:23.108282+02	2021-01-28 23:49:16.605585+02	CLOSED	WALTER-INV-202101151651	1	45	2021-01-15 19:05:23.108282+02
40	2021-01-19 07:46:59.74161+02	2021-01-28 23:49:16.608971+02	CLOSED	WALTER-INV-202101190546	1	46	2021-01-19 07:46:59.74161+02
41	2021-01-19 16:41:02.578246+02	2021-01-28 23:49:16.612408+02	CLOSED	NEWTON-INV-202101190549	5	47	2021-01-19 16:41:02.578246+02
42	2021-01-19 16:45:59.233062+02	2021-01-28 23:49:16.615899+02	CLOSED	WALTER-INV-202101191443	1	48	2021-01-19 16:45:59.233062+02
43	2021-01-19 17:06:30.573364+02	2021-01-28 23:49:16.619317+02	CLOSED	YING-INV-202101191505	8	49	2021-01-19 17:06:30.573364+02
44	2021-01-21 09:12:54.949011+02	2021-01-28 23:49:16.622723+02	CLOSED	WALTER-INV-202101210708	1	50	2021-01-21 09:12:54.949011+02
76	2021-02-26 11:58:28.827323+02	2021-02-26 11:59:17.955867+02	CLOSED	YING-INV-202102260958	8	83	2021-02-26 11:59:17.955754+02
59	2021-02-01 19:10:28.41841+02	2021-02-01 22:16:31.700935+02	CLOSED	DURANDT-INV-202102011709	10	65	2021-02-01 22:16:31.700793+02
46	2021-01-25 13:18:03.934078+02	2021-01-28 23:49:16.6262+02	CLOSED	WALTER-INV-202101251114	1	52	2021-01-25 13:18:03.934078+02
55	2021-01-30 12:03:43.402387+02	2021-02-01 22:16:47.062526+02	CLOSED	WALTER-INV-202101301003	1	61	2021-02-01 22:16:47.062417+02
47	2021-01-25 13:21:14.992839+02	2021-01-28 23:49:16.629664+02	CLOSED	WALTER-INV-202101251117	1	53	2021-01-25 13:21:14.992839+02
82	2021-02-28 21:59:56.514841+02	2021-06-02 21:57:58.924092+02	CLOSED	JOSH-INV-202102281959	9	88	2021-06-02 21:57:58.923825+02
45	2021-01-25 08:07:20.545919+02	2021-02-04 14:07:00.695286+02	CLOSED	JOSH-INV-202101250606	9	51	2021-02-04 14:07:00.695137+02
71	2021-02-19 17:34:03.667346+02	2021-02-27 06:28:10.826584+02	CLOSED	JOSH-INV-202102191533	9	77	2021-02-27 06:28:10.826435+02
22	2020-11-14 14:11:42.987365+02	2021-01-28 10:20:10.846443+02	OUTSTANDING	VILLAGEPAINTANDHARDWARE-INV-2020111412	4	22	\N
61	2021-02-03 09:08:50.2345+02	2021-02-05 12:21:24.008104+02	CLOSED	WALTER-INV-202102030707	1	67	2021-02-05 12:21:24.007984+02
63	2021-02-04 20:07:45.626452+02	2021-02-08 11:31:28.30676+02	CLOSED	WALTER-INV-202102041806	1	69	2021-02-08 11:31:28.306621+02
102	2021-04-21 19:09:03.404121+02	2021-04-21 19:09:47.031373+02	CLOSED	WALTER-INV-202104211706	1	109	2021-04-21 19:09:47.031265+02
80	2021-02-28 21:57:55.036922+02	2021-02-28 21:58:18.814935+02	CLOSED	JOSH-INV-202102281957	9	86	2021-02-28 21:58:18.814796+02
69	2021-02-13 08:35:04.890415+02	2021-02-16 14:58:39.248508+02	CLOSED	WALTER-INV-202102130634	1	75	2021-02-16 14:58:39.248376+02
94	2021-03-19 10:53:50.543876+02	2021-03-22 20:48:57.326218+02	CLOSED	WALTER-INV-202103190852	1	100	2021-03-22 20:48:57.326101+02
92	2021-03-18 08:18:41.252068+02	2021-03-22 20:53:17.882227+02	CLOSED	WALTER-INV-202103180617	1	98	2021-03-22 20:53:17.882054+02
104	2021-04-22 14:41:15.238249+02	2021-04-27 19:47:24.693174+02	CLOSED	WALTER-INV-202104221239	1	111	2021-04-27 19:47:24.693005+02
84	2021-03-03 19:56:12.207875+02	2021-03-06 03:18:16.805884+02	CLOSED	WALTER-INV-202103031755	1	90	2021-03-06 03:18:16.805724+02
96	2021-03-28 18:53:38.587486+02	2021-03-28 18:54:06.551999+02	CLOSED	WALTER-INV-202103281649	1	102	2021-03-28 18:54:06.551857+02
88	2021-03-11 15:05:11.077245+02	2021-03-12 09:23:25.469029+02	CLOSED	WALTER-INV-202103111304	1	94	2021-03-12 09:23:25.468921+02
111	2021-06-02 22:01:20.334086+02	2021-06-02 22:02:15.851353+02	CLOSED	JOSH-INV-202106021958	9	118	2021-06-02 22:02:15.851223+02
98	2021-03-31 17:30:48.467953+02	2021-03-31 17:31:05.406782+02	CLOSED	WALTER-INV-202103311530	1	104	2021-03-31 17:31:05.406636+02
106	2021-05-13 21:38:15.067839+02	2021-05-13 21:41:16.206524+02	CLOSED	WALTER-INV-202105131937	1	113	2021-05-13 21:41:16.206382+02
100	2021-04-07 19:19:30.365067+02	2021-04-21 19:05:49.015341+02	CLOSED	WALTER-INV-202104071719	1	106	2021-04-21 19:05:49.015237+02
116	2021-07-09 11:43:10.665339+02	2021-07-09 11:57:45.221557+02	CLOSED	YING-INV-202107090939	8	123	2021-07-09 11:57:45.221379+02
113	2021-06-02 22:10:59.022132+02	2021-06-02 22:11:38.269728+02	CLOSED	WALTER-INV-202106022004	1	120	2021-06-02 22:11:38.269624+02
118	2021-07-09 12:29:23.226319+02	2021-07-09 12:30:24.854706+02	CLOSED	YING-INV-202107091029	8	125	2021-07-09 12:30:24.854584+02
114	2021-06-12 21:50:30.330645+02	2021-06-12 21:52:15.309407+02	CLOSED	WALTER-INV-202106121949	1	121	2021-06-12 21:52:15.309259+02
120	2021-07-15 13:55:51.678686+02	2021-07-15 13:55:55.659987+02	OUTSTANDING	WALTER-INV-202107151154	1	127	\N
50	2021-01-28 12:14:02.019411+02	2021-01-30 12:02:47.268516+02	CLOSED	DODO-INV-202101281012	6	56	2021-01-30 12:02:47.268218+02
51	2021-01-28 12:22:29.006475+02	2021-01-31 14:37:59.550797+02	CLOSED	WALTER-INV-202101281021	1	57	2021-01-31 14:37:59.550642+02
54	2021-01-28 19:22:40.792836+02	2021-01-31 14:38:16.157536+02	CLOSED	WALTER-INV-202101281721	1	60	2021-01-31 14:38:16.157326+02
97	2021-03-29 12:38:09.108637+02	2021-03-31 09:56:10.389728+02	CLOSED	KEITH-INV-202103291037	7	103	2021-03-31 09:56:10.389581+02
81	2021-02-28 21:59:00.715173+02	2021-02-28 21:59:04.475854+02	OUTSTANDING	JOSH-INV-202102281958	9	87	\N
74	2021-02-23 09:20:24.328581+02	2021-03-31 17:31:55.471695+02	CLOSED	NEWTON-INV-202102230716	5	81	2021-03-31 17:31:55.471555+02
83	2021-03-02 12:22:28.439541+02	2021-03-02 12:23:18.138703+02	CLOSED	WALTER-INV-202103021022	1	89	2021-03-02 12:23:18.13856+02
60	2021-02-02 13:57:25.816182+02	2021-02-05 12:21:45.447245+02	CLOSED	WALTER-INV-202102021156	1	66	2021-02-05 12:21:45.447116+02
56	2021-02-01 09:10:50.856414+02	2021-02-05 12:21:52.574934+02	CLOSED	WALTER-INV-202102010708	1	62	2021-02-05 12:21:52.574752+02
58	2021-02-01 13:53:35.656941+02	2021-02-05 12:21:58.260441+02	CLOSED	JOSH-INV-202102011153	9	64	2021-02-05 12:21:58.26023+02
77	2021-02-26 22:00:19.814301+02	2021-03-03 19:54:03.804922+02	CLOSED	WALTER-INV-202102261959	1	84	2021-03-03 19:54:03.804782+02
52	2021-01-28 12:27:30.695364+02	2021-01-28 12:27:41.520593+02	OUTSTANDING	VILLAGEPAINTANDHARDWARE-INV-202101281026	4	58	\N
53	2021-01-28 12:28:54.315514+02	2021-01-28 12:28:57.936297+02	OUTSTANDING	VILLAGEPAINTANDHARDWARE-INV-202101281028	4	59	\N
85	2021-03-04 22:29:30.439529+02	2021-03-06 03:18:07.724031+02	CLOSED	WALTER-INV-202103042029	1	91	2021-03-06 03:18:07.723869+02
8	2020-10-19 13:45:13.566737+02	2021-01-28 23:49:16.485343+02	CLOSED	WALTER-INV-2020101911	1	8	2020-10-19 13:45:13.566737+02
9	2020-10-20 09:01:21.106356+02	2021-01-28 23:49:16.489084+02	CLOSED	NEWTON-INV-2020102007	5	9	2020-10-20 09:01:21.106356+02
11	2020-10-20 14:18:28.130188+02	2021-01-28 23:49:16.496238+02	CLOSED	DODO-INV-2020102012	6	11	2020-10-20 14:18:28.130188+02
12	2020-10-22 15:00:36.846777+02	2021-01-28 23:49:16.499777+02	CLOSED	DODO-INV-2020102213	6	12	2020-10-22 15:00:36.846777+02
17	2020-10-28 10:36:47.777947+02	2021-01-28 23:49:16.524594+02	CLOSED	WALTER-INV-2020102808	1	17	2020-10-28 10:36:47.777947+02
19	2020-10-29 20:44:29.395212+02	2021-01-28 23:49:16.532052+02	CLOSED	WALTER-INV-2020102918	1	19	2020-10-29 20:44:29.395212+02
23	2020-11-16 16:57:11.977789+02	2021-01-28 23:49:16.543205+02	CLOSED	NEWTON-INV-2020111614	5	23	2020-11-16 16:57:11.977789+02
24	2020-11-24 19:21:15.436784+02	2021-01-28 23:49:16.546937+02	CLOSED	WALTER-INV-2020112417	1	24	2020-11-24 19:21:15.436784+02
25	2020-12-03 18:09:38.740126+02	2021-01-28 23:49:16.550749+02	CLOSED	DODO-INV-2020120316	6	25	2020-12-03 18:09:38.740126+02
27	2020-12-03 20:25:27.849089+02	2021-01-28 23:49:16.557849+02	CLOSED	DODO-INV-2020120318	6	33	2020-12-03 20:25:27.849089+02
28	2020-12-09 10:23:12.259736+02	2021-01-28 23:49:16.561495+02	CLOSED	WALTER-INV-2020120908	1	34	2020-12-09 10:23:12.259736+02
29	2020-12-10 14:11:16.227339+02	2021-01-28 23:49:16.565111+02	CLOSED	KEITH-INV-2020121012	7	35	2020-12-10 14:11:16.227339+02
30	2020-12-17 13:37:15.670298+02	2021-01-28 23:49:16.568548+02	CLOSED	KEITH-INV-2020121711	7	36	2020-12-17 13:37:15.670298+02
31	2021-01-04 13:55:24.571777+02	2021-01-28 23:49:16.571968+02	CLOSED	WALTER-INV-2021010411	1	37	2021-01-04 13:55:24.571777+02
32	2021-01-04 13:56:12.758754+02	2021-01-28 23:49:16.575188+02	CLOSED	NEWTON-INV-2021010411	5	38	2021-01-04 13:56:12.758754+02
33	2021-01-07 19:40:59.425781+02	2021-01-28 23:49:16.578616+02	CLOSED	NEWTON-INV-2021010717	5	39	2021-01-07 19:40:59.425781+02
35	2021-01-12 23:04:03.359247+02	2021-01-28 23:49:16.585373+02	CLOSED	YING-INV-2021011114	8	41	2021-01-12 23:04:03.359247+02
99	2021-03-31 17:32:40.1647+02	2021-04-02 23:16:39.577658+02	CLOSED	NEWTON-INV-202103311532	5	105	2021-04-02 23:16:39.577491+02
87	2021-03-08 21:55:18.957043+02	2021-03-12 09:23:32.556661+02	CLOSED	WALTER-INV-202103081954	1	93	2021-03-12 09:23:32.556539+02
66	2021-02-11 13:08:48.36789+02	2021-02-14 20:10:12.360457+02	CLOSED	WALTER-INV-202102111104	1	72	2021-02-14 20:10:12.360307+02
68	2021-02-12 15:51:37.178875+02	2021-02-16 14:58:45.999518+02	CLOSED	KEITH-INV-202102121350	7	74	2021-02-16 14:58:45.999363+02
112	2021-06-02 22:03:41.861726+02	2021-06-12 21:49:05.630349+02	CLOSED	WALTER-INV-202106022003	1	119	2021-06-12 21:49:05.630233+02
89	2021-03-14 09:29:37.885793+02	2021-03-14 12:19:30.908225+02	CLOSED	WALTER-INV-202103140728	1	95	2021-03-14 12:19:30.908112+02
70	2021-02-17 17:18:58.798879+02	2021-02-23 11:50:07.975312+02	CLOSED	WALTER-INV-202102171518	1	76	2021-02-23 11:50:07.975115+02
72	2021-02-22 19:12:29.091745+02	2021-02-24 18:59:23.947116+02	CLOSED	WALTER-INV-202102221711	1	78	2021-02-24 18:59:23.946942+02
101	2021-04-07 19:26:20.187131+02	2021-04-21 19:06:15.232903+02	CLOSED	DANIELSENGAI-INV-202104071725	11	108	2021-04-21 19:06:15.232801+02
79	2021-02-28 21:54:44.063221+02	2021-02-28 21:55:37.494916+02	CLOSED	JOSH-INV-202102221712	9	79	2021-02-28 21:55:37.494814+02
115	2021-06-12 21:55:23.108369+02	2021-06-21 21:50:27.395691+02	CLOSED	KEITH-INV-202106121952	7	122	2021-06-21 21:50:27.39557+02
103	2021-04-21 19:10:45.736436+02	2021-04-24 20:10:05.314118+02	CLOSED	WALTER-INV-202104211710	1	110	2021-04-24 20:10:05.31401+02
91	2021-03-16 08:54:43.370738+02	2021-03-22 20:53:25.077726+02	CLOSED	WALTER-INV-202103151019	1	97	2021-03-22 20:53:25.07758+02
93	2021-03-18 14:24:01.379847+02	2021-03-24 13:22:23.277802+02	CLOSED	KEITH-INV-202103181223	7	99	2021-03-24 13:22:23.277694+02
95	2021-03-24 13:28:21.840825+02	2021-03-28 08:08:43.97741+02	CLOSED	KEITH-INV-202103241123	7	101	2021-03-28 08:08:43.977256+02
105	2021-04-24 20:10:47.624129+02	2021-04-27 19:47:14.668933+02	CLOSED	WALTER-INV-202104241810	1	112	2021-04-27 19:47:14.668788+02
117	2021-07-09 12:23:42.281802+02	2021-07-09 12:25:23.496099+02	CLOSED	YING-INV-202107091022	8	124	2021-07-09 12:25:23.495932+02
62	2021-02-04 14:11:00.344744+02	2021-06-02 22:02:52.026126+02	CLOSED	JOSH-INV-202102041209	9	68	2021-06-02 22:02:52.026026+02
119	2021-07-09 13:58:05.36464+02	2021-07-09 13:58:48.64764+02	CLOSED	NEWTON-INV-202107091156	5	126	2021-07-09 13:58:48.647496+02
121	2021-07-16 15:24:35.352968+02	2021-07-16 15:25:08.801226+02	OUTSTANDING	WALTER-INV-202107161322	1	128	\N
\.


--
-- Data for Name: invoice_payment; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.invoice_payment (id, created, modified, amount, invoice_id, method, status) FROM stdin;
35	2021-01-15 18:51:20.145613+02	2021-01-27 23:39:01.244044+02	4290	36	EFT	CONFIRMED
36	2021-01-15 18:51:30.750642+02	2021-01-27 23:39:01.269531+02	225	38	EFT	CONFIRMED
10	2020-10-23 22:52:41.619881+02	2021-01-27 23:39:01.296334+02	2240	14	EFT	CONFIRMED
37	2021-01-19 07:46:24.612089+02	2021-01-27 23:39:01.312532+02	3555	39	EFT	CONFIRMED
32	2021-01-11 10:35:03.154907+02	2021-01-27 23:39:01.337161+02	8000	3	EFT	CONFIRMED
44	2021-01-27 10:57:34.262611+02	2021-01-27 23:39:01.343166+02	8000	3	EFT	CONFIRMED
11	2020-10-24 03:28:54.674594+02	2021-01-27 23:39:01.35934+02	1400	10	EFT	CONFIRMED
38	2021-01-19 16:43:41.648208+02	2021-01-27 23:39:01.373574+02	1320	41	CASH	CONFIRMED
12	2020-10-24 03:29:17.921645+02	2021-01-27 23:39:01.387717+02	26125	13	EFT	CONFIRMED
23	2020-12-08 15:58:29.885488+02	2021-01-27 23:39:01.411336+02	3300	26	EFT	CONFIRMED
39	2021-01-19 17:08:04.689071+02	2021-01-27 23:39:01.425919+02	0	43	CASH	CONFIRMED
40	2021-01-21 09:08:02.861756+02	2021-01-27 23:39:01.440241+02	5600	40	EFT	CONFIRMED
13	2020-10-28 08:53:51.121289+02	2021-01-27 23:39:01.454321+02	4800	16	CASH	CONFIRMED
41	2021-01-23 21:10:35.878292+02	2021-01-27 23:39:01.468639+02	13475	42	EFT	CONFIRMED
34	2021-01-13 13:48:25.479693+02	2021-01-27 23:39:01.485676+02	0	37	EFT	CONFIRMED
42	2021-01-24 20:43:04.782845+02	2021-01-27 23:39:01.500258+02	9850	44	EFT	CONFIRMED
14	2020-10-28 12:16:56.221403+02	2021-01-27 23:39:01.520226+02	3850	18	CASH	CONFIRMED
17	2020-11-02 16:00:12.066254+02	2021-01-27 23:39:01.534659+02	12950	15	EFT	CONFIRMED
18	2020-11-04 15:33:44.417498+02	2021-01-27 23:39:01.551639+02	13530	20	EFT	CONFIRMED
1	2020-10-06 10:07:53.81594+02	2021-01-27 23:39:01.569064+02	14500	1	EFT	CONFIRMED
2	2020-10-09 18:17:59.577078+02	2021-01-27 23:39:01.583303+02	3300	2	EFT	CONFIRMED
19	2020-11-09 11:03:16.116988+02	2021-01-27 23:39:01.597703+02	2640	21	EFT	CONFIRMED
3	2020-10-10 20:36:28.075404+02	2021-01-27 23:39:01.612341+02	6600	4	EFT	CONFIRMED
4	2020-10-12 09:11:49.152966+02	2021-01-27 23:39:01.626721+02	6400	6	CASH	CONFIRMED
31	2021-01-11 10:34:09.460368+02	2021-01-27 23:39:01.64068+02	5445	34	EFT	CONFIRMED
5	2020-10-19 13:43:44.956301+02	2021-01-27 23:39:01.654867+02	6165	7	EFT	CONFIRMED
20	2020-11-16 16:57:31.634332+02	2021-01-27 23:39:01.676729+02	2240	23	CASH	CONFIRMED
6	2020-10-20 09:02:01.565338+02	2021-01-27 23:39:01.694173+02	1920	9	CASH	CONFIRMED
21	2020-12-03 18:08:06.697473+02	2021-01-27 23:39:01.711223+02	8110	24	EFT	CONFIRMED
33	2021-01-12 23:05:56.370155+02	2021-01-27 23:39:01.739628+02	0	35	EFT	CONFIRMED
7	2020-10-20 14:18:44.173851+02	2021-01-27 23:39:01.765662+02	12250	11	EFT	CONFIRMED
8	2020-10-21 20:14:22.728302+02	2021-01-27 23:39:01.780514+02	5250	8	EFT	CONFIRMED
22	2020-12-03 18:09:54.868646+02	2021-01-27 23:39:01.794638+02	2475	25	CASH	CONFIRMED
9	2020-10-22 15:00:58.854698+02	2021-01-27 23:39:01.808987+02	3300	12	CASH	CONFIRMED
24	2020-12-11 11:26:11.834209+02	2021-01-27 23:39:01.823386+02	6600	28	EFT	CONFIRMED
25	2020-12-15 09:43:12.430113+02	2021-01-27 23:39:01.848727+02	4290	29	EFT	CONFIRMED
15	2020-11-02 15:59:23.487852+02	2021-01-27 23:39:01.865623+02	1815	19	EFT	CONFIRMED
16	2020-11-02 15:59:34.155392+02	2021-01-27 23:39:01.882622+02	13200	17	EFT	CONFIRMED
26	2020-12-20 17:55:45.042664+02	2021-01-27 23:39:01.898311+02	10560	30	EFT	CONFIRMED
27	2020-12-20 18:02:48.211964+02	2021-01-27 23:39:01.918351+02	5610	27	CASH	CONFIRMED
28	2021-01-04 13:57:08.962623+02	2021-01-27 23:39:01.939145+02	9600	32	CASH	CONFIRMED
29	2021-01-06 09:59:39.907881+02	2021-01-27 23:39:01.956232+02	3960	31	EFT	CONFIRMED
30	2021-01-07 19:42:48.383993+02	2021-01-27 23:39:01.969623+02	5120	33	CASH	CONFIRMED
71	2021-02-24 19:01:57.192347+02	2021-02-24 19:01:57.192374+02	9525	75	CASH	CONFIRMED
48	2021-01-28 00:31:51.757072+02	2021-01-28 00:33:34.327687+02	3795	47	EFT	CONFIRMED
72	2021-02-25 11:50:20.580593+02	2021-02-25 11:50:29.727453+02	6645	75	EFT	CONFIRMED
46	2021-01-28 00:28:38.836655+02	2021-01-28 00:31:09.680247+02	9100	48	EFT	CONFIRMED
49	2021-01-28 00:34:04.420473+02	2021-01-28 00:35:00.908205+02	3630	46	EFT	CONFIRMED
50	2021-01-30 12:02:36.124052+02	2021-01-30 12:02:47.252999+02	12210	50	EFT	CONFIRMED
52	2021-01-31 14:37:33.622714+02	2021-01-31 14:37:59.535488+02	6930	51	EFT	CONFIRMED
51	2021-01-31 14:36:51.4386+02	2021-01-31 14:38:16.13253+02	1650	54	EFT	CONFIRMED
53	2021-01-31 14:38:51.27093+02	2021-01-31 14:38:57.89855+02	7000	49	EFT	CONFIRMED
55	2021-02-01 22:16:47.046433+02	2021-02-02 13:50:06.823107+02	6460	55	EFT	CONFIRMED
54	2021-02-01 22:16:31.685846+02	2021-02-03 09:06:52.244772+02	8475	59	EFT	CONFIRMED
57	2021-02-04 14:06:48.204064+02	2021-02-04 14:06:55.113736+02	400	45	EFT	CONFIRMED
43	2021-01-26 11:17:23.444699+02	2021-02-04 14:07:00.680495+02	1175	45	EFT	CONFIRMED
59	2021-02-04 14:07:47.874403+02	2021-02-05 12:21:23.992598+02	8745	61	EFT	CONFIRMED
60	2021-02-04 14:08:15.875332+02	2021-02-05 12:21:45.431833+02	4785	60	EFT	CONFIRMED
58	2021-02-04 14:07:36.613682+02	2021-02-05 12:21:52.5599+02	8910	56	EFT	CONFIRMED
56	2021-02-04 14:06:01.087797+02	2021-02-05 12:21:58.244189+02	1650	58	EFT	CONFIRMED
61	2021-02-06 11:07:55.564091+02	2021-02-08 11:31:28.290481+02	8575	63	EFT	CONFIRMED
62	2021-02-12 21:19:30.350728+02	2021-02-14 20:10:12.3438+02	14010	66	EFT	CONFIRMED
64	2021-02-14 20:12:19.170779+02	2021-02-16 14:58:39.230264+02	1650	69	EFT	CONFIRMED
63	2021-02-14 20:11:55.694213+02	2021-02-16 14:58:45.983548+02	12965	68	EFT	CONFIRMED
68	2021-02-23 11:50:07.955678+02	2021-02-23 11:50:07.9557+02	8750	70	CASH	CONFIRMED
69	2021-02-23 11:52:03.076278+02	2021-02-23 11:52:03.076299+02	5250	72	CASH	CONFIRMED
70	2021-02-24 18:59:23.924225+02	2021-02-24 18:59:23.924244+02	2975	72	CASH	CONFIRMED
65	2021-02-22 19:16:26.552695+02	2021-02-26 07:34:50.929285+02	4700	71	EFT	CONFIRMED
73	2021-02-26 07:35:26.745259+02	2021-02-26 07:35:31.876585+02	1000	71	EFT	CONFIRMED
80	2021-03-03 19:54:03.790612+02	2021-03-03 19:54:03.790634+02	800	77	CASH	CONFIRMED
74	2021-02-26 11:59:07.673075+02	2021-02-26 11:59:17.941682+02	0	76	EFT	CONFIRMED
75	2021-02-27 06:27:55.318546+02	2021-02-27 06:28:10.811491+02	75	71	EFT	CONFIRMED
76	2021-02-28 21:55:31.651129+02	2021-02-28 21:55:37.476836+02	660	79	EFT	CONFIRMED
77	2021-02-28 21:58:13.178845+02	2021-02-28 21:58:18.797412+02	4950	80	EFT	CONFIRMED
79	2021-03-02 12:23:18.122447+02	2021-03-02 12:23:18.122471+02	11550	83	CASH	CONFIRMED
78	2021-03-02 07:27:42.591241+02	2021-03-03 19:53:51.233764+02	9000	77	EFT	CONFIRMED
82	2021-03-04 22:31:03.169762+02	2021-03-06 03:18:07.706946+02	9240	85	EFT	CONFIRMED
81	2021-03-04 22:27:59.405558+02	2021-03-06 03:18:16.787661+02	20625	84	EFT	CONFIRMED
83	2021-03-07 09:03:40.517715+02	2021-03-09 00:10:51.566429+02	31000	86	EFT	CONFIRMED
85	2021-03-12 07:07:12.248289+02	2021-03-12 09:23:25.44528+02	3300	88	EFT	CONFIRMED
86	2021-03-12 07:07:21.21871+02	2021-03-12 09:23:25.459501+02	3300	88	EFT	CONFIRMED
87	2021-03-12 07:08:25.418694+02	2021-03-12 09:23:32.545546+02	3300	87	EFT	CONFIRMED
84	2021-03-12 07:06:37.602123+02	2021-03-12 09:23:39.950738+02	1470	86	EFT	CONFIRMED
88	2021-03-14 12:19:26.577752+02	2021-03-14 12:19:30.890423+02	3300	89	EFT	CONFIRMED
89	2021-03-22 20:48:52.208157+02	2021-03-22 20:48:57.308646+02	28050	94	EFT	CONFIRMED
90	2021-03-22 20:50:29.681786+02	2021-03-22 20:53:17.854721+02	6600	92	EFT	CONFIRMED
91	2021-03-22 20:50:37.276334+02	2021-03-22 20:53:17.869734+02	225	92	EFT	CONFIRMED
92	2021-03-22 20:52:19.511045+02	2021-03-22 20:53:25.055096+02	8345	91	EFT	CONFIRMED
93	2021-03-24 13:22:18.845843+02	2021-03-24 13:22:23.258976+02	6600	93	EFT	CONFIRMED
67	2021-02-23 09:21:05.388138+02	2021-03-28 08:08:34.546745+02	2400	74	EFT	CONFIRMED
94	2021-03-25 21:51:05.278301+02	2021-03-28 08:08:43.961703+02	6000	95	EFT	CONFIRMED
95	2021-03-28 18:54:02.213022+02	2021-03-28 18:54:06.534946+02	8780	96	EFT	CONFIRMED
96	2021-03-31 09:56:06.580062+02	2021-03-31 09:56:10.369123+02	2640	97	EFT	CONFIRMED
97	2021-03-31 17:31:01.822575+02	2021-03-31 17:31:05.388636+02	13650	98	EFT	CONFIRMED
98	2021-03-31 17:31:55.456244+02	2021-03-31 17:31:55.456267+02	570	74	CASH	CONFIRMED
99	2021-03-31 17:33:59.548031+02	2021-03-31 17:33:59.54805+02	2430	99	CASH	CONFIRMED
100	2021-04-02 23:16:39.558533+02	2021-04-02 23:16:39.558561+02	5820	99	CASH	CONFIRMED
101	2021-04-21 19:05:41.953602+02	2021-04-21 19:05:48.997872+02	1650	100	EFT	CONFIRMED
102	2021-04-21 19:06:11.313339+02	2021-04-21 19:06:15.21475+02	2100	101	EFT	CONFIRMED
103	2021-04-21 19:09:39.143755+02	2021-04-21 19:09:47.013834+02	2970	102	EFT	CONFIRMED
104	2021-04-24 20:10:02.174274+02	2021-04-24 20:10:05.295608+02	10500	103	EFT	CONFIRMED
105	2021-04-25 20:59:52.847012+02	2021-04-27 19:47:14.650301+02	3850	105	EFT	CONFIRMED
106	2021-04-25 21:00:11.554971+02	2021-04-27 19:47:24.678676+02	6650	104	EFT	CONFIRMED
108	2021-05-13 21:40:36.674245+02	2021-05-13 21:40:44.475516+02	1000	81	EFT	CONFIRMED
107	2021-05-13 21:40:14.177639+02	2021-05-13 21:41:16.189781+02	2640	106	EFT	CONFIRMED
109	2021-06-02 21:57:52.520405+02	2021-06-02 21:57:58.903179+02	90	82	EFT	CONFIRMED
111	2021-06-02 22:02:06.100727+02	2021-06-02 22:02:11.498063+02	6510	111	EFT	CONFIRMED
110	2021-06-02 22:01:57.347548+02	2021-06-02 22:02:15.835376+02	90	111	EFT	CONFIRMED
112	2021-06-02 22:02:44.266491+02	2021-06-02 22:02:52.008379+02	90	62	EFT	CONFIRMED
113	2021-06-02 22:03:58.175501+02	2021-06-02 22:04:02.879616+02	3200	112	EFT	CONFIRMED
114	2021-06-02 22:11:33.449052+02	2021-06-02 22:11:38.252257+02	270	113	EFT	CONFIRMED
115	2021-06-12 21:49:00.99435+02	2021-06-12 21:49:05.611523+02	3200	112	EFT	CONFIRMED
116	2021-06-12 21:52:15.293291+02	2021-06-12 21:52:15.293314+02	9900	114	CASH	CONFIRMED
117	2021-06-21 21:50:23.119434+02	2021-06-21 21:50:27.378203+02	6864	115	EFT	CONFIRMED
118	2021-07-09 11:57:45.204624+02	2021-07-09 11:57:45.204653+02	0	116	CASH	CONFIRMED
119	2021-07-09 12:25:13.128696+02	2021-07-09 12:25:23.478337+02	0	117	EFT	CONFIRMED
120	2021-07-09 12:30:24.838143+02	2021-07-09 12:30:24.838171+02	0	118	CASH	CONFIRMED
121	2021-07-09 13:58:48.63228+02	2021-07-09 13:58:48.6323+02	6600	119	CASH	CONFIRMED
\.


--
-- Data for Name: sales_buyer; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.sales_buyer (id, created, modified, buyer_type, name, address, contact_person, mobile, email, status) FROM stdin;
1	2020-10-01 21:26:16.233933+02	2020-10-01 21:26:16.233962+02	CONTRACTOR	Walter	\N	Walter	0813278720	greenmindk@gmail.com	ACTIVE
2	2020-10-01 21:27:54.451725+02	2020-10-06 10:02:34.837864+02	SHOP	Jaco	\N	Jaco	0766501350	jweyers501@yahoo.com	ACTIVE
3	2020-10-09 18:15:19.512003+02	2020-10-09 18:15:19.512045+02	CONTRACTOR	Freddie	\N	Freddie	\N	\N	ACTIVE
4	2020-10-09 18:29:06.189595+02	2020-10-09 18:31:05.923298+02	SHOP	Village Paint and Hardware	Shop 7 , Edgemead Village Centre, Louis Thibault Dr, Edgemead, Cape Town, 7441	Jayne	0825741264	jayne@villageph.co.za	ACTIVE
5	2020-10-10 20:38:19.287425+02	2020-10-10 20:38:19.287465+02	CONTRACTOR	Newton	\N	Newton	\N	\N	ACTIVE
7	2020-12-08 19:06:18.804982+02	2020-12-10 14:10:42.806281+02	CONTRACTOR	Keith	\N	Keith	0825705296	keith@littlebonnet.co.za	ACTIVE
8	2021-01-11 16:29:10.612157+02	2021-01-11 16:29:10.612198+02	CONTRACTOR	Ying	\N	Ying	0769436850	\N	ACTIVE
9	2021-01-25 08:05:11.107562+02	2021-01-25 08:09:37.470524+02	CONTRACTOR	Josh	\N	Josh	0727403328	seemreal23@gmail.com	ACTIVE
6	2020-10-20 14:16:31.546917+02	2021-01-29 17:00:03.874249+02	CONTRACTOR	Dodo	\N	Dodo	0679032220	easiturf@gmail.com	ACTIVE
10	2021-02-01 19:08:40.882311+02	2021-02-01 19:08:40.88234+02	CONTRACTOR	Durandt	\N	Durandt	Geldenhuys	geldenhuysd12@telkomsa.net	ACTIVE
11	2021-04-07 19:25:20.514843+02	2021-04-07 19:25:20.514872+02	CONTRACTOR	Daniel Sengai	\N	Daniel	0733467057	daniel.sengai7@googlemail.com	ACTIVE
12	2021-07-09 12:05:39.745208+02	2021-07-09 12:05:39.745236+02	SHOP	Nays Cape Storm	\N	Nays	0828302935	\N	ACTIVE
\.


--
-- Data for Name: sales_buyerproduct; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.sales_buyerproduct (id, created, modified, price, buyer_id, product_id) FROM stdin;
1	2020-10-01 21:35:58.879903+02	2020-10-06 10:02:34.839143+02	165	2	8
2	2020-10-09 18:15:55.707358+02	2020-10-09 18:15:55.707398+02	150	3	8
5	2020-10-10 12:42:29.211651+02	2020-10-10 12:42:29.211688+02	165	1	1
6	2020-10-10 12:42:45.044543+02	2020-10-10 12:42:45.044583+02	175	1	6
7	2020-10-10 12:42:59.844724+02	2020-10-10 12:42:59.844764+02	165	1	8
8	2020-10-10 12:43:11.604238+02	2020-10-10 12:43:11.604279+02	175	1	7
12	2020-10-20 14:16:42.786299+02	2020-10-20 14:16:42.786341+02	175	6	7
13	2020-10-20 14:16:52.96964+02	2020-10-20 14:16:52.969708+02	165	6	1
14	2020-10-20 14:17:13.7314+02	2020-10-20 14:17:13.731438+02	175	6	6
15	2020-10-20 14:17:26.196645+02	2020-10-20 14:17:26.196685+02	165	6	8
16	2020-10-20 14:17:42.120495+02	2020-10-20 14:17:42.120536+02	4.5	6	12
17	2020-11-04 21:52:20.867348+02	2020-11-04 21:52:20.867388+02	4.5	4	12
19	2020-12-08 19:06:37.502592+02	2020-12-08 19:06:37.502633+02	165	7	8
20	2020-12-08 19:06:48.100191+02	2020-12-08 19:07:11.755909+02	175	7	6
22	2020-12-17 13:36:03.100865+02	2020-12-17 13:36:03.100901+02	165	7	1
21	2020-12-08 19:07:28.354836+02	2020-12-17 13:36:17.217328+02	175	7	7
23	2021-01-11 16:29:22.407593+02	2021-01-11 16:29:22.407633+02	1	8	1
24	2021-01-11 16:29:33.760555+02	2021-01-11 16:29:33.760592+02	1	8	8
25	2021-01-11 16:29:43.79556+02	2021-01-11 16:29:43.7956+02	1	8	6
26	2021-01-11 16:29:52.899642+02	2021-01-11 16:29:52.899683+02	1	8	7
27	2021-01-15 19:02:24.50048+02	2021-01-15 19:02:24.500519+02	165	1	13
28	2021-01-15 19:02:45.317746+02	2021-01-15 19:02:45.317785+02	165	1	14
9	2020-10-10 20:38:39.956181+02	2021-01-19 07:49:59.504091+02	175	5	6
11	2020-10-20 09:00:47.032675+02	2021-01-19 07:50:13.536951+02	175	5	7
18	2020-11-16 16:56:48.808853+02	2021-01-19 07:50:23.679559+02	165	5	1
29	2021-01-25 08:05:27.079758+02	2021-01-25 08:05:27.079788+02	165	9	1
30	2021-01-25 08:05:39.43701+02	2021-01-25 08:05:39.437039+02	175	9	6
31	2021-01-25 08:05:58.281256+02	2021-01-25 08:05:58.281285+02	175	9	7
32	2021-01-25 08:06:08.338941+02	2021-01-25 08:06:08.338969+02	165	9	8
33	2021-01-25 08:06:18.23959+02	2021-01-25 08:06:18.239612+02	165	9	13
34	2021-01-25 08:06:29.431472+02	2021-01-25 08:06:29.431498+02	165	9	14
35	2021-01-28 12:13:05.667396+02	2021-01-28 12:13:05.667424+02	165	6	13
36	2021-01-28 12:13:17.415412+02	2021-01-28 12:13:17.415441+02	165	6	14
3	2020-10-09 18:33:51.584954+02	2021-01-28 12:25:36.335641+02	165	4	1
4	2020-10-09 18:34:06.807379+02	2021-01-28 12:25:46.046804+02	175	4	6
37	2021-01-28 12:26:05.410368+02	2021-01-28 12:26:05.410395+02	165	4	13
38	2021-02-01 19:08:53.894446+02	2021-02-01 19:08:53.894475+02	165	10	1
39	2021-02-01 19:09:10.012878+02	2021-02-01 19:09:10.012902+02	4.5	10	12
40	2021-02-04 14:10:28.474773+02	2021-02-04 14:10:28.474798+02	4.5	9	12
41	2021-02-11 13:06:39.281167+02	2021-02-11 13:06:39.281196+02	200	1	15
43	2021-02-23 09:17:55.290403+02	2021-02-23 09:17:55.290432+02	165	5	14
44	2021-02-23 09:18:12.21982+02	2021-02-23 09:18:12.219849+02	165	5	13
45	2021-02-23 09:18:33.62053+02	2021-02-23 09:18:33.620559+02	165	5	8
46	2021-03-16 08:53:46.505742+02	2021-03-16 08:53:46.505771+02	120	1	16
47	2021-03-18 14:23:38.38792+02	2021-03-18 14:23:38.387945+02	165	7	14
42	2021-02-12 15:51:09.436601+02	2021-03-24 13:27:06.445439+02	66	7	12
10	2020-10-19 13:39:36.584884+02	2021-03-28 18:52:42.085397+02	50	1	12
48	2021-04-07 19:25:34.239275+02	2021-04-07 19:25:34.239302+02	175	11	6
49	2021-04-07 19:25:46.038776+02	2021-04-07 19:25:46.038802+02	175	11	7
50	2021-06-12 21:53:36.551339+02	2021-06-12 21:53:36.551368+02	165	7	13
51	2021-07-09 12:05:57.877222+02	2021-07-09 12:05:57.877249+02	165	12	1
52	2021-07-09 12:06:16.218118+02	2021-07-09 12:06:16.218145+02	175	12	6
53	2021-07-09 12:06:26.82497+02	2021-07-09 12:06:36.705588+02	165	12	13
54	2021-07-09 12:23:20.285144+02	2021-07-09 12:23:20.285173+02	1	8	13
\.


--
-- Data for Name: sales_order; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.sales_order (id, created, modified, status, buyer_id, number, closed_date) FROM stdin;
103	2021-03-29 12:37:50.04814+02	2021-03-31 09:56:10.395521+02	CLOSED	7	KEITH-ORD-202103291037	2021-03-31 09:56:10.395384+02
87	2021-02-28 21:58:26.681267+02	2021-02-28 21:59:04.467741+02	INVOICED	9	JOSH-ORD-202102281958	\N
18	2020-10-28 12:15:49.323631+02	2021-01-28 23:47:29.137136+02	CLOSED	6	DODO-ORD-2020102810	2020-10-28 12:15:49.323631+02
20	2020-11-02 15:55:49.245737+02	2021-01-28 23:47:29.144317+02	CLOSED	6	DODO-ORD-2020110213	2020-11-02 15:55:49.245737+02
122	2021-06-12 21:52:43.050204+02	2021-06-21 21:50:27.400745+02	CLOSED	7	KEITH-ORD-202106121952	2021-06-21 21:50:27.400628+02
89	2021-03-02 12:22:00.558564+02	2021-03-02 12:23:18.143492+02	CLOSED	1	WALTER-ORD-202103021022	2021-03-02 12:23:18.143392+02
21	2020-11-04 15:34:41.602611+02	2021-01-28 23:47:29.147821+02	CLOSED	1	WALTER-ORD-2020110413	2020-11-04 15:34:41.602611+02
105	2021-03-31 17:32:14.634582+02	2021-04-02 23:16:39.582985+02	CLOSED	5	NEWTON-ORD-202103311532	2021-04-02 23:16:39.58286+02
23	2020-11-16 16:56:00.267519+02	2021-01-28 23:47:29.15129+02	CLOSED	5	NEWTON-ORD-2020111614	2020-11-16 16:56:00.267519+02
24	2020-11-24 19:19:26.778873+02	2021-01-28 23:47:29.161036+02	CLOSED	1	WALTER-ORD-2020112417	2020-11-24 19:19:26.778873+02
25	2020-12-03 18:08:19.365207+02	2021-01-28 23:47:29.164609+02	CLOSED	6	DODO-ORD-2020120316	2020-12-03 18:08:19.365207+02
91	2021-03-04 22:29:02.035502+02	2021-03-06 03:18:07.731032+02	CLOSED	1	WALTER-ORD-202103042029	2021-03-06 03:18:07.730863+02
31	2020-12-03 19:06:45.885652+02	2021-01-28 23:47:29.168153+02	CLOSED	6	DODO-ORD-2020120317	2020-12-03 19:06:45.885652+02
22	2020-11-14 14:11:13.609117+02	2021-01-27 15:25:18.29926+02	INVOICED	4	VILLAGEPAINTANDHARDWARE-ORD-2020111412	\N
40	2021-01-08 09:03:01.53817+02	2021-01-28 23:47:29.196935+02	CLOSED	1	WALTER-ORD-2021010807	2021-01-08 09:03:01.53817+02
41	2021-01-11 16:31:36.339073+02	2021-01-28 23:47:29.200477+02	CLOSED	8	YING-ORD-2021011114	2021-01-11 16:31:36.339073+02
42	2021-01-13 13:45:33.209957+02	2021-01-28 23:47:29.20398+02	CLOSED	1	WALTER-ORD-202101131145	2021-01-13 13:45:33.209957+02
93	2021-03-08 21:54:56.970293+02	2021-03-12 09:23:32.562106+02	CLOSED	1	WALTER-ORD-202103081954	2021-03-12 09:23:32.561995+02
43	2021-01-13 13:47:13.414024+02	2021-01-28 23:47:29.207558+02	CLOSED	8	YING-ORD-202101131147	2021-01-13 13:47:13.414024+02
44	2021-01-13 13:49:07.389201+02	2021-01-28 23:47:29.211062+02	CLOSED	1	WALTER-ORD-202101131149	2021-01-13 13:49:07.389201+02
45	2021-01-15 18:51:37.112907+02	2021-01-28 23:47:29.214548+02	CLOSED	1	WALTER-ORD-202101151651	2021-01-15 18:51:37.112907+02
109	2021-04-21 19:06:33.365445+02	2021-04-21 19:09:47.036575+02	CLOSED	1	WALTER-ORD-202104211706	2021-04-21 19:09:47.036474+02
46	2021-01-19 07:46:31.323877+02	2021-01-28 23:47:29.218217+02	CLOSED	1	WALTER-ORD-202101190546	2021-01-19 07:46:31.323877+02
47	2021-01-19 07:49:13.909792+02	2021-01-28 23:47:29.221959+02	CLOSED	5	NEWTON-ORD-202101190549	2021-01-19 07:49:13.909792+02
95	2021-03-14 09:28:59.596323+02	2021-03-14 12:19:30.913423+02	CLOSED	1	WALTER-ORD-202103140728	2021-03-14 12:19:30.91332+02
48	2021-01-19 16:43:48.649344+02	2021-01-28 23:47:29.225596+02	CLOSED	1	WALTER-ORD-202101191443	2021-01-19 16:43:48.649344+02
49	2021-01-19 17:05:21.473062+02	2021-01-28 23:47:29.229333+02	CLOSED	8	YING-ORD-202101191505	2021-01-19 17:05:21.473062+02
50	2021-01-21 09:08:11.248217+02	2021-01-28 23:47:29.233062+02	CLOSED	1	WALTER-ORD-202101210708	2021-01-21 09:08:11.248217+02
52	2021-01-25 13:14:57.262025+02	2021-01-28 23:47:29.236637+02	CLOSED	1	WALTER-ORD-202101251114	2021-01-25 13:14:57.262025+02
53	2021-01-25 13:17:03.952889+02	2021-01-28 23:47:29.240075+02	CLOSED	1	WALTER-ORD-202101251117	2021-01-25 13:17:03.952889+02
54	2021-01-25 13:23:05.495147+02	2021-01-28 23:47:29.24368+02	CLOSED	1	WALTER-ORD-202101251123	2021-01-25 13:23:05.495147+02
55	2021-01-27 10:35:35.294951+02	2021-01-31 14:38:57.915746+02	CLOSED	1	WALTER-ORD-202101270835	2021-01-31 14:38:57.915624+02
51	2021-01-25 08:06:41.973244+02	2021-02-04 14:07:00.700447+02	CLOSED	9	JOSH-ORD-202101250606	2021-02-04 14:07:00.700333+02
124	2021-07-09 12:22:32.672673+02	2021-07-09 12:25:23.501962+02	CLOSED	8	YING-ORD-202107091022	2021-07-09 12:25:23.501801+02
111	2021-04-22 14:39:22.705381+02	2021-04-27 19:47:24.705402+02	CLOSED	1	WALTER-ORD-202104221239	2021-04-27 19:47:24.705238+02
97	2021-03-15 12:19:40.689965+02	2021-03-22 20:53:25.083494+02	CLOSED	1	WALTER-ORD-202103151019	2021-03-22 20:53:25.083377+02
99	2021-03-18 14:23:01.817837+02	2021-03-24 13:22:23.283116+02	CLOSED	7	KEITH-ORD-202103181223	2021-03-24 13:22:23.283018+02
101	2021-03-24 13:23:13.878248+02	2021-03-28 08:08:43.983312+02	CLOSED	7	KEITH-ORD-202103241123	2021-03-28 08:08:43.983146+02
1	2020-10-01 21:36:45.840469+02	2021-01-28 23:47:29.075652+02	CLOSED	2	JACO-ORD-2020100119	2020-10-01 21:36:45.840469+02
2	2020-10-09 18:16:18.990162+02	2021-01-28 23:47:29.083333+02	CLOSED	3	FREDDIE-ORD-2020100916	2020-10-09 18:16:18.990162+02
3	2020-10-09 18:30:38.301638+02	2021-01-28 23:47:29.087297+02	CLOSED	4	VILLAGEHARDWAREANDPAINT-ORD-2020100916	2020-10-09 18:30:38.301638+02
4	2020-10-10 12:41:59.945165+02	2021-01-28 23:47:29.091857+02	CLOSED	1	WALTER-ORD-2020101010	2020-10-10 12:41:59.945165+02
6	2020-10-12 09:11:04.980284+02	2021-01-28 23:47:29.095367+02	CLOSED	5	NEWTON-ORD-2020101207	2020-10-12 09:11:04.980284+02
7	2020-10-12 11:33:25.088928+02	2021-01-28 23:47:29.098598+02	CLOSED	1	WALTER-ORD-2020101209	2020-10-12 11:33:25.088928+02
8	2020-10-19 13:44:04.593486+02	2021-01-28 23:47:29.10177+02	CLOSED	1	WALTER-ORD-2020101911	2020-10-19 13:44:04.593486+02
9	2020-10-20 09:00:11.166445+02	2021-01-28 23:47:29.105043+02	CLOSED	5	NEWTON-ORD-2020102007	2020-10-20 09:00:11.166445+02
10	2020-10-20 11:03:56.275643+02	2021-01-28 23:47:29.108478+02	CLOSED	1	WALTER-ORD-2020102009	2020-10-20 11:03:56.275643+02
11	2020-10-20 14:17:58.893427+02	2021-01-28 23:47:29.111938+02	CLOSED	6	DODO-ORD-2020102012	2020-10-20 14:17:58.893427+02
12	2020-10-22 15:00:13.033101+02	2021-01-28 23:47:29.115502+02	CLOSED	6	DODO-ORD-2020102213	2020-10-22 15:00:13.033101+02
13	2020-10-22 15:01:08.312387+02	2021-01-28 23:47:29.119045+02	CLOSED	1	WALTER-ORD-2020102213	2020-10-22 15:01:08.312387+02
126	2021-07-09 13:56:32.971037+02	2021-07-09 13:58:48.653343+02	CLOSED	5	NEWTON-ORD-202107091156	2021-07-09 13:58:48.653187+02
128	2021-07-16 15:22:45.085292+02	2021-07-16 15:25:08.793103+02	INVOICED	1	WALTER-ORD-202107161322	\N
14	2020-10-23 08:41:21.796854+02	2021-01-28 23:47:29.122702+02	CLOSED	5	NEWTON-ORD-2020102306	2020-10-23 08:41:21.796854+02
15	2020-10-27 11:25:48.932212+02	2021-01-28 23:47:29.126266+02	CLOSED	1	WALTER-ORD-2020102709	2020-10-27 11:25:48.932212+02
16	2020-10-28 08:53:02.750532+02	2021-01-28 23:47:29.12993+02	CLOSED	5	NEWTON-ORD-2020102806	2020-10-28 08:53:02.750532+02
119	2021-06-02 22:03:05.962164+02	2021-06-12 21:49:05.635871+02	CLOSED	1	WALTER-ORD-202106022003	2021-06-12 21:49:05.63576+02
77	2021-02-19 17:33:39.262461+02	2021-02-27 06:28:10.831804+02	CLOSED	9	JOSH-ORD-202102191533	2021-02-27 06:28:10.831704+02
104	2021-03-31 17:30:11.725302+02	2021-03-31 17:31:05.412546+02	CLOSED	1	WALTER-ORD-202103311530	2021-03-31 17:31:05.412449+02
81	2021-02-23 09:16:46.401973+02	2021-03-31 17:31:55.477161+02	CLOSED	5	NEWTON-ORD-202102230716	2021-03-31 17:31:55.477045+02
79	2021-02-22 19:12:54.167101+02	2021-02-28 21:55:37.499843+02	CLOSED	9	JOSH-ORD-202102221712	2021-02-28 21:55:37.499741+02
58	2021-01-28 12:26:52.150689+02	2021-01-28 12:27:41.512398+02	INVOICED	4	VILLAGEPAINTANDHARDWARE-ORD-202101281026	\N
59	2021-01-28 12:28:04.287013+02	2021-01-28 12:28:57.926326+02	INVOICED	4	VILLAGEPAINTANDHARDWARE-ORD-202101281028	\N
17	2020-10-28 10:36:08.375598+02	2021-01-28 23:47:29.133546+02	CLOSED	1	WALTER-ORD-2020102808	2020-10-28 10:36:08.375598+02
19	2020-10-29 20:43:51.123008+02	2021-01-28 23:47:29.140712+02	CLOSED	1	WALTER-ORD-2020102918	2020-10-29 20:43:51.123008+02
33	2020-12-03 20:24:43.803109+02	2021-01-28 23:47:29.171808+02	CLOSED	6	DODO-ORD-2020120318	2020-12-03 20:24:43.803109+02
34	2020-12-09 10:21:53.539903+02	2021-01-28 23:47:29.175355+02	CLOSED	1	WALTER-ORD-2020120908	2020-12-09 10:21:53.539903+02
35	2020-12-10 14:11:01.321642+02	2021-01-28 23:47:29.178928+02	CLOSED	7	KEITH-ORD-2020121012	2020-12-10 14:11:01.321642+02
36	2020-12-17 13:35:15.147003+02	2021-01-28 23:47:29.182511+02	CLOSED	7	KEITH-ORD-2020121711	2020-12-17 13:35:15.147003+02
37	2021-01-04 13:55:02.663993+02	2021-01-28 23:47:29.186178+02	CLOSED	1	WALTER-ORD-2021010411	2021-01-04 13:55:02.663993+02
38	2021-01-04 13:55:50.729044+02	2021-01-28 23:47:29.189776+02	CLOSED	5	NEWTON-ORD-2021010411	2021-01-04 13:55:50.729044+02
39	2021-01-07 19:40:39.356111+02	2021-01-28 23:47:29.193352+02	CLOSED	5	NEWTON-ORD-2021010717	2021-01-07 19:40:39.356111+02
56	2021-01-28 12:12:37.658236+02	2021-01-30 12:02:47.272375+02	CLOSED	6	DODO-ORD-202101281012	2021-01-30 12:02:47.272248+02
118	2021-06-02 21:58:28.847171+02	2021-06-02 22:02:15.856781+02	CLOSED	9	JOSH-ORD-202106021958	2021-06-02 22:02:15.856645+02
86	2021-02-28 21:57:30.469324+02	2021-02-28 21:58:18.820684+02	CLOSED	9	JOSH-ORD-202102281957	2021-02-28 21:58:18.82057+02
57	2021-01-28 12:21:47.683932+02	2021-01-31 14:37:59.554283+02	CLOSED	1	WALTER-ORD-202101281021	2021-01-31 14:37:59.554137+02
60	2021-01-28 19:21:31.401404+02	2021-01-31 14:38:16.161053+02	CLOSED	1	WALTER-ORD-202101281721	2021-01-31 14:38:16.160934+02
72	2021-02-11 13:04:54.091327+02	2021-02-14 20:10:12.366793+02	CLOSED	1	WALTER-ORD-202102111104	2021-02-14 20:10:12.366642+02
75	2021-02-13 08:34:29.201446+02	2021-02-16 14:58:39.254456+02	CLOSED	1	WALTER-ORD-202102130634	2021-02-16 14:58:39.254328+02
74	2021-02-12 15:50:24.999007+02	2021-02-16 14:58:46.005594+02	CLOSED	7	KEITH-ORD-202102121350	2021-02-16 14:58:46.005436+02
68	2021-02-04 14:09:52.253547+02	2021-06-02 22:02:52.031376+02	CLOSED	9	JOSH-ORD-202102041209	2021-06-02 22:02:52.03118+02
84	2021-02-26 21:59:54.63409+02	2021-03-03 19:54:03.81034+02	CLOSED	1	WALTER-ORD-202102261959	2021-03-03 19:54:03.810216+02
65	2021-02-01 19:09:30.000688+02	2021-02-01 22:16:31.706219+02	CLOSED	10	DURANDT-ORD-202102011709	2021-02-01 22:16:31.706109+02
61	2021-01-30 12:03:05.937388+02	2021-02-01 22:16:47.067505+02	CLOSED	1	WALTER-ORD-202101301003	2021-02-01 22:16:47.067406+02
67	2021-02-03 09:07:07.869032+02	2021-02-05 12:21:24.013393+02	CLOSED	1	WALTER-ORD-202102030707	2021-02-05 12:21:24.01328+02
66	2021-02-02 13:56:48.060796+02	2021-02-05 12:21:45.453009+02	CLOSED	1	WALTER-ORD-202102021156	2021-02-05 12:21:45.45289+02
62	2021-02-01 09:08:41.591005+02	2021-02-05 12:21:52.580704+02	CLOSED	1	WALTER-ORD-202102010708	2021-02-05 12:21:52.580548+02
64	2021-02-01 13:53:14.839912+02	2021-02-05 12:21:58.266445+02	CLOSED	9	JOSH-ORD-202102011153	2021-02-05 12:21:58.266325+02
69	2021-02-04 20:06:27.375206+02	2021-02-08 11:31:28.312391+02	CLOSED	1	WALTER-ORD-202102041806	2021-02-08 11:31:28.312273+02
106	2021-04-07 19:19:02.499108+02	2021-04-21 19:05:49.020466+02	CLOSED	1	WALTER-ORD-202104071719	2021-04-21 19:05:49.0203+02
108	2021-04-07 19:25:55.453634+02	2021-04-21 19:06:15.238138+02	CLOSED	11	DANIELSENGAI-ORD-202104071725	2021-04-21 19:06:15.238042+02
90	2021-03-03 19:55:00.250484+02	2021-03-06 03:18:16.811508+02	CLOSED	1	WALTER-ORD-202103031755	2021-03-06 03:18:16.811398+02
120	2021-06-02 22:04:46.592206+02	2021-06-02 22:11:38.27469+02	CLOSED	1	WALTER-ORD-202106022004	2021-06-02 22:11:38.274591+02
76	2021-02-17 17:18:14.950889+02	2021-02-23 11:50:07.980439+02	CLOSED	1	WALTER-ORD-202102171518	2021-02-23 11:50:07.980331+02
78	2021-02-22 19:11:57.580392+02	2021-02-24 18:59:23.95203+02	CLOSED	1	WALTER-ORD-202102221711	2021-02-24 18:59:23.951927+02
82	2021-02-23 18:52:11.770675+02	2021-02-25 11:50:29.751035+02	CLOSED	1	WALTER-ORD-202102231652	2021-02-25 11:50:29.75092+02
94	2021-03-11 15:04:37.093189+02	2021-03-12 09:23:25.474399+02	CLOSED	1	WALTER-ORD-202103111304	2021-03-12 09:23:25.474295+02
92	2021-03-05 21:40:31.665659+02	2021-03-12 09:23:39.969161+02	CLOSED	1	WALTER-ORD-202103051940	2021-03-12 09:23:39.969066+02
83	2021-02-26 11:58:08.671797+02	2021-02-26 11:59:17.960549+02	CLOSED	8	YING-ORD-202102260958	2021-02-26 11:59:17.960443+02
110	2021-04-21 19:10:03.733255+02	2021-04-24 20:10:05.319432+02	CLOSED	1	WALTER-ORD-202104211710	2021-04-24 20:10:05.319335+02
121	2021-06-12 21:49:30.59818+02	2021-06-12 21:52:15.327916+02	CLOSED	1	WALTER-ORD-202106121949	2021-06-12 21:52:15.327751+02
112	2021-04-24 20:10:11.163204+02	2021-04-27 19:47:14.674489+02	CLOSED	1	WALTER-ORD-202104241810	2021-04-27 19:47:14.674378+02
100	2021-03-19 10:52:59.575856+02	2021-03-22 20:48:57.33237+02	CLOSED	1	WALTER-ORD-202103190852	2021-03-22 20:48:57.332212+02
98	2021-03-18 08:17:33.562322+02	2021-03-22 20:53:17.887922+02	CLOSED	1	WALTER-ORD-202103180617	2021-03-22 20:53:17.887821+02
102	2021-03-28 18:49:52.938025+02	2021-03-28 18:54:06.557369+02	CLOSED	1	WALTER-ORD-202103281649	2021-03-28 18:54:06.557233+02
113	2021-05-13 21:37:43.351812+02	2021-05-13 21:41:16.212221+02	CLOSED	1	WALTER-ORD-202105131937	2021-05-13 21:41:16.212117+02
123	2021-07-09 11:39:33.65571+02	2021-07-09 11:57:45.226893+02	CLOSED	8	YING-ORD-202107090939	2021-07-09 11:57:45.22679+02
88	2021-02-28 21:59:37.610433+02	2021-06-02 21:57:58.930914+02	CLOSED	9	JOSH-ORD-202102281959	2021-06-02 21:57:58.930706+02
125	2021-07-09 12:29:00.979777+02	2021-07-09 12:30:24.859695+02	CLOSED	8	YING-ORD-202107091029	2021-07-09 12:30:24.859584+02
127	2021-07-15 13:54:28.859424+02	2021-07-15 13:55:55.651902+02	INVOICED	1	WALTER-ORD-202107151154	\N
\.


--
-- Data for Name: sales_orderline; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.sales_orderline (id, created, modified, quantity, price, order_id, roll_id, product_id, total) FROM stdin;
73	2021-01-21 09:10:02.960458+02	2021-01-21 09:10:02.960483+02	1	175	50	139	6	175
2	2020-10-01 21:42:23.020961+02	2020-10-06 10:02:47.738931+02	90	165	1	28	8	14850
3	2020-10-06 10:07:21.886255+02	2020-10-06 10:07:21.886293+02	1	350	1	\N	\N	350
4	2020-10-09 18:16:50.72374+02	2020-10-09 18:16:50.723772+02	22	150	2	45	8	3300
5	2020-10-09 18:34:47.9826+02	2020-10-09 18:34:47.982626+02	50	160	3	31	1	8000
6	2020-10-09 18:34:47.99649+02	2020-10-09 18:34:47.996521+02	50	160	3	32	1	8000
8	2020-10-10 12:43:52.514084+02	2020-10-10 12:43:52.514112+02	40	165	4	33	1	6600
10	2020-10-12 09:11:18.181987+02	2020-10-12 09:11:18.182015+02	40	160	6	2	6	6400
11	2020-10-12 11:34:11.520692+02	2020-10-12 11:34:11.520731+02	36	165	7	34	1	5940
12	2020-10-19 13:40:33.545445+02	2020-10-19 13:40:33.54547+02	50	4.5	7	52	12	225
13	2020-10-19 13:44:29.476304+02	2020-10-19 13:44:29.476333+02	30	175	8	23	6	5250
14	2020-10-20 09:01:11.639782+02	2020-10-20 09:01:11.63981+02	12	160	9	26	7	1920
15	2020-10-20 11:04:17.629901+02	2020-10-20 11:04:17.629934+02	8	175	10	24	6	1400
16	2020-10-20 14:18:12.861899+02	2020-10-20 14:18:12.861931+02	70	175	11	25	7	12250
17	2020-10-22 15:00:29.381535+02	2020-10-22 15:00:29.381565+02	20	165	12	47	8	3300
18	2020-10-22 15:01:40.779856+02	2020-10-22 15:01:40.779884+02	8	175	13	2	6	1400
19	2020-10-22 15:01:40.790789+02	2020-10-22 15:01:40.79082+02	50	175	13	3	6	8750
20	2020-10-22 15:01:40.802605+02	2020-10-22 15:01:40.802637+02	90	175	13	4	7	15750
21	2020-10-22 15:01:40.814195+02	2020-10-22 15:01:40.814226+02	50	4.5	13	52	12	225
22	2020-10-23 08:41:32.116305+02	2020-10-23 08:41:32.116341+02	14	160	14	50	6	2240
23	2020-10-27 11:26:17.715096+02	2020-10-27 11:26:17.715134+02	10	175	15	4	7	1750
24	2020-10-27 11:26:17.724994+02	2020-10-27 11:26:17.725022+02	64	175	15	5	7	11200
25	2020-10-28 08:53:24.671619+02	2020-10-28 08:53:24.671646+02	30	160	16	50	6	4800
26	2020-10-28 10:36:37.595766+02	2020-10-28 10:36:37.595792+02	80	165	17	29	8	13200
27	2020-10-28 12:16:02.558519+02	2020-10-28 12:16:02.558559+02	22	175	18	5	7	3850
28	2020-10-29 20:44:15.811165+02	2020-10-29 20:44:15.811201+02	11	165	19	29	8	1815
29	2020-11-02 15:56:29.423634+02	2020-11-02 15:56:29.423671+02	32	165	20	46	1	5280
30	2020-11-02 15:56:49.389001+02	2020-11-02 15:56:49.389032+02	50	165	20	35	1	8250
31	2020-11-04 15:35:01.556884+02	2020-11-04 15:35:01.556918+02	16	165	21	30	8	2640
33	2020-11-14 14:11:31.703804+02	2020-11-14 14:11:31.703832+02	50	165	22	1	6	8250
35	2020-11-16 16:57:06.474453+02	2020-11-16 16:57:06.474486+02	14	160	23	34	1	2240
36	2020-11-24 19:20:52.173131+02	2020-11-24 19:20:52.173159+02	29	165	24	30	8	4785
37	2020-11-24 19:20:52.186505+02	2020-11-24 19:20:52.186542+02	16	175	24	5	7	2800
38	2020-11-24 19:20:52.195163+02	2020-11-24 19:20:52.19519+02	3	175	24	26	7	525
39	2020-12-03 18:09:33.965943+02	2020-12-03 18:09:33.96598+02	15	165	25	36	1	2475
40	2020-12-03 19:07:12.424759+02	2020-12-03 19:07:12.424791+02	20	165	31	36	1	3300
41	2020-12-03 20:25:15.092784+02	2020-12-03 20:25:15.092814+02	34	165	33	37	1	5610
42	2020-12-09 10:22:56.059493+02	2020-12-09 10:22:56.059526+02	10	165	34	33	1	1650
43	2020-12-09 10:22:56.077595+02	2020-12-09 10:22:56.077624+02	10	165	34	36	1	1650
44	2020-12-09 10:22:56.094504+02	2020-12-09 10:22:56.094533+02	16	165	34	37	1	2640
45	2020-12-09 10:22:56.102983+02	2020-12-09 10:22:56.103014+02	4	165	34	29	8	660
46	2020-12-10 14:11:11.732884+02	2020-12-10 14:11:11.732916+02	26	165	35	30	8	4290
47	2020-12-17 13:35:38.593816+02	2020-12-17 13:35:38.593851+02	10	165	36	28	8	1650
48	2020-12-17 13:35:38.605821+02	2020-12-17 13:35:38.605857+02	28	165	36	30	8	4620
49	2020-12-17 13:37:02.909034+02	2020-12-17 13:37:02.909065+02	26	165	36	38	1	4290
50	2021-01-04 13:55:15.591823+02	2021-01-04 13:55:15.591852+02	24	165	37	38	1	3960
51	2021-01-04 13:56:06.151112+02	2021-01-04 13:56:06.151142+02	50	160	38	39	1	8000
52	2021-01-04 13:56:06.16615+02	2021-01-04 13:56:06.166182+02	10	160	38	40	1	1600
53	2021-01-07 19:40:53.467296+02	2021-01-07 19:40:53.467334+02	32	160	39	40	1	5120
54	2021-01-08 09:03:34.681371+02	2021-01-08 09:03:34.681403+02	33	165	40	41	1	5445
55	2021-01-11 16:32:35.311373+02	2021-01-11 16:32:35.311401+02	5	1	41	29	8	5
56	2021-01-11 16:33:40.808908+02	2021-01-11 16:33:40.808939+02	2	1	41	2	6	2
57	2021-01-12 23:03:54.546813+02	2021-01-12 23:03:54.54684+02	1	1	41	30	8	1
58	2021-01-12 23:03:54.558019+02	2021-01-12 23:03:54.558049+02	4	1	41	26	7	4
59	2021-01-12 23:05:15.221679+02	2021-01-12 23:05:15.221717+02	1	12	41	\N	\N	12
60	2021-01-13 13:45:54.283512+02	2021-01-13 13:45:54.28356+02	8	165	42	40	1	1320
61	2021-01-13 13:45:54.295001+02	2021-01-13 13:45:54.295034+02	18	165	42	41	1	2970
62	2021-01-13 13:47:27.364852+02	2021-01-13 13:47:27.364879+02	5	1	43	36	1	5
63	2021-01-13 13:47:37.844464+02	2021-01-13 13:47:37.844504+02	1	5	43	\N	\N	5
64	2021-01-13 13:49:23.518213+02	2021-01-13 13:49:23.5183+02	50	4.5	44	52	12	225
65	2021-01-15 19:04:39.094768+02	2021-01-15 19:04:39.094796+02	9	175	45	89	6	1575
66	2021-01-15 19:04:39.11064+02	2021-01-15 19:04:39.110672+02	12	165	45	108	13	1980
67	2021-01-19 07:46:52.404042+02	2021-01-19 07:46:52.404072+02	32	175	46	89	6	5600
68	2021-01-19 07:52:01.752885+02	2021-01-19 07:52:01.752922+02	8	165	47	137	1	1320
69	2021-01-19 16:45:14.10736+02	2021-01-19 16:45:14.10739+02	23	175	48	90	6	4025
70	2021-01-19 16:45:14.130356+02	2021-01-19 16:45:14.130393+02	54	175	48	66	7	9450
71	2021-01-19 17:06:00.606285+02	2021-01-19 17:06:00.60631+02	1	1	49	137	1	1
72	2021-01-19 17:07:16.343153+02	2021-01-19 17:07:16.343193+02	1	1	49	\N	\N	1
74	2021-01-21 09:11:53.910146+02	2021-01-21 09:11:53.910181+02	27	175	50	90	6	4725
75	2021-01-21 09:11:53.922378+02	2021-01-21 09:11:53.922428+02	34	175	50	91	6	5950
76	2021-01-23 21:10:49.66564+02	2021-01-23 21:10:49.66568+02	1	1000	50	\N	\N	1000
78	2021-01-25 13:15:44.509412+02	2021-01-25 13:15:44.509435+02	22	165	52	74	14	3630
79	2021-01-25 13:21:03.889836+02	2021-01-25 13:21:03.889863+02	23	165	53	74	14	3795
80	2021-01-25 13:24:21.387183+02	2021-01-25 13:24:21.387202+02	52	175	54	67	7	9100
77	2021-01-25 08:07:10.867848+02	2021-01-25 15:44:43.665554+02	9	175	51	91	6	1575
81	2021-01-27 10:43:58.643454+02	2021-01-27 10:43:58.643478+02	3	175	55	89	6	525
82	2021-01-27 10:43:58.655641+02	2021-01-27 10:43:58.655665+02	37	175	55	66	7	6475
84	2021-01-28 12:22:22.714849+02	2021-01-28 12:22:22.714868+02	42	165	57	74	14	6930
85	2021-01-28 12:27:12.804903+02	2021-01-28 12:27:12.804926+02	50	165	58	129	1	8250
86	2021-01-28 12:28:46.016719+02	2021-01-28 12:28:46.016748+02	50	165	59	109	13	8250
87	2021-01-28 19:22:35.393531+02	2021-01-28 19:22:35.393563+02	10	165	60	137	1	1650
88	2021-01-30 12:03:30.032879+02	2021-01-30 12:03:30.032904+02	19	175	61	92	6	3325
89	2021-01-30 12:03:30.046278+02	2021-01-30 12:03:30.046298+02	19	165	61	108	13	3135
90	2021-02-01 09:09:53.210085+02	2021-02-01 09:09:53.210114+02	13	165	62	74	14	2145
91	2021-02-01 09:10:14.754751+02	2021-02-01 09:10:14.754771+02	1	165	62	141	14	165
92	2021-02-01 09:10:43.710083+02	2021-02-01 09:10:43.710103+02	40	165	62	78	14	6600
96	2021-02-01 13:53:31.200395+02	2021-02-01 13:53:31.200414+02	10	165	64	137	1	1650
97	2021-02-01 19:10:06.141514+02	2021-02-01 19:10:06.141535+02	50	165	65	43	1	8250
98	2021-02-01 19:10:06.157591+02	2021-02-01 19:10:06.157613+02	50	4.5	65	53	12	225
83	2021-01-28 12:13:52.236468+02	2021-02-01 22:10:13.059689+02	72	165	56	75	14	11880
99	2021-02-02 13:57:22.367385+02	2021-02-02 13:57:22.367408+02	29	165	66	78	14	4785
100	2021-02-03 09:07:32.831182+02	2021-02-03 09:07:32.831202+02	28	165	67	75	14	4620
101	2021-02-03 09:07:32.849744+02	2021-02-03 09:07:32.849767+02	24	165	67	78	14	3960
102	2021-02-03 09:08:42.51849+02	2021-02-03 09:08:42.518517+02	1	165	67	142	14	165
103	2021-02-04 14:10:55.971136+02	2021-02-04 14:10:55.971162+02	20	4.5	68	54	12	90
104	2021-02-04 20:06:51.849317+02	2021-02-04 20:06:51.849341+02	48	175	69	67	7	8400
105	2021-02-04 20:07:40.61863+02	2021-02-04 20:07:40.618649+02	1	175	69	143	7	175
108	2021-02-11 13:06:00.338227+02	2021-02-11 13:06:00.338248+02	20	175	72	92	6	3500
109	2021-02-11 13:06:59.907552+02	2021-02-11 13:06:59.907572+02	8	200	72	140	15	1600
110	2021-02-11 13:07:22.4521+02	2021-02-11 13:07:22.452121+02	7	165	72	78	14	1155
111	2021-02-11 13:08:12.965078+02	2021-02-11 13:08:12.965104+02	1	165	72	144	14	165
112	2021-02-11 13:08:34.95399+02	2021-02-11 13:08:34.954009+02	46	165	72	79	14	7590
115	2021-02-12 15:50:39.205848+02	2021-02-12 15:50:39.20592+02	73	175	74	68	7	12775
116	2021-02-12 15:51:30.687093+02	2021-02-12 15:51:30.687114+02	50	4.5	74	53	12	225
117	2021-02-12 15:51:58.625693+02	2021-02-12 15:51:58.625722+02	1	35	74	\N	\N	35
118	2021-02-13 08:34:59.829705+02	2021-02-13 08:34:59.829727+02	10	165	75	108	13	1650
119	2021-02-17 17:18:45.554262+02	2021-02-17 17:18:45.554286+02	50	175	76	93	6	8750
120	2021-02-19 17:33:57.306113+02	2021-02-19 17:33:57.306137+02	35	165	77	44	1	5775
121	2021-02-22 19:12:23.287476+02	2021-02-22 19:12:23.287498+02	1	175	78	89	6	175
122	2021-02-22 19:12:23.299158+02	2021-02-22 19:12:23.299182+02	46	175	78	94	6	8050
125	2021-02-23 09:20:14.572937+02	2021-02-23 09:20:14.572959+02	18	165	81	79	14	2970
126	2021-02-23 18:54:07.205396+02	2021-02-23 18:54:07.20542+02	36	165	82	79	14	5940
127	2021-02-23 18:54:07.219194+02	2021-02-23 18:54:07.219219+02	62	165	82	80	14	10230
128	2021-02-26 11:58:21.817188+02	2021-02-26 11:58:21.817213+02	2	1	83	47	8	2
129	2021-02-26 11:58:38.694857+02	2021-02-26 11:58:38.694887+02	1	2	83	\N	\N	2
130	2021-02-26 22:00:11.093927+02	2021-02-26 22:00:11.093949+02	56	175	84	69	7	9800
133	2021-02-28 21:54:28.884823+02	2021-02-28 21:54:28.884843+02	4	165	79	44	1	660
134	2021-02-28 21:57:51.289692+02	2021-02-28 21:57:51.289713+02	30	165	86	138	1	4950
135	2021-02-28 21:58:56.142666+02	2021-02-28 21:58:56.142687+02	50	165	87	42	1	8250
136	2021-02-28 21:59:53.683192+02	2021-02-28 21:59:53.683213+02	20	4.5	88	54	12	90
137	2021-03-02 12:22:21.979469+02	2021-03-02 12:22:21.979488+02	20	165	89	110	13	3300
138	2021-03-02 12:22:21.993235+02	2021-03-02 12:22:21.993257+02	50	165	89	111	13	8250
139	2021-03-03 19:55:53.139818+02	2021-03-03 19:55:53.139838+02	14	175	90	95	6	2450
140	2021-03-03 19:55:53.154301+02	2021-03-03 19:55:53.154324+02	52	175	90	70	7	9100
141	2021-03-03 19:55:53.167223+02	2021-03-03 19:55:53.167247+02	38	165	90	80	14	6270
142	2021-03-03 19:55:53.175981+02	2021-03-03 19:55:53.176+02	15	165	90	81	14	2475
143	2021-03-03 19:55:53.188124+02	2021-03-03 19:55:53.188147+02	2	165	90	145	14	330
144	2021-03-04 22:29:24.423129+02	2021-03-04 22:29:24.423151+02	56	165	91	81	14	9240
145	2021-03-05 21:41:21.770145+02	2021-03-05 21:41:21.770175+02	100	165	92	58	8	16500
146	2021-03-05 21:41:21.782007+02	2021-03-05 21:41:21.782032+02	48	165	92	59	8	7920
147	2021-03-05 21:41:21.795326+02	2021-03-05 21:41:21.795352+02	46	175	92	70	7	8050
148	2021-03-08 21:55:10.287093+02	2021-03-08 21:55:10.287113+02	20	165	93	48	1	3300
149	2021-03-11 15:05:01.531429+02	2021-03-11 15:05:01.531452+02	40	165	94	59	8	6600
150	2021-03-14 09:29:31.209291+02	2021-03-14 09:29:31.209316+02	20	165	95	128	13	3300
154	2021-03-15 12:20:11.135386+02	2021-03-15 12:20:11.135416+02	11	175	97	92	6	1925
155	2021-03-15 12:20:11.145879+02	2021-03-15 12:20:11.145897+02	6	165	97	108	13	990
156	2021-03-15 12:20:11.154301+02	2021-03-15 12:20:11.154322+02	30	165	97	110	13	4950
157	2021-03-16 08:54:31.13373+02	2021-03-16 08:54:31.133759+02	1	120	97	146	16	120
158	2021-03-16 08:54:31.165608+02	2021-03-16 08:54:31.165635+02	1	120	97	147	16	120
159	2021-03-16 08:54:31.178904+02	2021-03-16 08:54:31.178925+02	1	120	97	148	16	120
160	2021-03-16 08:54:31.191956+02	2021-03-16 08:54:31.191978+02	1	120	97	149	16	120
161	2021-03-18 08:18:11.309282+02	2021-03-18 08:18:11.309307+02	19	175	98	95	6	3325
162	2021-03-18 08:18:11.321953+02	2021-03-18 08:18:11.321979+02	20	175	98	69	7	3500
163	2021-03-18 14:23:58.693771+02	2021-03-18 14:23:58.693798+02	40	165	99	82	14	6600
164	2021-03-19 10:53:36.806014+02	2021-03-19 10:53:36.806037+02	100	165	100	60	8	16500
165	2021-03-19 10:53:36.822566+02	2021-03-19 10:53:36.822592+02	70	165	100	77	8	11550
166	2021-03-24 13:25:46.40983+02	2021-03-24 13:25:46.409855+02	36	165	101	82	14	5940
167	2021-03-24 13:28:05.114729+02	2021-03-24 13:28:05.114756+02	1	66	101	53	12	66
168	2021-03-25 21:50:56.742897+02	2021-03-25 21:50:56.742925+02	1	6	101	\N	\N	6
169	2021-03-28 18:50:12.818723+02	2021-03-28 18:50:12.818751+02	40	200	102	140	15	8000
170	2021-03-28 18:50:51.488816+02	2021-03-28 18:50:51.488839+02	1	120	102	150	16	120
171	2021-03-28 18:50:51.504458+02	2021-03-28 18:50:51.504475+02	1	120	102	151	16	120
172	2021-03-28 18:50:51.51594+02	2021-03-28 18:50:51.515961+02	1	120	102	152	16	120
173	2021-03-28 18:50:51.528927+02	2021-03-28 18:50:51.52895+02	1	120	102	153	16	120
174	2021-03-28 18:53:34.449956+02	2021-03-28 18:53:34.449985+02	6	50	102	53	12	300
175	2021-03-29 12:38:04.620265+02	2021-03-29 12:38:04.620287+02	16	165	103	81	14	2640
176	2021-03-31 17:30:43.084221+02	2021-03-31 17:30:43.084241+02	78	175	104	71	7	13650
177	2021-03-31 17:32:35.419937+02	2021-03-31 17:32:35.41996+02	50	165	105	114	13	8250
178	2021-04-07 19:19:25.955846+02	2021-04-07 19:19:25.955868+02	10	165	106	81	14	1650
179	2021-04-07 19:26:14.360633+02	2021-04-07 19:26:14.360655+02	12	175	108	68	7	2100
180	2021-04-21 19:08:58.049818+02	2021-04-21 19:08:58.049841+02	18	165	109	82	14	2970
181	2021-04-21 19:10:22.209336+02	2021-04-21 19:10:22.209358+02	60	175	110	72	7	10500
182	2021-04-22 14:40:10.876006+02	2021-04-22 14:40:10.876033+02	15	175	111	68	7	2625
183	2021-04-22 14:40:10.887014+02	2021-04-22 14:40:10.887036+02	22	175	111	71	7	3850
184	2021-04-22 14:41:08.500051+02	2021-04-22 14:41:08.500079+02	1	175	111	218	7	175
185	2021-04-24 20:10:43.444649+02	2021-04-24 20:10:43.444673+02	22	175	112	96	6	3850
186	2021-05-13 21:38:09.000886+02	2021-05-13 21:38:09.000918+02	16	165	113	83	14	2640
191	2021-06-02 22:01:13.287286+02	2021-06-02 22:01:13.287309+02	2	165	118	44	1	330
192	2021-06-02 22:01:13.303259+02	2021-06-02 22:01:13.303294+02	8	165	118	59	8	1320
193	2021-06-02 22:01:13.311886+02	2021-06-02 22:01:13.311906+02	30	165	118	77	8	4950
194	2021-06-02 22:03:37.188044+02	2021-06-02 22:03:37.188066+02	32	200	119	140	15	6400
195	2021-06-02 22:05:32.502131+02	2021-06-02 22:05:32.502157+02	1	120	120	154	16	120
197	2021-06-02 22:10:45.748386+02	2021-06-02 22:10:45.748408+02	3	50	120	53	12	150
198	2021-06-12 21:50:17.775819+02	2021-06-12 21:50:17.775844+02	50	165	121	115	13	8250
199	2021-06-12 21:50:17.793682+02	2021-06-12 21:50:17.793707+02	10	165	121	116	13	1650
200	2021-06-12 21:54:41.558047+02	2021-06-12 21:54:41.558074+02	42	165	122	117	13	6930
201	2021-06-12 21:55:01.044673+02	2021-06-12 21:55:01.044701+02	1	66	122	\N	\N	66
202	2021-07-09 11:42:49.29847+02	2021-07-09 11:42:49.298498+02	1	1	123	45	8	1
203	2021-07-09 11:57:21.301522+02	2021-07-09 11:57:21.301552+02	1	1	123	\N	\N	1
204	2021-07-09 12:22:57.452721+02	2021-07-09 12:22:57.452746+02	1	1	124	137	1	1
205	2021-07-09 12:23:39.252138+02	2021-07-09 12:23:39.252157+02	3	1	124	108	13	3
206	2021-07-09 12:24:46.00856+02	2021-07-09 12:24:46.008588+02	1	4	124	\N	\N	4
207	2021-07-09 12:29:17.737342+02	2021-07-09 12:29:17.737359+02	2	1	125	70	7	2
208	2021-07-09 12:29:51.32214+02	2021-07-09 12:29:51.322166+02	1	2	125	\N	\N	2
209	2021-07-09 13:57:59.824071+02	2021-07-09 13:57:59.824099+02	40	165	126	118	13	6600
210	2021-07-15 13:55:43.181281+02	2021-07-15 13:55:43.181307+02	24	175	127	69	7	4200
211	2021-07-16 15:24:25.815893+02	2021-07-16 15:24:25.815919+02	32	175	128	97	6	5600
\.


--
-- Data for Name: stock_batch; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_batch (id, created, modified, number) FROM stdin;
1	2020-10-04 01:57:11.360469+02	2020-10-04 01:57:11.360508+02	BATCH-20201001
2	2021-01-12 14:09:02.889425+02	2021-01-12 14:09:02.889458+02	BATCH-20210112
\.


--
-- Data for Name: stock_category; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_category (id, created, modified, name) FROM stdin;
1	2020-09-08 12:37:40.303+02	2020-09-08 12:37:40.303+02	Grass
2	2020-10-14 23:48:15.583624+02	2020-10-14 23:48:15.583664+02	Join Tape
3	2021-03-15 23:07:56.616728+02	2021-03-15 23:07:56.616758+02	Golf Cup
4	2021-03-28 21:10:04.462785+02	2021-03-28 21:10:04.462808+02	Flag
\.


--
-- Data for Name: stock_color; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_color (id, created, modified, name) FROM stdin;
1	2020-09-08 12:38:26.287+02	2020-09-08 12:40:47.592+02	Autumn
2	2020-09-08 12:44:11.355+02	2020-09-08 12:44:11.355+02	Spring
3	2020-10-16 01:40:12.970399+02	2020-10-16 01:40:12.970438+02	Black
4	2021-01-31 23:45:58.101957+02	2021-01-31 23:45:58.101985+02	Golf
5	2021-03-15 23:56:39.64859+02	2021-03-15 23:56:39.648619+02	White
6	2021-03-28 21:10:20.394544+02	2021-03-28 21:10:20.394569+02	Yellow
7	2021-03-28 21:10:23.987483+02	2021-03-28 21:10:23.987512+02	Red
8	2021-03-28 21:10:29.532445+02	2021-03-28 21:10:29.532471+02	Blue
\.


--
-- Data for Name: stock_height; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_height (id, created, modified, value) FROM stdin;
1	2020-09-08 12:37:56.072+02	2020-09-08 12:37:56.072+02	30
2	2020-09-08 12:44:00.478+02	2020-09-08 12:44:00.478+02	25
3	2020-10-14 23:49:24.358202+02	2020-10-14 23:49:24.358245+02	0
4	2021-01-31 23:46:23.076014+02	2021-01-31 23:46:23.076042+02	15
5	2021-03-15 23:56:55.436852+02	2021-03-15 23:56:55.436882+02	1
\.


--
-- Data for Name: stock_product; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_product (id, created, modified, code, spec_id) FROM stdin;
11	2020-10-16 01:41:05.892891+02	2020-10-16 01:41:05.89292+02	JT-100	9
12	2020-10-16 01:41:13.265879+02	2020-10-16 01:41:13.265907+02	JT-300	10
1	2020-09-08 12:39:09.621+02	2021-01-16 14:12:25.176336+02	25A-2	4
6	2020-09-09 18:04:51.29+02	2021-01-16 14:12:25.186435+02	30A-2	1
7	2020-09-10 17:07:25.503+02	2021-01-16 14:12:25.194322+02	30A-4	5
8	2020-09-10 17:07:47.184+02	2021-01-16 14:12:25.202689+02	25A-4	6
13	2021-01-15 19:00:27.391476+02	2021-01-16 14:12:25.215449+02	30S-2	3
14	2021-01-15 19:00:35.998515+02	2021-01-16 14:12:25.223821+02	30S-4	8
15	2021-01-31 23:46:55.00934+02	2021-01-31 23:46:55.009364+02	15G-4	11
16	2021-03-15 23:57:23.830265+02	2021-03-15 23:57:23.830287+02	Golf Cup	13
17	2021-03-28 21:12:34.613266+02	2021-03-28 21:12:34.613288+02	Flag - White	14
18	2021-03-28 21:12:41.841474+02	2021-03-28 21:12:41.841497+02	Flag - Yellow	15
19	2021-03-28 21:12:51.317352+02	2021-03-28 21:12:51.317374+02	Flag - Red	16
20	2021-03-28 21:12:57.821442+02	2021-03-28 21:12:57.821479+02	Flag - Blue	17
\.


--
-- Data for Name: stock_rollspec; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_rollspec (id, created, modified, length, category_id, color_id, height_id, width_id) FROM stdin;
1	2020-09-09 17:57:00.456+02	2020-09-09 17:57:00.456+02	25	1	1	1	1
2	2020-09-09 18:12:06.365+02	2020-09-09 18:12:06.365+02	25	1	2	2	1
3	2020-09-09 18:12:39.665+02	2020-09-09 18:12:39.665+02	25	1	2	1	1
4	2020-09-09 18:13:27.929+02	2020-09-09 18:13:27.929+02	25	1	1	2	1
5	2020-09-10 17:07:21.279+02	2020-09-10 17:07:21.279+02	25	1	1	1	2
6	2020-09-10 17:07:45.88+02	2020-09-10 17:07:45.88+02	25	1	1	2	2
7	2020-09-10 17:08:44.28+02	2020-09-10 17:08:44.28+02	25	1	2	2	2
8	2020-09-10 17:09:14.732+02	2020-09-10 17:09:14.732+02	25	1	2	1	2
9	2020-10-16 01:40:40.258601+02	2020-10-16 01:40:40.258627+02	100	2	3	3	3
10	2020-10-16 01:40:53.264281+02	2020-10-16 01:40:53.264308+02	300	2	3	3	3
11	2021-01-31 23:46:39.876673+02	2021-01-31 23:46:39.876691+02	25	1	4	4	2
13	2021-03-15 23:57:08.23697+02	2021-03-15 23:57:08.23699+02	1	3	5	5	5
14	2021-03-28 21:11:02.774825+02	2021-03-28 21:11:02.774853+02	1	4	5	5	5
15	2021-03-28 21:11:27.86661+02	2021-03-28 21:11:27.86663+02	1	4	6	5	5
16	2021-03-28 21:11:43.466022+02	2021-03-28 21:11:43.466045+02	1	4	7	5	5
17	2021-03-28 21:12:01.67874+02	2021-03-28 21:12:01.678759+02	1	4	8	5	5
\.


--
-- Data for Name: stock_turfroll; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_turfroll (id, created, modified, status, spec_id, location_id, total, sold, original_size, batch_id, note) FROM stdin;
147	2021-03-15 23:58:04.443537+02	2021-03-22 20:53:25.119804+02	DEPLETED	13	\N	0	1	1	1	\N
148	2021-03-15 23:58:04.447+02	2021-03-22 20:53:25.126113+02	DEPLETED	13	\N	0	1	1	1	\N
73	2021-01-12 23:11:52.813447+02	2021-01-14 23:40:48.249707+02	SEALED	5	5	100	0	100	2	\N
48	2020-10-09 18:29:36.232649+02	2021-03-12 09:23:32.570053+02	OPENED	4	6	30	20	50	1	
58	2021-01-12 23:10:51.452512+02	2021-03-12 09:23:39.976612+02	DEPLETED	6	\N	0	100	100	2	\N
76	2021-01-12 23:13:43.949601+02	2021-01-14 23:40:48.26051+02	SEALED	6	4	100	0	100	2	\N
77	2021-01-12 23:13:43.955526+02	2021-06-02 22:02:15.885603+02	DEPLETED	6	\N	0	100	100	2	\N
97	2021-01-12 23:15:08.838887+02	2021-07-16 15:24:25.82221+02	OPENED	1	1	50	0	50	2	
84	2021-01-12 23:14:03.269042+02	2021-01-14 23:40:48.289371+02	SEALED	8	4	100	0	100	2	\N
85	2021-01-12 23:14:03.272558+02	2021-01-14 23:40:48.293116+02	SEALED	8	4	100	0	100	2	\N
86	2021-01-12 23:14:26.001197+02	2021-01-14 23:40:48.30384+02	SEALED	5	4	100	0	100	2	\N
87	2021-01-12 23:14:26.006411+02	2021-01-14 23:40:48.307732+02	SEALED	5	4	100	0	100	2	\N
88	2021-01-12 23:14:26.009566+02	2021-01-14 23:40:48.311448+02	SEALED	5	4	100	0	100	2	\N
61	2021-01-12 23:10:51.468706+02	2021-01-14 23:40:48.345001+02	SEALED	6	5	100	0	100	2	\N
62	2021-01-12 23:10:51.472125+02	2021-01-14 23:40:48.348961+02	SEALED	6	5	100	0	100	2	\N
63	2021-01-12 23:10:51.475599+02	2021-01-14 23:40:48.352779+02	SEALED	6	5	100	0	100	2	\N
64	2021-01-12 23:10:51.479242+02	2021-01-14 23:40:48.356613+02	SEALED	6	5	100	0	100	2	\N
65	2021-01-12 23:10:51.482764+02	2021-01-14 23:40:48.360478+02	SEALED	6	5	100	0	100	2	\N
155	2021-03-15 23:58:04.471178+02	2021-03-15 23:58:04.471202+02	SEALED	13	4	1	0	1	1	\N
156	2021-03-15 23:58:04.474577+02	2021-03-15 23:58:04.474601+02	SEALED	13	4	1	0	1	1	\N
157	2021-03-15 23:58:04.478024+02	2021-03-15 23:58:04.478048+02	SEALED	13	4	1	0	1	1	\N
158	2021-03-15 23:58:04.481227+02	2021-03-15 23:58:04.481251+02	SEALED	13	4	1	0	1	1	\N
102	2021-01-12 23:15:08.856175+02	2021-01-14 23:40:48.401845+02	SEALED	1	6	50	0	50	2	\N
159	2021-03-15 23:58:04.484604+02	2021-03-15 23:58:04.484628+02	SEALED	13	4	1	0	1	1	\N
103	2021-01-12 23:15:08.859489+02	2021-01-14 23:40:48.40551+02	SEALED	1	6	50	0	50	2	\N
160	2021-03-15 23:58:04.487871+02	2021-03-15 23:58:04.487895+02	SEALED	13	4	1	0	1	1	\N
161	2021-03-15 23:58:04.491065+02	2021-03-15 23:58:04.491088+02	SEALED	13	4	1	0	1	1	\N
162	2021-03-15 23:58:04.494316+02	2021-03-15 23:58:04.49434+02	SEALED	13	4	1	0	1	1	\N
163	2021-03-15 23:58:04.49774+02	2021-03-15 23:58:04.497765+02	SEALED	13	4	1	0	1	1	\N
164	2021-03-15 23:58:04.501126+02	2021-03-15 23:58:04.501149+02	SEALED	13	4	1	0	1	1	\N
165	2021-03-15 23:58:04.504611+02	2021-03-15 23:58:04.504636+02	SEALED	13	4	1	0	1	1	\N
166	2021-03-15 23:58:04.508035+02	2021-03-15 23:58:04.508058+02	SEALED	13	4	1	0	1	1	\N
78	2021-01-12 23:14:03.245495+02	2021-02-14 20:10:12.397572+02	DEPLETED	8	\N	0	100	100	2	\N
167	2021-03-15 23:58:04.511504+02	2021-03-15 23:58:04.511528+02	SEALED	13	4	1	0	1	1	\N
149	2021-03-15 23:58:04.450512+02	2021-03-22 20:53:25.132689+02	DEPLETED	13	\N	0	1	1	1	\N
71	2021-01-12 23:11:52.806451+02	2021-04-27 19:47:24.721925+02	DEPLETED	5	\N	0	100	100	2	\N
68	2021-01-12 23:11:52.796276+02	2021-04-27 19:47:24.715162+02	DEPLETED	5	\N	0	100	100	2	\N
82	2021-01-12 23:14:03.261881+02	2021-04-21 19:09:47.044909+02	OPENED	8	4	6	94	100	2	\N
54	2020-10-19 13:39:13.197365+02	2021-06-02 22:02:52.041829+02	OPENED	10	1	260	40	300	1	\N
151	2021-03-15 23:58:04.457554+02	2021-03-28 18:54:06.582333+02	DEPLETED	13	\N	0	1	1	1	\N
80	2021-01-12 23:14:03.25486+02	2021-03-06 03:18:16.838406+02	DEPLETED	8	\N	0	100	100	2	\N
79	2021-01-12 23:14:03.251584+02	2021-03-31 17:31:55.485887+02	DEPLETED	8	\N	0	100	100	2	\N
95	2021-01-12 23:15:08.831907+02	2021-03-22 20:53:17.896405+02	OPENED	1	1	17	33	50	2	
60	2021-01-12 23:10:51.465203+02	2021-03-22 20:48:57.347696+02	DEPLETED	6	\N	0	100	100	2	\N
69	2021-01-12 23:11:52.799617+02	2021-03-22 20:53:17.90315+02	OPENED	5	5	24	76	100	2	\N
92	2021-01-12 23:15:08.821071+02	2021-03-22 20:53:25.092589+02	DEPLETED	1	\N	0	50	50	2	
42	2020-10-01 21:02:32.881195+02	2021-02-01 13:52:45.055869+02	OPENED	4	1	50	0	50	1	\N
146	2021-03-15 23:58:04.437078+02	2021-03-22 20:53:25.113213+02	DEPLETED	13	\N	0	1	1	1	\N
93	2021-01-12 23:15:08.824625+02	2021-02-23 11:50:07.995771+02	DEPLETED	1	\N	0	50	50	2	\N
43	2020-10-01 21:02:32.884458+02	2021-02-01 22:16:31.71461+02	DEPLETED	4	\N	0	50	50	1	\N
94	2021-01-12 23:15:08.828231+02	2021-03-08 21:48:44.486699+02	OPENED	1	1	4	46	50	2	
1	2020-10-01 20:48:43.594636+02	2020-10-09 18:34:48.01253+02	OPENED	1	1	50	0	50	1	\N
44	2020-10-01 21:02:32.88773+02	2021-06-02 22:02:15.865297+02	OPENED	4	1	9	41	50	1	\N
75	2021-01-12 23:12:42.674124+02	2021-02-05 12:21:24.022362+02	DEPLETED	8	\N	0	100	100	2	
152	2021-03-15 23:58:04.461143+02	2021-03-28 18:54:06.589414+02	DEPLETED	13	\N	0	1	1	1	\N
153	2021-03-15 23:58:04.464519+02	2021-03-28 18:54:06.595562+02	DEPLETED	13	\N	0	1	1	1	\N
81	2021-01-12 23:14:03.258287+02	2021-04-21 19:05:49.030444+02	OPENED	8	4	3	97	100	2	\N
51	2020-10-19 13:37:33.179618+02	2020-10-19 13:37:33.179645+02	SEALED	9	1	100	0	100	1	\N
70	2021-01-12 23:11:52.803054+02	2021-07-09 12:30:24.868223+02	DEPLETED	5	\N	0	100	100	2	\N
55	2020-10-19 13:39:13.200706+02	2020-10-19 13:39:13.20073+02	SEALED	10	1	300	0	300	1	\N
56	2020-10-19 13:39:13.204081+02	2020-10-19 13:39:13.204111+02	SEALED	10	1	300	0	300	1	\N
57	2020-10-19 13:39:13.207362+02	2020-10-19 13:39:13.207392+02	SEALED	10	1	300	0	300	1	\N
74	2021-01-12 23:12:42.662544+02	2021-02-05 12:21:52.589496+02	DEPLETED	8	\N	0	100	100	2	\N
67	2021-01-12 23:11:52.792952+02	2021-02-08 11:31:28.321352+02	DEPLETED	5	\N	0	100	100	2	\N
150	2021-03-15 23:58:04.454102+02	2021-03-28 18:54:06.573121+02	DEPLETED	13	\N	0	1	1	1	\N
49	2020-10-09 18:29:36.23895+02	2021-05-18 21:10:55.165118+02	OPENED	4	6	50	0	50	1	
72	2021-01-12 23:11:52.809973+02	2021-04-24 20:10:05.328262+02	OPENED	5	5	40	60	100	2	\N
98	2021-01-12 23:15:08.842438+02	2021-03-08 21:50:01.17743+02	SEALED	1	1	50	0	50	2	
99	2021-01-12 23:15:08.845974+02	2021-03-08 21:50:14.688558+02	SEALED	1	1	50	0	50	2	
59	2021-01-12 23:10:51.46161+02	2021-06-02 22:02:15.878814+02	OPENED	6	5	4	96	100	2	\N
96	2021-01-12 23:15:08.835401+02	2021-04-27 19:47:14.683291+02	OPENED	1	1	28	22	50	2	
83	2021-01-12 23:14:03.265321+02	2021-05-13 21:41:16.220821+02	OPENED	8	4	84	16	100	2	\N
53	2020-10-19 13:39:13.194066+02	2021-06-02 22:11:38.294369+02	OPENED	10	1	190	110	300	1	\N
154	2021-03-15 23:58:04.467888+02	2021-06-02 22:11:38.282322+02	DEPLETED	13	\N	0	1	1	1	\N
100	2021-01-12 23:15:08.849385+02	2021-03-08 21:50:38.147516+02	SEALED	1	1	50	0	50	2	
101	2021-01-12 23:15:08.852904+02	2021-03-08 21:50:55.311713+02	SEALED	1	1	50	0	50	2	
129	2021-01-12 23:17:31.441225+02	2021-01-28 12:27:12.810812+02	OPENED	4	1	50	0	50	2	
109	2021-01-12 23:15:34.628242+02	2021-01-28 12:28:46.023052+02	OPENED	3	6	50	0	50	2	\N
90	2021-01-12 23:15:08.813639+02	2021-01-28 21:54:17.132685+02	DEPLETED	1	\N	0	50	50	2	
108	2021-01-12 23:15:34.62274+02	2021-07-09 12:25:23.524514+02	DEPLETED	3	\N	0	50	50	2	damaged
112	2021-01-12 23:16:49.036358+02	2021-03-08 21:53:03.226489+02	SEALED	3	6	50	0	50	2	
47	2020-10-01 21:23:42.759309+02	2021-02-26 11:59:17.968072+02	DEPLETED	6	\N	0	22	22	1	
31	2020-10-01 21:02:32.842763+02	2021-01-28 22:02:16.278127+02	DEPLETED	4	\N	0	50	50	1	
32	2020-10-01 21:02:32.84876+02	2021-01-28 22:03:15.437406+02	DEPLETED	4	\N	0	50	50	1	
113	2021-01-12 23:16:49.039929+02	2021-03-08 21:53:17.235211+02	SEALED	3	6	50	0	50	2	
138	2021-01-12 23:18:09.92153+02	2021-02-28 21:58:18.82893+02	DEPLETED	4	\N	0	30	30	2	\N
136	2021-01-12 23:17:31.465655+02	2021-03-08 21:53:52.09108+02	SEALED	4	6	50	0	50	2	
35	2020-10-01 21:02:32.858441+02	2021-01-28 22:41:55.9239+02	DEPLETED	4	\N	0	50	50	1	
2	2020-10-01 20:48:43.609449+02	2021-01-28 22:05:27.061833+02	DEPLETED	1	\N	0	50	50	1	
41	2020-10-01 21:02:32.877723+02	2021-01-28 22:50:45.689905+02	DEPLETED	4	\N	0	51	51	1	
128	2021-01-12 23:16:49.091483+02	2021-03-14 12:19:30.922234+02	OPENED	3	6	30	20	50	2	
110	2021-01-12 23:15:34.631754+02	2021-03-22 20:53:25.106473+02	DEPLETED	3	\N	0	50	50	2	
34	2020-10-01 21:02:32.85522+02	2021-01-28 22:06:31.265958+02	DEPLETED	4	\N	0	50	50	1	
168	2021-03-15 23:58:04.514841+02	2021-03-15 23:58:04.514866+02	SEALED	13	4	1	0	1	1	\N
139	2021-01-21 09:09:17.956028+02	2021-01-28 23:05:06.326372+02	DEPLETED	1	\N	0	1	1	\N	
169	2021-03-15 23:58:04.518483+02	2021-03-15 23:58:04.518507+02	SEALED	13	4	1	0	1	1	\N
170	2021-03-15 23:58:04.521789+02	2021-03-15 23:58:04.521813+02	SEALED	13	4	1	0	1	1	\N
23	2020-10-01 20:53:09.85016+02	2021-01-28 22:09:05.50029+02	DEPLETED	1	\N	0	30	30	1	
111	2021-01-12 23:16:49.031717+02	2021-03-02 12:23:18.157032+02	DEPLETED	3	\N	0	50	50	2	\N
104	2021-01-12 23:15:08.862841+02	2021-01-14 23:40:48.409242+02	SEALED	1	6	50	0	50	2	\N
105	2021-01-12 23:15:08.86844+02	2021-01-14 23:40:48.413136+02	SEALED	1	6	50	0	50	2	\N
106	2021-01-12 23:15:08.871824+02	2021-01-14 23:40:48.416628+02	SEALED	1	6	50	0	50	2	\N
107	2021-01-12 23:15:08.875271+02	2021-01-14 23:40:48.420256+02	SEALED	1	6	50	0	50	2	\N
171	2021-03-15 23:58:04.525453+02	2021-03-15 23:58:04.525483+02	SEALED	13	4	1	0	1	1	\N
119	2021-01-12 23:16:49.060595+02	2021-01-14 23:40:48.487806+02	SEALED	3	1	50	0	50	2	\N
120	2021-01-12 23:16:49.064067+02	2021-01-14 23:40:48.491626+02	SEALED	3	1	50	0	50	2	\N
121	2021-01-12 23:16:49.067485+02	2021-01-14 23:40:48.495652+02	SEALED	3	1	50	0	50	2	\N
122	2021-01-12 23:16:49.070991+02	2021-01-14 23:40:48.499258+02	SEALED	3	1	50	0	50	2	\N
123	2021-01-12 23:16:49.074533+02	2021-01-14 23:40:48.5026+02	SEALED	3	1	50	0	50	2	\N
124	2021-01-12 23:16:49.077856+02	2021-01-14 23:40:48.513251+02	SEALED	3	1	50	0	50	2	\N
125	2021-01-12 23:16:49.081109+02	2021-01-14 23:40:48.524912+02	SEALED	3	1	50	0	50	2	\N
126	2021-01-12 23:16:49.084474+02	2021-01-14 23:40:48.528938+02	SEALED	3	1	50	0	50	2	\N
127	2021-01-12 23:16:49.087915+02	2021-01-14 23:40:48.532774+02	SEALED	3	1	50	0	50	2	\N
132	2021-01-12 23:17:31.452879+02	2021-01-14 23:40:48.54049+02	SEALED	4	1	50	0	50	2	
133	2021-01-12 23:17:31.456119+02	2021-01-14 23:40:48.544326+02	SEALED	4	1	50	0	50	2	
134	2021-01-12 23:17:31.459381+02	2021-01-14 23:40:48.548079+02	SEALED	4	1	50	0	50	2	
172	2021-03-15 23:58:04.529279+02	2021-03-15 23:58:04.529309+02	SEALED	13	4	1	0	1	1	\N
131	2021-01-12 23:17:31.449891+02	2021-01-14 23:40:48.574122+02	SEALED	4	1	50	0	50	2	
135	2021-01-12 23:17:31.462617+02	2021-01-14 23:40:48.577774+02	SEALED	4	1	50	0	50	2	
52	2020-10-19 13:39:13.187749+02	2021-01-27 23:39:01.67396+02	DEPLETED	10	\N	0	300	300	1	\N
91	2021-01-12 23:15:08.817442+02	2021-03-08 21:48:55.567701+02	OPENED	1	1	7	43	50	2	
173	2021-03-15 23:58:04.532565+02	2021-03-15 23:58:04.532586+02	SEALED	13	4	1	0	1	1	\N
26	2020-10-01 20:56:24.154132+02	2021-01-28 22:10:06.338105+02	DEPLETED	5	\N	0	19	19	1	
174	2021-03-15 23:58:04.535566+02	2021-03-15 23:58:04.535587+02	SEALED	13	4	1	0	1	1	\N
89	2021-01-12 23:15:08.807397+02	2021-03-08 21:49:12.104257+02	OPENED	1	1	4	45	49	2	
24	2020-10-01 20:53:36.392532+02	2021-01-28 22:15:47.907447+02	DEPLETED	1	\N	0	8	8	1	
175	2021-03-15 23:58:04.538615+02	2021-03-15 23:58:04.538636+02	SEALED	13	4	1	0	1	1	\N
25	2020-10-01 20:54:57.52235+02	2021-01-28 22:29:13.923472+02	DEPLETED	5	\N	0	70	70	1	
176	2021-03-15 23:58:04.541484+02	2021-03-15 23:58:04.541514+02	SEALED	13	4	1	0	1	1	\N
177	2021-03-15 23:58:04.544118+02	2021-03-15 23:58:04.544133+02	SEALED	13	4	1	0	1	1	\N
3	2020-10-01 20:48:43.620226+02	2021-01-28 22:33:32.068849+02	DEPLETED	1	\N	0	50	50	1	
4	2020-10-01 20:49:12.810282+02	2021-01-28 22:34:13.617957+02	DEPLETED	5	\N	0	100	100	1	
5	2020-10-01 20:49:12.815739+02	2021-01-28 22:35:10.184076+02	DEPLETED	5	\N	0	102	102	1	
50	2020-10-09 18:30:14.908424+02	2021-01-28 22:36:34.536064+02	OPENED	1	1	6	44	50	1	
46	2020-10-01 21:20:32.82986+02	2021-01-28 22:41:17.665852+02	DEPLETED	4	\N	0	32	32	1	
178	2021-03-15 23:58:04.546781+02	2021-03-15 23:58:04.546796+02	SEALED	13	4	1	0	1	1	\N
179	2021-03-15 23:58:04.549335+02	2021-03-15 23:58:04.549349+02	SEALED	13	4	1	0	1	1	\N
180	2021-03-15 23:58:04.551958+02	2021-03-15 23:58:04.551973+02	SEALED	13	4	1	0	1	1	\N
66	2021-01-12 23:11:52.786576+02	2021-01-31 14:38:57.931869+02	OPENED	5	5	9	91	100	2	
181	2021-03-15 23:58:04.554785+02	2021-03-15 23:58:04.554801+02	SEALED	13	4	1	0	1	1	\N
130	2021-01-12 23:17:31.446693+02	2021-02-09 09:19:53.583438+02	OPENED	4	1	50	0	50	2	
114	2021-01-12 23:16:49.043359+02	2021-04-02 23:16:39.598876+02	DEPLETED	3	\N	0	50	50	2	\N
117	2021-01-12 23:16:49.053798+02	2021-06-21 21:50:27.409242+02	OPENED	3	1	8	42	50	2	\N
115	2021-01-12 23:16:49.046757+02	2021-06-12 21:52:15.338335+02	DEPLETED	3	\N	0	50	50	2	\N
116	2021-01-12 23:16:49.050299+02	2021-06-12 21:52:15.346543+02	OPENED	3	1	40	10	50	2	\N
45	2020-10-01 21:19:43.564406+02	2021-07-09 11:57:45.235042+02	LOOSE	6	6	12	23	35	1	
137	2021-01-12 23:18:09.915981+02	2021-07-09 12:25:23.510858+02	DEPLETED	4	\N	0	30	30	2	
118	2021-01-12 23:16:49.057095+02	2021-07-09 13:59:33.677072+02	OPENED	3	1	10	40	50	2	kept by Walter
182	2021-03-16 06:41:31.212832+02	2021-03-16 06:41:31.212854+02	SEALED	13	1	1	0	1	2	\N
183	2021-03-16 06:41:31.218969+02	2021-03-16 06:41:31.21899+02	SEALED	13	1	1	0	1	2	\N
184	2021-03-16 06:41:31.222242+02	2021-03-16 06:41:31.222262+02	SEALED	13	1	1	0	1	2	\N
185	2021-03-16 06:41:31.225659+02	2021-03-16 06:41:31.225682+02	SEALED	13	1	1	0	1	2	\N
186	2021-03-16 06:41:31.229099+02	2021-03-16 06:41:31.229122+02	SEALED	13	1	1	0	1	2	\N
187	2021-03-16 06:41:31.232249+02	2021-03-16 06:41:31.23227+02	SEALED	13	1	1	0	1	2	\N
28	2020-10-01 21:01:39.409892+02	2021-01-28 21:53:28.519719+02	DEPLETED	6	\N	0	100	100	1	
33	2020-10-01 21:02:32.852072+02	2021-01-28 22:04:05.594027+02	DEPLETED	4	\N	0	50	50	1	
29	2020-10-01 21:01:39.415556+02	2021-01-28 22:40:31.412437+02	DEPLETED	6	\N	0	100	100	1	
30	2020-10-01 21:01:39.419227+02	2021-01-28 22:43:24.870463+02	DEPLETED	6	\N	0	100	100	1	
36	2020-10-01 21:02:32.86166+02	2021-01-28 22:45:39.32013+02	DEPLETED	4	\N	0	50	50	1	
37	2020-10-01 21:02:32.864962+02	2021-01-28 22:47:11.676812+02	DEPLETED	4	\N	0	50	50	1	
38	2020-10-01 21:02:32.868253+02	2021-01-28 22:48:05.178067+02	DEPLETED	4	\N	0	50	50	1	
39	2020-10-01 21:02:32.871409+02	2021-01-28 22:49:03.860371+02	DEPLETED	4	\N	0	50	50	1	
40	2020-10-01 21:02:32.874563+02	2021-01-28 22:49:38.678955+02	DEPLETED	4	\N	0	50	50	1	
188	2021-03-16 06:41:31.235799+02	2021-03-16 06:41:31.235824+02	SEALED	13	1	1	0	1	2	\N
189	2021-03-16 06:41:31.239149+02	2021-03-16 06:41:31.239173+02	SEALED	13	1	1	0	1	2	\N
190	2021-03-16 06:41:31.24257+02	2021-03-16 06:41:31.242594+02	SEALED	13	1	1	0	1	2	\N
142	2021-02-03 09:08:04.42337+02	2021-02-05 12:21:24.035667+02	DEPLETED	8	\N	0	1	1	\N	\N
141	2021-02-01 09:09:19.164162+02	2021-02-05 12:21:52.596186+02	DEPLETED	8	\N	0	1	1	\N	\N
143	2021-02-04 20:07:13.673917+02	2021-02-08 11:31:28.328533+02	DEPLETED	5	\N	0	1	1	\N	\N
191	2021-03-16 06:41:31.246094+02	2021-03-16 06:41:31.246118+02	SEALED	13	1	1	0	1	2	\N
192	2021-03-16 06:41:31.249513+02	2021-03-16 06:41:31.249538+02	SEALED	13	1	1	0	1	2	\N
144	2021-02-11 13:07:42.414967+02	2021-02-14 20:10:12.404652+02	DEPLETED	8	\N	0	1	1	\N	\N
193	2021-03-16 06:41:31.252908+02	2021-03-16 06:41:31.252932+02	SEALED	13	1	1	0	1	2	\N
145	2021-03-03 19:54:48.600916+02	2021-03-06 03:18:16.858945+02	DEPLETED	8	\N	0	2	2	\N	\N
194	2021-03-16 06:41:31.256222+02	2021-03-16 06:41:31.256247+02	SEALED	13	1	1	0	1	2	\N
195	2021-03-16 06:41:31.259505+02	2021-03-16 06:41:31.259529+02	SEALED	13	1	1	0	1	2	\N
196	2021-03-16 06:41:31.262957+02	2021-03-16 06:41:31.262981+02	SEALED	13	1	1	0	1	2	\N
197	2021-03-16 06:41:31.266371+02	2021-03-16 06:41:31.266395+02	SEALED	13	1	1	0	1	2	\N
198	2021-03-16 06:41:31.269696+02	2021-03-16 06:41:31.269721+02	SEALED	13	1	1	0	1	2	\N
199	2021-03-16 06:41:31.273135+02	2021-03-16 06:41:31.273158+02	SEALED	13	1	1	0	1	2	\N
200	2021-03-16 06:41:31.276504+02	2021-03-16 06:41:31.27653+02	SEALED	13	1	1	0	1	2	\N
201	2021-03-16 06:41:31.27964+02	2021-03-16 06:41:31.279663+02	SEALED	13	1	1	0	1	2	\N
202	2021-03-16 06:41:31.282705+02	2021-03-16 06:41:31.282727+02	SEALED	13	1	1	0	1	2	\N
203	2021-03-16 06:41:31.286144+02	2021-03-16 06:41:31.286168+02	SEALED	13	1	1	0	1	2	\N
204	2021-03-16 06:41:31.289562+02	2021-03-16 06:41:31.289587+02	SEALED	13	1	1	0	1	2	\N
205	2021-03-16 06:41:31.293097+02	2021-03-16 06:41:31.293122+02	SEALED	13	1	1	0	1	2	\N
206	2021-03-16 06:41:31.296515+02	2021-03-16 06:41:31.296539+02	SEALED	13	1	1	0	1	2	\N
207	2021-03-16 06:41:31.299803+02	2021-03-16 06:41:31.299826+02	SEALED	13	1	1	0	1	2	\N
208	2021-03-16 06:41:31.303083+02	2021-03-16 06:41:31.303107+02	SEALED	13	1	1	0	1	2	\N
209	2021-03-16 06:41:31.306331+02	2021-03-16 06:41:31.306355+02	SEALED	13	1	1	0	1	2	\N
210	2021-03-16 06:41:31.309746+02	2021-03-16 06:41:31.309771+02	SEALED	13	1	1	0	1	2	\N
211	2021-03-16 06:41:31.313083+02	2021-03-16 06:41:31.313107+02	SEALED	13	1	1	0	1	2	\N
212	2021-03-16 06:41:31.316224+02	2021-03-16 06:41:31.316247+02	SEALED	13	1	1	0	1	2	\N
213	2021-03-16 06:41:31.326359+02	2021-03-16 06:41:31.326385+02	SEALED	13	1	1	0	1	2	\N
214	2021-03-16 06:41:31.329647+02	2021-03-16 06:41:31.329671+02	SEALED	13	1	1	0	1	2	\N
215	2021-03-16 06:41:31.332763+02	2021-03-16 06:41:31.332785+02	SEALED	13	1	1	0	1	2	\N
216	2021-03-16 06:41:31.336112+02	2021-03-16 06:41:31.336136+02	SEALED	13	1	1	0	1	2	\N
217	2021-03-16 06:41:31.339506+02	2021-03-16 06:41:31.33953+02	SEALED	13	1	1	0	1	2	\N
218	2021-04-22 14:40:39.212215+02	2021-04-27 19:47:24.727711+02	DEPLETED	5	\N	0	1	1	\N	\N
140	2021-01-31 23:47:32.131269+02	2021-06-12 21:49:05.644779+02	OPENED	11	4	20	80	100	2	\N
\.


--
-- Data for Name: stock_warehouse; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_warehouse (id, created, modified, name, number, address) FROM stdin;
4	2021-01-12 14:04:49.621572+02	2021-01-12 14:04:49.621614+02	Alternative Storage	7003	Bellville, Cape Town
5	2021-01-12 14:05:13.154195+02	2021-01-12 14:05:13.154247+02	Alternative Storage	7004	Bellville, Cape Town
6	2021-01-12 14:05:22.427659+02	2021-01-12 14:05:22.427702+02	Alternative Storage	6004	Bellville, Cape Town
1	2020-09-09 17:54:00.53+02	2021-01-12 14:06:50.857955+02	Alternative Storage	5015	Bellville, Cape Town
\.


--
-- Data for Name: stock_width; Type: TABLE DATA; Schema: public; Owner: turf-portal-user
--

COPY public.stock_width (id, created, modified, value) FROM stdin;
1	2020-09-08 12:38:07.884+02	2020-09-08 12:38:07.884+02	2
2	2020-09-08 12:41:28.646+02	2020-09-08 12:41:28.646+02	4
3	2020-10-16 01:39:52.476174+02	2020-10-16 01:39:52.4762+02	0.3
4	2021-03-15 23:09:23.240333+02	2021-03-15 23:09:23.24036+02	0
5	2021-03-15 23:57:02.35736+02	2021-03-15 23:57:02.35739+02	1
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 88, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 127, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 22, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 80, true);


--
-- Name: expense_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.expense_expense_id_seq', 9, true);


--
-- Name: invoice_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.invoice_invoice_id_seq', 153, true);


--
-- Name: invoice_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.invoice_payment_id_seq', 121, true);


--
-- Name: sales_buyer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.sales_buyer_id_seq', 12, true);


--
-- Name: sales_buyerproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.sales_buyerproduct_id_seq', 54, true);


--
-- Name: sales_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.sales_order_id_seq', 160, true);


--
-- Name: sales_orderline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.sales_orderline_id_seq', 243, true);


--
-- Name: stock_batch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_batch_id_seq', 2, true);


--
-- Name: stock_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_category_id_seq', 4, true);


--
-- Name: stock_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_color_id_seq', 8, true);


--
-- Name: stock_height_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_height_id_seq', 5, true);


--
-- Name: stock_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_product_id_seq', 20, true);


--
-- Name: stock_rollspec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_rollspec_id_seq', 17, true);


--
-- Name: stock_turfroll_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_turfroll_id_seq', 218, true);


--
-- Name: stock_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_warehouse_id_seq', 6, true);


--
-- Name: stock_width_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turf-portal-user
--

SELECT pg_catalog.setval('public.stock_width_id_seq', 5, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: expense_expense expense_expense_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.expense_expense
    ADD CONSTRAINT expense_expense_pkey PRIMARY KEY (id);


--
-- Name: invoice_invoice invoice_invoice_number_c8f63b12_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_invoice
    ADD CONSTRAINT invoice_invoice_number_c8f63b12_uniq UNIQUE (number);


--
-- Name: invoice_invoice invoice_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_invoice
    ADD CONSTRAINT invoice_invoice_pkey PRIMARY KEY (id);


--
-- Name: invoice_payment invoice_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_payment
    ADD CONSTRAINT invoice_payment_pkey PRIMARY KEY (id);


--
-- Name: sales_buyer sales_buyer_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyer
    ADD CONSTRAINT sales_buyer_pkey PRIMARY KEY (id);


--
-- Name: sales_buyerproduct sales_buyerproduct_buyer_id_product_id_6fccf0e3_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyerproduct
    ADD CONSTRAINT sales_buyerproduct_buyer_id_product_id_6fccf0e3_uniq UNIQUE (buyer_id, product_id);


--
-- Name: sales_buyerproduct sales_buyerproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyerproduct
    ADD CONSTRAINT sales_buyerproduct_pkey PRIMARY KEY (id);


--
-- Name: sales_order sales_order_number_48f6507b_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_number_48f6507b_uniq UNIQUE (number);


--
-- Name: sales_order sales_order_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_pkey PRIMARY KEY (id);


--
-- Name: sales_orderline sales_orderline_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_orderline
    ADD CONSTRAINT sales_orderline_pkey PRIMARY KEY (id);


--
-- Name: stock_batch stock_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_batch
    ADD CONSTRAINT stock_batch_pkey PRIMARY KEY (id);


--
-- Name: stock_category stock_category_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_category
    ADD CONSTRAINT stock_category_pkey PRIMARY KEY (id);


--
-- Name: stock_color stock_color_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_color
    ADD CONSTRAINT stock_color_pkey PRIMARY KEY (id);


--
-- Name: stock_height stock_height_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_height
    ADD CONSTRAINT stock_height_pkey PRIMARY KEY (id);


--
-- Name: stock_product stock_product_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_product
    ADD CONSTRAINT stock_product_pkey PRIMARY KEY (id);


--
-- Name: stock_rollspec stock_rollspec_category_id_color_id_hei_bdaf7f75_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec
    ADD CONSTRAINT stock_rollspec_category_id_color_id_hei_bdaf7f75_uniq UNIQUE (category_id, color_id, height_id, width_id, length);


--
-- Name: stock_rollspec stock_rollspec_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec
    ADD CONSTRAINT stock_rollspec_pkey PRIMARY KEY (id);


--
-- Name: stock_turfroll stock_turfroll_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_turfroll
    ADD CONSTRAINT stock_turfroll_pkey PRIMARY KEY (id);


--
-- Name: stock_warehouse stock_warehouse_name_number_fdeeefde_uniq; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_warehouse
    ADD CONSTRAINT stock_warehouse_name_number_fdeeefde_uniq UNIQUE (name, number);


--
-- Name: stock_warehouse stock_warehouse_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_warehouse
    ADD CONSTRAINT stock_warehouse_pkey PRIMARY KEY (id);


--
-- Name: stock_width stock_width_pkey; Type: CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_width
    ADD CONSTRAINT stock_width_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: invoice_invoice_buyer_id_71944041; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX invoice_invoice_buyer_id_71944041 ON public.invoice_invoice USING btree (buyer_id);


--
-- Name: invoice_invoice_number_c8f63b12_like; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX invoice_invoice_number_c8f63b12_like ON public.invoice_invoice USING btree (number varchar_pattern_ops);


--
-- Name: invoice_invoice_order_id_c5fc9ae9; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX invoice_invoice_order_id_c5fc9ae9 ON public.invoice_invoice USING btree (order_id);


--
-- Name: invoice_payment_invoice_id_77396bd3; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX invoice_payment_invoice_id_77396bd3 ON public.invoice_payment USING btree (invoice_id);


--
-- Name: sales_buyerproduct_buyer_id_01ab37de; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_buyerproduct_buyer_id_01ab37de ON public.sales_buyerproduct USING btree (buyer_id);


--
-- Name: sales_buyerproduct_product_id_0e0d3018; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_buyerproduct_product_id_0e0d3018 ON public.sales_buyerproduct USING btree (product_id);


--
-- Name: sales_order_buyer_id_91e0004a; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_order_buyer_id_91e0004a ON public.sales_order USING btree (buyer_id);


--
-- Name: sales_order_number_48f6507b_like; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_order_number_48f6507b_like ON public.sales_order USING btree (number varchar_pattern_ops);


--
-- Name: sales_orderline_order_id_9f597de6; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_orderline_order_id_9f597de6 ON public.sales_orderline USING btree (order_id);


--
-- Name: sales_orderline_product_id_42dc18a2; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_orderline_product_id_42dc18a2 ON public.sales_orderline USING btree (product_id);


--
-- Name: sales_orderline_roll_id_890781c1; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX sales_orderline_roll_id_890781c1 ON public.sales_orderline USING btree (roll_id);


--
-- Name: stock_product_spec_id_31d3ff8b; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_product_spec_id_31d3ff8b ON public.stock_product USING btree (spec_id);


--
-- Name: stock_rollspec_category_id_54b31399; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_rollspec_category_id_54b31399 ON public.stock_rollspec USING btree (category_id);


--
-- Name: stock_rollspec_color_id_3b372fd6; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_rollspec_color_id_3b372fd6 ON public.stock_rollspec USING btree (color_id);


--
-- Name: stock_rollspec_height_id_5ac7ea7b; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_rollspec_height_id_5ac7ea7b ON public.stock_rollspec USING btree (height_id);


--
-- Name: stock_rollspec_width_id_69c6016a; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_rollspec_width_id_69c6016a ON public.stock_rollspec USING btree (width_id);


--
-- Name: stock_turfroll_batch_id_2f570055; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_turfroll_batch_id_2f570055 ON public.stock_turfroll USING btree (batch_id);


--
-- Name: stock_turfroll_location_id_6e128a70; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_turfroll_location_id_6e128a70 ON public.stock_turfroll USING btree (location_id);


--
-- Name: stock_turfroll_spec_id_9952d245; Type: INDEX; Schema: public; Owner: turf-portal-user
--

CREATE INDEX stock_turfroll_spec_id_9952d245 ON public.stock_turfroll USING btree (spec_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoice_invoice invoice_invoice_buyer_id_71944041_fk_sales_buyer_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_invoice
    ADD CONSTRAINT invoice_invoice_buyer_id_71944041_fk_sales_buyer_id FOREIGN KEY (buyer_id) REFERENCES public.sales_buyer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoice_invoice invoice_invoice_order_id_c5fc9ae9_fk_sales_order_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_invoice
    ADD CONSTRAINT invoice_invoice_order_id_c5fc9ae9_fk_sales_order_id FOREIGN KEY (order_id) REFERENCES public.sales_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoice_payment invoice_payment_invoice_id_77396bd3_fk_invoice_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.invoice_payment
    ADD CONSTRAINT invoice_payment_invoice_id_77396bd3_fk_invoice_invoice_id FOREIGN KEY (invoice_id) REFERENCES public.invoice_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_buyerproduct sales_buyerproduct_buyer_id_01ab37de_fk_sales_buyer_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyerproduct
    ADD CONSTRAINT sales_buyerproduct_buyer_id_01ab37de_fk_sales_buyer_id FOREIGN KEY (buyer_id) REFERENCES public.sales_buyer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_buyerproduct sales_buyerproduct_product_id_0e0d3018_fk_stock_product_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_buyerproduct
    ADD CONSTRAINT sales_buyerproduct_product_id_0e0d3018_fk_stock_product_id FOREIGN KEY (product_id) REFERENCES public.stock_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_order sales_order_buyer_id_91e0004a_fk_sales_buyer_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_order
    ADD CONSTRAINT sales_order_buyer_id_91e0004a_fk_sales_buyer_id FOREIGN KEY (buyer_id) REFERENCES public.sales_buyer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_orderline sales_orderline_order_id_9f597de6_fk_sales_order_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_orderline
    ADD CONSTRAINT sales_orderline_order_id_9f597de6_fk_sales_order_id FOREIGN KEY (order_id) REFERENCES public.sales_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_orderline sales_orderline_product_id_42dc18a2_fk_stock_product_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_orderline
    ADD CONSTRAINT sales_orderline_product_id_42dc18a2_fk_stock_product_id FOREIGN KEY (product_id) REFERENCES public.stock_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_orderline sales_orderline_roll_id_890781c1_fk_stock_turfroll_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.sales_orderline
    ADD CONSTRAINT sales_orderline_roll_id_890781c1_fk_stock_turfroll_id FOREIGN KEY (roll_id) REFERENCES public.stock_turfroll(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_product stock_product_spec_id_31d3ff8b_fk_stock_rollspec_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_product
    ADD CONSTRAINT stock_product_spec_id_31d3ff8b_fk_stock_rollspec_id FOREIGN KEY (spec_id) REFERENCES public.stock_rollspec(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_rollspec stock_rollspec_category_id_54b31399_fk_stock_category_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec
    ADD CONSTRAINT stock_rollspec_category_id_54b31399_fk_stock_category_id FOREIGN KEY (category_id) REFERENCES public.stock_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_rollspec stock_rollspec_color_id_3b372fd6_fk_stock_color_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec
    ADD CONSTRAINT stock_rollspec_color_id_3b372fd6_fk_stock_color_id FOREIGN KEY (color_id) REFERENCES public.stock_color(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_rollspec stock_rollspec_height_id_5ac7ea7b_fk_stock_height_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec
    ADD CONSTRAINT stock_rollspec_height_id_5ac7ea7b_fk_stock_height_id FOREIGN KEY (height_id) REFERENCES public.stock_height(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_rollspec stock_rollspec_width_id_69c6016a_fk_stock_width_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_rollspec
    ADD CONSTRAINT stock_rollspec_width_id_69c6016a_fk_stock_width_id FOREIGN KEY (width_id) REFERENCES public.stock_width(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_turfroll stock_turfroll_batch_id_2f570055_fk_stock_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_turfroll
    ADD CONSTRAINT stock_turfroll_batch_id_2f570055_fk_stock_batch_id FOREIGN KEY (batch_id) REFERENCES public.stock_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_turfroll stock_turfroll_location_id_6e128a70_fk_stock_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_turfroll
    ADD CONSTRAINT stock_turfroll_location_id_6e128a70_fk_stock_warehouse_id FOREIGN KEY (location_id) REFERENCES public.stock_warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_turfroll stock_turfroll_spec_id_9952d245_fk_stock_rollspec_id; Type: FK CONSTRAINT; Schema: public; Owner: turf-portal-user
--

ALTER TABLE ONLY public.stock_turfroll
    ADD CONSTRAINT stock_turfroll_spec_id_9952d245_fk_stock_rollspec_id FOREIGN KEY (spec_id) REFERENCES public.stock_rollspec(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: DATABASE "turf-portal"; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE "turf-portal" TO "turf-portal-user";


--
-- PostgreSQL database dump complete
--

