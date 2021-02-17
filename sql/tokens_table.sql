CREATE TABLE IF NOT EXISTS `tokens` (
  `identifier` varchar(35) NOT NULL,
  `name` varchar(255) DEFAULT '',
  `n_tokens` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;