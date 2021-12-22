SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE `das_database`;
USE `das_database`;
-- ----------------------------
-- Table structure for t_account_info
-- ----------------------------
DROP TABLE IF EXISTS `t_account_info`;
CREATE TABLE `t_account_info`
(
    `id`                    bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`          bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'Hash-Index',
    `account_id`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'hash of account',
    `account`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `owner_chain_type`      smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `owner`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'owner address',
    `owner_algorithm_id`    smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `manager_chain_type`    smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `manager`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'manager address',
    `manager_algorithm_id`  smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `status`                smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `registered_at`         bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `expired_at`            bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `confirm_proposal_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `created_at`            timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`            timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_account` (`account`) USING BTREE,
    KEY `k_account_id` (`account_id`) USING BTREE,
    KEY `k_oct_o` (`owner_chain_type`, `owner`) USING BTREE,
    KEY `k_mct_m` (`manager_chain_type`, `manager`) USING BTREE,
    KEY `k_confirm_proposal_hash` (`confirm_proposal_hash`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='current account info';

-- ----------------------------
-- Table structure for t_block_info
-- ----------------------------
DROP TABLE IF EXISTS `t_block_info`;
CREATE TABLE `t_block_info`
(
    `id`           bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number` bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `block_hash`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `parent_hash`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `created_at`   timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`   timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_block_number` (`block_number`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='for block rollback';

-- ----------------------------
-- Table structure for t_income_cell_info
-- ----------------------------
DROP TABLE IF EXISTS `t_income_cell_info`;
CREATE TABLE `t_income_cell_info`
(
    `id`              bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`    bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `action`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'tx type about income cell in DAS',
    `outpoint`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `capacity`        bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `block_timestamp` bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `status`          smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT 'tx status 0: not consolidate 1: consolidated',
    `created_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_outpoint` (`outpoint`) USING BTREE,
    KEY `k_block_number` (`block_number`) USING BTREE,
    KEY `k_action` (`action`) USING BTREE,
    KEY `k_bn_a` (`block_number`, `action`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='consolidate status of income cell';

-- ----------------------------
-- Table structure for t_rebate_info
-- ----------------------------
DROP TABLE IF EXISTS `t_rebate_info`;
CREATE TABLE `t_rebate_info`
(
    `id`                 bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`       bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `invitee_account`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `invitee_chain_type` smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `invitee_address`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `reward_type`        smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '1: invite 2: channel',
    `reward`             bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT 'reward amount',
    `action`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `service_type`       smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '1: register 2: trade',
    `inviter_args`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `inviter_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'account id of inviter',
    `inviter_account`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'inviter account',
    `inviter_chain_type` smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `inviter_address`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'address of inviter',
    `block_timestamp`    bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `created_at`         timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`         timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_o_rt` (`outpoint`, `reward_type`) USING BTREE,
    KEY `k_invitee_account` (`invitee_account`) USING BTREE,
    KEY `k_inviter_account` (`inviter_account`) USING BTREE,
    KEY `k_ict_ia` (`invitee_chain_type`, `invitee_address`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='the reward of inviter(channel)';

-- ----------------------------
-- Table structure for t_records_info
-- ----------------------------
DROP TABLE IF EXISTS `t_records_info`;
CREATE TABLE `t_records_info`
(
    `id`         bigint(20) unsigned                                            NOT NULL AUTO_INCREMENT COMMENT '',
    `account`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '' COMMENT '',
    `key`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '',
    `type`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '',
    `label`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '',
    `value`      varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
    `ttl`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '',
    `created_at` timestamp                                                      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at` timestamp                                                      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `k_account` (`account`) USING BTREE,
    KEY `k_value` (`value`(768)) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='records info in DAS account setting';

-- ----------------------------
-- Table structure for t_token_price_info
-- ----------------------------
DROP TABLE IF EXISTS `t_token_price_info`;
CREATE TABLE `t_token_price_info`
(
    `id`              bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `token_id`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `gecko_id`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'the id from coingecko',
    `chain_type`      smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `contract`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `name`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'the name of token',
    `symbol`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'the symbol of token',
    `decimals`        smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `price`           decimal(50, 8)                                                NOT NULL DEFAULT '0.00000000' COMMENT '',
    `logo`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `change_24_h`     decimal(50, 8)                                                NOT NULL DEFAULT '0.00000000' COMMENT '',
    `vol_24_h`        decimal(50, 8)                                                NOT NULL DEFAULT '0.00000000' COMMENT '',
    `market_cap`      decimal(50, 8)                                                NOT NULL DEFAULT '0.00000000' COMMENT '',
    `last_updated_at` bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `status`          smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '0: normal 1: banned',
    `created_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_gecko_id` (`gecko_id`) USING BTREE,
    UNIQUE KEY `uk_token_id` (`token_id`) USING BTREE,
    KEY `k_ct_c` (`chain_type`, `contract`) USING BTREE,
    KEY `k_symbol` (`symbol`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='token price from coingecko';

-- ----------------------------
-- Records of t_token_price_info
-- ----------------------------
BEGIN;
INSERT INTO `t_token_price_info`
VALUES (1, 'ckb_ckb', 'nervos-network', 0, '', 'Nervos Network', 'CKB', 8, 0.02033430,
        'https://assets.coingecko.com/coins/images/9566/large/Nervos.png?1568877603', -1.09242466, 21385548.65429164,
        575904812.52536030, 1636082501, 0, '2021-11-03 15:08:32', '2021-11-05 11:22:47');
INSERT INTO `t_token_price_info`
VALUES (2, 'eth_eth', 'ethereum', 1, '', 'Ethereum', 'ETH', 18, 4536.80000000,
        'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1547034048', -0.51578618,
        19180416628.32662200, 534244388965.71280000, 1636082533, 0, '2021-11-03 15:08:32', '2021-11-05 11:22:47');
INSERT INTO `t_token_price_info`
VALUES (3, 'btc_btc', 'bitcoin', 2, '', 'Bitcoin', 'BTC', 8, 62141.00000000,
        'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579', -0.62315617, 33343375772.91655300,
        1166765302940.07520000, 1636082534, 0, '2021-11-03 15:08:32', '2021-11-05 11:22:47');
INSERT INTO `t_token_price_info`
VALUES (4, 'tron_trx', 'tron', 3, '', 'TRON', 'TRX', 6, 0.10413300,
        'https://assets.coingecko.com/coins/images/1094/large/tron-logo.png?1547035066', -1.04175951,
        1713054559.89670470, 7436268641.99625900, 1636082522, 0, '2021-11-03 15:08:32', '2021-11-05 11:22:47');
INSERT INTO `t_token_price_info`
VALUES (6001, 'wx_cny', '_wx_cny_', 4, '', 'WeChat Pay', '¥', 2, 0.15620000, '/images/components/wechat_pay.png',
        0.00000000, 0.00000000, 0.00000000, 1636082387, 0, '2021-11-03 15:08:32', '2021-11-05 11:19:47');
COMMIT;

-- ----------------------------
-- Table structure for t_trade_deal_info
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_deal_info`;
CREATE TABLE `t_trade_deal_info`
(
    `id`              bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`    bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `account`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `deal_type`       smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '0: sale 1: auction',
    `sell_chain_type` int(11)                                                       NOT NULL DEFAULT '0' COMMENT '',
    `sell_address`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `buy_chain_type`  int(11)                                                       NOT NULL DEFAULT '0' COMMENT '',
    `buy_address`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `price_ckb`       bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT 'price in CKB',
    `price_usd`       decimal(50, 8)                                                NOT NULL DEFAULT '0.00000000' COMMENT 'price in dollar',
    `block_timestamp` bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `created_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_outpoint` (`outpoint`) USING BTREE,
    KEY `k_sct_sa` (`sell_chain_type`, `sell_address`) USING BTREE,
    KEY `k_bct_ba` (`buy_chain_type`, `buy_address`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='the records of successful account trade';

-- ----------------------------
-- Table structure for t_trade_info
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_info`;
CREATE TABLE `t_trade_info`
(
    `id`                 bigint(20) unsigned                                            NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`       bigint(20) unsigned                                            NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '' COMMENT '',
    `account`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '' COMMENT '',
    `owner_algorithm_id` smallint(6)                                                    NOT NULL DEFAULT '0' COMMENT '',
    `owner_chain_type`   smallint(6)                                                    NOT NULL DEFAULT '0' COMMENT '',
    `owner_address`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL DEFAULT '' COMMENT '',
    `description`        varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '',
    `started_at`         bigint(20) unsigned                                            NOT NULL DEFAULT '0' COMMENT '',
    `block_timestamp`    bigint(20) unsigned                                            NOT NULL DEFAULT '0' COMMENT '',
    `price_ckb`          bigint(20) unsigned                                            NOT NULL DEFAULT '0' COMMENT '',
    `price_usd`          decimal(50, 8)                                                 NOT NULL DEFAULT '0.00000000' COMMENT '',
    `profit_rate`        int(11) unsigned                                               NOT NULL DEFAULT '100' COMMENT '',
    `status`             smallint(6)                                                    NOT NULL DEFAULT '0' COMMENT '0: normal 1: on sale 2: on auction',
    `created_at`         timestamp                                                      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`         timestamp                                                      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_account` (`account`) USING BTREE,
    KEY `k_oct_oa` (`owner_chain_type`, `owner_address`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='sale/auction info';

-- ----------------------------
-- Table structure for t_transaction_info
-- ----------------------------
DROP TABLE IF EXISTS `t_transaction_info`;
CREATE TABLE `t_transaction_info`
(
    `id`              bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`    bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `account`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `action`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `service_type`    smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '1: register 2: trade',
    `chain_type`      smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `address`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `capacity`        bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `block_timestamp` bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `status`          smallint(6)                                                   NOT NULL DEFAULT '0' COMMENT '0: normal -1: rejected',
    `created_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uk_a_o` (`action`, `outpoint`) USING BTREE,
    KEY `k_a_a` (`account`, `action`) USING BTREE,
    KEY `k_ct_a` (`chain_type`, `address`) USING BTREE,
    KEY `k_ct_a_a` (`chain_type`, `address`, `action`) USING BTREE,
    KEY `k_outpoint` (`outpoint`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='trade info';

-- ----------------------------
-- Table structure for t_reverse_info
-- ----------------------------
DROP TABLE IF EXISTS `t_reverse_info`;
CREATE TABLE `t_reverse_info`
(
    `id`              BIGINT(20) UNSIGNED                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`    BIGINT(20)                                                    NOT NULL DEFAULT '0' COMMENT '',
    `block_timestamp` BIGINT(20)                                                    NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`        VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `algorithm_id`    SMALLINT(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `chain_type`      SMALLINT(6)                                                   NOT NULL DEFAULT '0' COMMENT '',
    `address`         VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `account`         VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `capacity`        BIGINT(20)                                                    NOT NULL DEFAULT '0' COMMENT '',
    `created_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (id),
    UNIQUE KEY uk_outpoint (outpoint),
    KEY k_address (chain_type, address),
    KEY k_account (account)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='reverse records info';

-- ----------------------------
-- Table structure for t_offer_info
-- ----------------------------
DROP TABLE IF EXISTS `t_offer_info`;
CREATE TABLE `t_offer_info`
(
    `id`              bigint(20) unsigned                                           NOT NULL AUTO_INCREMENT COMMENT '',
    `block_number`    bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `outpoint`        varchar(255)                                                  NOT NULL DEFAULT '' COMMENT '',
    `account`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '',
    `algorithm_id`    int(11)                                                       NOT NULL DEFAULT '0' COMMENT '',
    `chain_type`      int(11)                                                       NOT NULL DEFAULT '0' COMMENT '',
    `address`         varchar(255)                                                  NOT NULL DEFAULT '' COMMENT '',
    `block_timestamp` bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `price`           bigint(20) unsigned                                           NOT NULL DEFAULT '0' COMMENT '',
    `message`         varchar(2048)                                                 NOT NULL DEFAULT '' COMMENT '',
    `inviter_args`    varchar(255)                                                  NOT NULL DEFAULT '' COMMENT '',
    `channel_args`    varchar(255)                                                  NOT NULL DEFAULT '' COMMENT '',
    `created_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
    `updated_at`      timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_outpoint` (`outpoint`),
    KEY `k_account` (`account`),
    KEY `k_ct_a` (`chain_type`, `address`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='bid info';

SET
    FOREIGN_KEY_CHECKS = 1;
