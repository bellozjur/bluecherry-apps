CREATE TABLE AvailableSources (
	id integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
	devicepath varchar(255),
	name varchar(255),
	driver varchar(255),
	status boolean,
	alsasounddev varchar(255),
	card_id INT(2) NOT NULL DEFAULT 0
);

CREATE TABLE Devices (
	id integer PRIMARY KEY NOT NULL AUTO_INCREMENT,	-- Unique ID for this device
	device_name varchar(100),		-- User given name
	resolutionX smallint,
	resolutionY smallint,
	contol_path varchar(255),		-- ??
	protocol varchar(50),			-- IP or V4L2
	remote_host varchar(255),		-- Host/IP for IP cams
	remote_path varchar(255),		-- ??
	remote_port varchar(5),			-- ?? Should be in host:port field?
	invert boolean,				-- True if cam is inverted
	source_video varchar(255),		-- Path to device for local cam
	channel varchar(255),			-- ?? Channel if camera supports it
	source_audio_in varchar(255),		-- Alsa device name for audio capt
	source_audio_out varchar(255),		-- Alsa device name for audio out
	audio_volume smallint DEFAULT 50,	-- Audio gain (0 - 100)
	audio_rate integer,			-- Sample rate of audio from device
	audio_format integer,			-- Bit field (bc-server.h)
						-- AUD_FMT_PCM_U8          0x00000001
						-- AUD_FMT_PCM_S8          0x00000002
						-- AUD_FMT_PCM_U16_LE      0x00000004
						-- AUD_FMT_PCM_S16_LE      0x00000008
						-- AUD_FMT_PCM_U16_BE      0x00000010
						-- AUD_FMT_PCM_S16_BE      0x00000020
	audio_channels smallint,		-- 1/2 (mono/stereo)
	saturation smallint  DEFAULT 50,	-- 0 - 100 (50 default)
	brightness smallint  DEFAULT 50,	-- 0 - 100 (50 default)
	hue smallint  DEFAULT 50,		-- 0 - 100 (50 default)
	contrast smallint  DEFAULT 50,		-- 0 - 100 (50 default)
	video_quality smallint DEFAULT 2,	-- 2 default (range 1-3, l/m/h))
	video_interval smallint,		-- Interval of encoding (fps-ish)
	signal_type varchar(6),			-- NTSC or PAL
	buffer_prerecording smallint DEFAULT 5,	-- Seconds of pre/post recording for
	buffer_postrecording smallint DEFAULT 5,--   motion stop/start
	ptz_contol_path varchar(255),		-- Serial port device for PTZ
	ptz_control_protocol varchar(15),	-- Protocol for PTZ controls
	ptz_baud_rate varchar(6),		-- Baudrate and such for PTZ (8,n,1)
	ip_ptz_control_type smallint,		-- Control type of IP PTZ
	preset_type_ID smallint,		-- ??
	motion_map BLOB(400),			-- motion map
	schedule CHAR(168),			-- Recording schedule
	schedule_override_global BOOLEAN NOT NULL DEFAULT 0,
						-- Whether to override the glibal
	disabled boolean DEFAULT FALSE,		-- If this camera is disabled
	UNIQUE (device_name)
);