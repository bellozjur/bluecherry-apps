--
-- Table structure for table: ipCameras
--
CREATE TABLE ipCameras (
	id integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
	type CHAR(30),
	manufacturer CHAR(30),
	model CHAR(30),
	compression CHAR(30),
	resolutions CHAR(250)
);

--
-- Temporary data (fill in completely later)
--
INSERT INTO ipCameras VALUES (1, 'Camera', 'ACTi', 'CAM-5201', 'MPEG4', '720x480-30,352x240-30,160x112-30');
INSERT INTO ipCameras VALUES (2, 'Camera', 'ACTi', 'CAM-5221', 'MPEG4', '720x480-30,352x240-30,160x112-30');
INSERT INTO ipCameras VALUES (3, 'Camera', 'Axis', '209FD', 'MPEG4,MJPEG', '640x480-30,320x240-30');
INSERT INTO ipCameras VALUES (4, 'Camera', 'Axis', 'M3011', 'MPEG4,H264,MJPEG', '1280x800-30FPS,1280x720-30,640x480-30,320x240-30');